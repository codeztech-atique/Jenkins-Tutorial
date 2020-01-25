#!/usr/bin/groovy
pipeline {
	agent any
	stages {
		stage('Pull Code from Master Branch') {
			steps {
				echo 'Pulling code from master..'
				sshagent(credentials: ['ubuntu'], ignoreMissing: true) {
                   sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 13.235.114.111 "cd ./youtube_angular7__weather_forcast_testing; git pull origin master"'
			    }
            }
        }
		stage('Prepare Environment') {
			steps {
				echo 'Prepare Environment'
				sshagent(credentials: ['ubuntu'], ignoreMissing: true) {
                  sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 13.235.114.111 "cd ./youtube_angular7__weather_forcast_testing; npm install; "'
                }
            }
		}

		stage('Unit Test') {
			steps {
                sshagent(credentials: ['ubuntu'], ignoreMissing: true) {
                    sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 13.235.114.111 "cd ./youtube_angular7__weather_forcast_testing; ng test --source-map=false --watch=false"'
                }
            }
		}
        
		stage('Deploy') {
			steps {
				echo 'Deploying....'
                sshagent(credentials: ['ubuntu'], ignoreMissing: true) {
                    sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 13.235.114.111 "cd ./youtube_angular7__weather_forcast_testing; pm2 start app.sh"'
                }
        	}
		}
	}
}
