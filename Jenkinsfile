#!/usr/bin/env groovy

pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker-compose build'
            }
        }
		
        stage('Publish') {
            steps {
                withDockerRegistry([credentialsId:"gitlab_registry",url:"http://10.250.8.1:5050"]){
                    sh "docker tag nginx-brunch:latest 10.250.8.1:5050/root/hello-brunch:BUILD-1.${BUILD_NUMBER}"
                    sh "docker push 10.250.8.1:5050/root/hello-brunch:BUILD-1.${BUILD_NUMBER}"   
                                
                    sshagent(credentials:['SSH_Git']){
                        sh 'git tag BUILD-1.${BUILD_NUMBER}'
                        sh 'git push --tags'
                    }
                }
            }
        }
    }
}
