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
                    sh "docker tag nginx-brunch:latest 10.250.8.1:5050/root/hello-brunch:latest"
                    sh "docker push 10.250.8.1:5050/root/hello-brunch:latest"                                
                    sshagent(credentials:['SSH_Git']){
                        sh 'git tag BUILD-1.${BUILD_NUMBER}'
                        sh 'git push --tags'
                    }
                }
            }
        }
        stage('Deploy'){
            steps{
                sshagent(credentials:['deploy_ssh']){
                    sh "ssh -t -o "StrictHostKeyChecking no" deploy@10.250.8.1 'docker-compose pull && docker-compose up -d'"                  
                }
            }
        }
    }
}
