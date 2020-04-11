pipeline {
	agent any
	environment {
		CI = 'true'
		API = './LagerAPI-1.0'
	}
	stages {
		stage('Login APIM Environments') {
			steps {
				withCredentials([usernamePassword(credentialsId: 'wso2envs', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
					sh './config.sh'
				}
			}
		}
		stage('Deploy to Test Environment') {
			environment {
				ENV = 'test'
				RETRY = '80'
			}
			steps {
				echo 'Deploying to Test Environment'
				sh 'apictl import-api -f $API -e $ENV -k --preserve-provider=false --update --verbose'
			}
		}
		stage('Deploy to Production Environment') {
			environment {
				ENV = 'prod'
				RETRY = '60'
			}
			steps {
				echo 'Deploying to Production Environment'
				sh 'apictl import-api -f $API -e $ENV -k --preserve-provider=false --update --verbose'
			}
		}
	}
}
