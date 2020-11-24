# What?

Nexus is a repository manager.  
A repository is a storage (think of it as a warehouse) of software components.  
A repository may be public/external/remote (Maven Central, NPM) or private/internal/local.  
A repository manager presents a signle repository endpoint while acting as a  
- proxy and cache for remote repositories  
- local repository  

## Component

A component is the managed item. It can be a package, library, binay, container,
archive and so on.

Typical components are archives. They are composed of other files, such as .class
files, text files, binary files and so on. 

Examples are .jar, .war, .ear, .zip, .tar.gz, rpm, .exe, .sh, .apk, etc.

Components are identified by a set of values that depends on the format used.
In case of Maven format, those values are:  
- Artifact Id
- Group Id
- Version

## Format

The structure of a component, its metadata and the communication protocol for storing,
retrieaving and indexing it, is called a format.   

Some of the formats supported by nexus are:  

- Bower
- Docker
- git-lfs
- Maven 2
- npm
- NuGet
- PyPI
- RubyGems
- Raw (Site)
- Yum

Nuget is a package manager for .Net.  

## Repositoty types

There are 3 types of managed repositories: proxies, hosted and groups.  
To access public repositories, we may go for proxy.
To have a non-public internal repository, we may go for hosted one.
To group multiple repositories of the same format and access them via single URL, that's the 
typical use of groups.

By default, nexus is configured with 
- maven-central and nuget.org-proxy proxies.
- maven-releases/snapshots, nuget-hosted hosted repositories.
- maven-public and nuget-group groups.

## Configure maven to use nexus

### As a proxy repository

Edit the .m2/settings.xml file to add mirror :

```xml
<settings>
  <mirrors>
    <mirror>
      <!--This sends everything else to /public -->
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>http://localhost:8081/repository/maven-proxy-test/</url>
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>nexus</id>
      <!--Enable snapshots for the built in central repo to direct -->
      <!--all requests to nexus via the mirror -->
      <repositories>
        <repository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </repository>
      </repositories>
     <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
<activeProfiles>
    <!--make the profile active all the time -->
    <activeProfile>nexus</activeProfile>
  </activeProfiles>
  <servers>
    <server>
      <id>nexus</id>
      <username>admin</username>
      <password>password</password> 
    </server>
  </servers>
</settings>

```

This configuration lets the nexus deployed on localhost:8081 to act
as a proxy between clients (POMs based projects, mvn commands) and
public Maven central repository.

For example, in empty folder let's create pom.xml 

```xml
<project>
 <modelVersion>4.0.0</modelVersion>

 <groupId>com.example</groupId>
 <artifactId>nexus-proxy</artifactId>
 <version>1.0-SNAPSHOT</version>

 <dependencies>

  <dependency>
   <groupId>junit</groupId>
   <artifactId>junit</artifactId>
   <version>4.10</version>
  </dependency>

 </dependencies>

</project>
```

This is a Project.

Let's generate a package out of it.

$ mvn package

This commands will download all dependencie from the proxy repository 
maven-proxy-test, 

The result is generated in target sub-folder.

```shell
❯ pwd && tree
~/maven/sample
.
├── pom.xml
└── target
    ├── maven-archiver
    │   └── pom.properties
    └── nexus-proxy-1.0-SNAPSHOT.jar

2 directories, 3 files
```

Here is an extract of mvn package command output

```shell
❯ mvn package
[INFO] Scanning for projects...
[INFO] 
[INFO] ----------------------< com.example:nexus-proxy >-----------------------
[INFO] Building nexus-proxy 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
Downloading from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/maven/plugins/maven-resources-plugin/2.6/maven-resources-plugin-2.6.pom
Downloaded from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/maven/plugins/maven-resources-plugin/2.6/maven-resources-plugin-2.6.pom (8.1 kB at 9.5 kB/s)
Downloading from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/maven/plugins/maven-plugins/23/maven-plugins-23.pom
Downloaded from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/maven/plugins/maven-plugins/23/maven-plugins-23.pom (9.2 kB at 56 kB/s)
Downloading from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/maven/maven-parent/22/maven-parent-22.pom
Downloaded from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/maven/maven-parent/22/maven-parent-22.pom (0 B at 0 B/s)
Downloading from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/apache/11/apache-11.pom
Downloaded from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/apache/11/apache-11.pom (0 B at 0 B/s)
Downloading from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/maven/plugins/maven-resources-plugin/2.6/maven-resources-plugin-2.6.jar
Downloaded from nexus: http://localhost:8081/repository/maven-proxy-test/org/apache/maven/plugins/maven-resources-plugin/2.6/maven-resources-plugin-2.6.jar (30 kB at 252 kB/s)
...
```

