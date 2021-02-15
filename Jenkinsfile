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
                    sh "docker tag hello-brunch:latest 10.250.8.1:5050/root/hello-brunch:latest"
                    sh "docker push 10.250.8.1:5050/root/hello-brunch:latest"
                }
            }
        }
    }
}
