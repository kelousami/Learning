# What is Jenkins
Jenkins is an open source automation server.
It is mainly used to automate actions of building, testing, deploying or delivering software.
It can be installed as a native system package, as Docker image or as standalone java program on JRE.
Jenkins is highly extensible using plugins.
The main feature of Jenkins is Pipeline.

# What is Jenkins Pipeline
Jenkins Pipeline or simply Pipeline is the use of a set of Jenkins plugins in order to implement the process
of continuous delivery pipeline.
Continuous delivery pipeline is the automated expression of the process of getting software from version control
systems right through to custemers and end users.
The definition of Jenkins Pipeline is typically done in Jenkinsfile.
Jenkinsfile is a text file, typically alongside the source of the source code under version control.
Main features of Jenkins Pipeline include: 
 - Code: integrated to source code, being reviewed and versionned.
 - Durable: ability to survive a planned or non-planned restart of Jenkins master.
 - Versatile: ability to perform complex CD required actions, including fork/join, loops and work in parallel.
 - Extensible: variety of ways to custom it including adding new plugins.
 - Pausable: it can stop and wait for human inputs or interaction/approval before continuing the Pipeline run.

# Jenkinsfile 
It provides Pipline as code feature to our project. Being part of the source code of our project, it can be 
reviewed as any other part of the project.
Jenkinsfile can by Declarative or Scripted.

Example:
```
pipeline {
	agent { docker { image 'python:3.5.1' } }
	stages {
		stage('build') {
			steps {
				sh 'python --version'
			}
		}
	}
}
```

# Pipeline Concepts 

## pipeline
`pipeline` block is a key par of Declarative Pipeline syntax.
It describes the entire build process, including building, testing and deploying the software.
 
## node
`node` is a key part of Scripted Pipeline syntax.
It is a machine, part of Jenkins environment, capable of running a Pipeline.  

## stage
`stage` is a subset of tasks of the entire Pipeline.
For example 'build', 'test' and 'deploy' are common used stages.
It is used by many plugins to visualize the status/progress of the Pipeline.

## step
Inside `steps`, a single task is called a step. It's fundamentally telling Jenkins what to do at a certain point of time.


# Declarative Pipeline syntax

One pipeline to do the entire process.

```
pipeline {
	agent any // run this pipeline with all of its stages on any available agent
	stages {
		stage('Build') {
			steps {
				// perform build actions
			}
		}
		stage('Test') {
			steps {
				// perform test actions
			}
		}
		stage('Deploy') {
			steps {
				// perform deploy actions
			}
		}
	}

}
```

# Scripted Pipeline syntax

One or more node blocks do the work.

```
node {
	stage('Build') {
		// perform build actions
	}
}

```

# Jenkins as docker image


## Run it 

docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts

The volume jenkins_home is created by docker on host machine.
It is important that user jenkins (uid=1000) has access to the volume content
on the host machine.




