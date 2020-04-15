pipeline {
	agent any
	environment {
		CI = 'true'
		API = './LagerAPI-1.0.0'
		CONTEXT = 'wso'
	}
	stages {
		stage('Deploy to Test Environment') {
			environment {
				ENV = 'test'
				RETRY = '80'
			}
			steps {
				echo 'Logging into $ENV'
				withCredentials([usernamePassword(credentialsId: 'wso2envs', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
					sh 'apictl login $ENV -u $USERNAME -p $PASSWORD -k'
				}
				echo 'Deploying to Test Environment'
				sh "sed -i 's/$CONTEXT/$ENV' $API/Meta-information/api.yaml"
				sh 'apictl import-api -f $API -e $ENV -k --preserve-provider=false --update --verbose'
			}
		}
		stage('Deploy to Production Environment') {
			environment {
				ENV = 'prod'
				RETRY = '60'
			}
			steps {
				echo 'Logging into $ENV'
				withCredentials([usernamePassword(credentialsId: 'wso2envs', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
					sh 'apictl login $ENV -u $USERNAME -p $PASSWORD -k'
				}
				echo 'Deploying to Production Environment'
				sh "sed -i 's/$CONTEXT/$ENV' $API/Meta-information/api.yaml"
				sh 'apictl import-api -f $API -e $ENV -k --preserve-provider=false --update --verbose'
			}
		}
	}
}
