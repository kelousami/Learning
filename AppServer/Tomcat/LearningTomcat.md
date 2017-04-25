
# Basics

## Terminology

A `Context` is a web application.

## Files and Direcories

`$CATALINA_HOME` is the root folder of tomcat installation.
`$CATALINA_BASE` represents an instance folder.

When no instance has been configured, then `$CATALINA_HOME` = `$CATALINA_BASE`

Key tomcat directories:
- `/bin` contains startup, shutdown and other scripts.

- `/conf` configuration files and DTDs. The most important is server.xml which is the main 
configuration file of the container.

- `/logs` default location of log files.

- `/webapps` where web applications are deployed.

## Configuring tomcat

Any change to configuration files necessitates a restart of the container.


# Install



