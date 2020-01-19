pipeline {
    environment {
        registry = "yaronpr/yaronpetclinic"
        registryCredential = 'dockerhub'
        myImage = ''
    }
    agent { 
        docker { 
            image 'yaronpr/mavenwithdocker:3.6.1-alpine'
            args '-v /var/run/docker.sock:/var/run/docker.sock'         
        }                 
    }     
    options {
        skipStagesAfterUnstable()
    } 
    stages {
        stage ('Download JCenter Settings') {           
          steps {
            sh 'curl -L "https://bintray.com/repo/downloadMavenRepoSettingsFile/downloadSettings?repoPath=%2Fbintray%2Fjcenter" -o settings.xml'
          }
        }
        stage ('Clone Source') {            
          steps {
            git branch: 'master', url: 'https://github.com/spring-projects/spring-petclinic.git'
          }
        }        
        stage('Compile Source') {            
            steps {
                sh 'mvn -DskipTests -s settings.xml clean package'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }
            }
        }
        stage('Run Tests') {            
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=false -s settings.xml test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Extract Jar') {   
            steps {
                sh 'cd target && jar xvf *.jar '   
            }
        }
        stage('Docker Build') {                         
            steps {       
                echo 'download Dockerfile'
                sh 'curl -L "https://raw.githubusercontent.com/yaprigal/petclinic/master/Dockerfile" -o Dockerfile'                 
                echo 'docker builld start'
                script {        
                    myImage = docker.build  registry + ":${env.BUILD_ID}"
                }
            }
        }
        stage('Docker Push') {                         
            steps {                       
                echo 'docker push start'
                script {        
                    docker.withRegistry( '', registryCredential ) {
                        myImage.push()
                    }    
                }
            }
        }
    }
}