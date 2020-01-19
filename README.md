# Summary
An example project demonstrating how you can build <a href="https://github.com/spring-projects/spring-petclinic">spring-petclinic</a> github project using Jenkins pipeline and Docker.

## Prerequisite 
Jenkins machine with default plugins installed + Docker installed on the machine - see instructions <a href="https://jenkins.io/doc/book/installing/">here</a>

## Setting up Jenkins pipeline
1. Login to Jenkins, create a new item based Multibranch Pipeline.
2. Select as Branch Sources -> GitHub
3. Under Repository HTTPS URL, add this github repo url - https://github.com/yaprigal/SpringPetClinic.git
4. (Optional) In case you would like to push resulted docker image to docker hub - add Docker Hub credential under Credential -> Global Credential, set the new credential ID as: dockerhub

## The Jenkinsfile
The Jenkins pipeline based on docker agent from docker image: <b>yaronpr/mavenwithdocker:3.6.1-alpine</b><br>
This image is based on <b>maven:3.6.1-alpine</b> image just with docker client install on it.<br>
Why we need this new docker image ? It's allow us to run docker commands during the Jenkins CI process.<br>

