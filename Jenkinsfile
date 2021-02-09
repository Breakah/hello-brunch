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
                sh 'trivy image --format json --output trivy-results.json nginx-brunch'
            }
            post {
                always {
                	recordIssues enabledForFailure: true, tool: trivy(pattern: 'trivy-results.json')
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