### As a hosted repository

Let us configure our POM project to store its built packages
into a local, internal, private hosted repository.

In the case of Maven, two option are possible for hosted 
repositories: snapshots and releaes. 

Releases are for solid, stable and ready to be published to
production.  

Snapshots are for packages under heavy developments, that are
meant to be generated many times as part of a continous development 
and integration process.

In pom.xml file we need to add the following  

```xml
<distributionManagement>
  <repository>
  <id>nexus</id>
  <name>maven-releases</name>
  <url>http://localhost:8081/repository/maven-releases/</url>
 </repository>
 <snapshotRepository>
  <id>nexus</id>
  <name>maven-snapshots</name>
  <url>http://localhost:8081/repository/maven-snapshots/</url>
 </snapshotRepository>
</distributionManagement>
```

If we leave the version with -SNAPSHOT suffix, then Maven will
generate a snapshot and thus use the corresponding repository.

$ mvn clean deploy  

(notice the uploading lines)

```shell
[INFO] --- maven-deploy-plugin:2.7:deploy (default-deploy) @ nexus-proxy ---
Downloading from nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/1.0-SNAPSHOT/maven-metadata.xml
Downloaded from nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/1.0-SNAPSHOT/maven-metadata.xml (766 B at 4.5 kB/s)
Uploading to nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/1.0-SNAPSHOT/nexus-proxy-1.0-20201123.164156-2.jar
Uploaded to nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/1.0-SNAPSHOT/nexus-proxy-1.0-20201123.164156-2.jar (1.5 kB at 11 kB/s)
Uploading to nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/1.0-SNAPSHOT/nexus-proxy-1.0-20201123.164156-2.pom
Uploaded to nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/1.0-SNAPSHOT/nexus-proxy-1.0-20201123.164156-2.pom (682 B at 7.0 kB/s)
Downloading from nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/maven-metadata.xml
Downloaded from nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/maven-metadata.xml (280 B at 7.6 kB/s)
Uploading to nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/1.0-SNAPSHOT/maven-metadata.xml
Uploaded to nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/1.0-SNAPSHOT/maven-metadata.xml (766 B at 6.7 kB/s)
Uploading to nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/maven-metadata.xml
Uploaded to nexus: http://localhost:8081/repository/maven-snapshots/com/example/nexus-proxy/maven-metadata.xml (280 B at 3.0 kB/s)
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.836 s
[INFO] Finished at: 2020-11-23T17:41:57+01:00
[INFO] ------------------------------------------------------------------------

```

Now, if I remove the -SNAPSHOT and run the same command again

```xml
 <!-- version>1.0-SNAPSHOT</version -->
 <version>1.0</version>
```

$ mvn clean deploy

Notice that the uploading target has changed now, and is leading to maven-releases. 

```shell
[INFO] --- maven-deploy-plugin:2.7:deploy (default-deploy) @ nexus-proxy ---
Uploading to nexus: http://localhost:8081/repository/maven-releases/com/example/nexus-proxy/1.0/nexus-proxy-1.0.jar
Uploaded to nexus: http://localhost:8081/repository/maven-releases/com/example/nexus-proxy/1.0/nexus-proxy-1.0.jar (1.5 kB at 4.0 kB/s)
Uploading to nexus: http://localhost:8081/repository/maven-releases/com/example/nexus-proxy/1.0/nexus-proxy-1.0.pom
Uploaded to nexus: http://localhost:8081/repository/maven-releases/com/example/nexus-proxy/1.0/nexus-proxy-1.0.pom (713 B at 5.1 kB/s)
Downloading from nexus: http://localhost:8081/repository/maven-releases/com/example/nexus-proxy/maven-metadata.xml
Uploading to nexus: http://localhost:8081/repository/maven-releases/com/example/nexus-proxy/maven-metadata.xml
Uploaded to nexus: http://localhost:8081/repository/maven-releases/com/example/nexus-proxy/maven-metadata.xml (298 B at 3.6 kB/s)
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.819 s
[INFO] Finished at: 2020-11-23T17:51:57+01:00
[INFO] ------------------------------------------------------------------------
```

