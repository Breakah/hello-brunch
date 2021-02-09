#!/usr/bin/env groovy

pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages {
        stage('Build') {
            steps {
                git url:'https://github.com/Breakah/hello-brunch.git',branch:'main' 
                sh 'docker-compose build'
            }
        }
	stage('Trivy') {
            steps {
                sh 'trivy filesystem -f json -o trivy-fs-json'
                sh 'trivy image --format json --output trivy-image.json hellobrunchjenkinfile_web:latest'
            }
            post {
                always {
                	recordIssues enabledForFailure: true, aggregatingResults:true, tool: trivy(pattern: 'trivy-*.json')
                }
            }
        }
		
        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
}
