# Summary
An example project demonstrating how you can build <a href="https://github.com/spring-projects/spring-petclinic">spring-petclinic</a> github project using Jenkins pipeline and Docker

## Prerequisite 
Jenkins machine with default plugins installed + Docker installed on the machine - see instructions <a href="https://jenkins.io/doc/book/installing/">here</a>

## Setting up Jenkins pipeline
1. Login to Jenkins, create a new item based Multibranch Pipeline
2. Select as Branch Sources -> GitHub
3. Under Repository HTTPS URL, add this github repo url - https://github.com/yaprigal/SpringPetClinic.git
4. (Optional) In case you would like to push resulted docker image to docker hub - add Docker Hub credential under Credential -> Global Credential, set the new credential ID as: dockerhub

## The Jenkinsfile
The Jenkins pipeline based on docker agent from docker image: <a href="https://hub.docker.com/r/yaronpr/mavenwithdocker"><b>yaronpr/mavenwithdocker:3.6.1-alpine</b></a><br>
This image is based on <b>maven:3.6.1-alpine</b> image just with docker client install on it<br>
Why do we need this new docker image ? It's allow us to run docker commands during the Jenkins CI process<br>
How can we connect to docker engine from this image ? By adding the follwing mount: args '-v /var/run/docker.sock:/var/run/docker.sock'
<br>
#### 1st Step (Download JCenter Settings)
Download the JCenter configuration file - this setting will be used to resolve dependencies from Bintray JCenter<br>
#### 2nd Step (Clone Source)
Clone spring-petclinic project
#### 3rd Step (Compile Source)
Execute mvn command by skipping the tests and passing the JCenter settings file
#### 4th Step (Run Tests)
Execute the tests, making sure the step will fail in case of failure in one of the tests and passing the JCenter settings file<br>
#### 5th Step (Extract Jar)
In order for our docker image to be layer efficiency(3rd parties will be on seperate docker layer)- we are extracting the resulted JAR 
#### 6th Step (Docker Build)
Downloading the Dockerfile (from this repo) and executing the docker build command using the Jenkins plugin for Docker<br>
#### (Optional) 7th Step (Docker Push)
Pushing the resulted Docker image to Docker Hub (with small modification, can be also to other Docker registries)

## The Dockerfile
The base image of the Docker image will openjdk:8-jdk-alpine (Docker size consideration)<br>
We are making sure that we are not running the container with root privileges<br>
We allowing dynamically to change the port that the application will be listening to by passing APP_PORT during docker build or APP_ENV_PORT during execution of docker run command
We are also trying to avoid JVM delays by setting java.security.egd=file:/dev/./urandom" 






