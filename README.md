# Summary
An example project demonstrating how you can build <a href="https://github.com/spring-projects/spring-petclinic">spring-petclinic</a> github project using Jenkins pipeline and Docker.

## Prerequisite 
Jenkins machine with default plugins installed + Docker installed on the machine - see instructions <a href="https://jenkins.io/doc/book/installing/">here</a>

## Setting up Jenkins pipeline
1. Login to Jenkins, create a new item based Multibranch Pipeline.
2. Select as Branch Sources -> GitHub
3. Under Repository HTTPS URL, add this github repo url - https://github.com/yaprigal/SpringPetClinic.git

## The Jenkinsfile
