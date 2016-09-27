#!groovy
node{
	
	currentBuild.result = "SUCCESS"
	
	try{
		stage('Checkout'){
			env.PATH = "${tool 'Maven'}/bin:${env.PATH}"
    		checkout scm
		}
		stage('Build Docker'){
    	    sh "docker build -t devserver2.corp.skysoft-atm.com:5000/skysoft/hazelcast-server:3.7.1 --rm --pull=true ."
    	}
    	stage('Push Docker'){
    		sh "docker push devserver2.corp.skysoft-atm.com:5000/skysoft/hazelcast-server:3.7.1"
    	}
	}
	catch(err) {
		currentBuild.result = "FAILURE"
		throw err
	}
}