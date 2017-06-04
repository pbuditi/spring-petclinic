pipeline {
    agent any
    triggers {
        pollSCM("")
    }
    stages {
        stage("Prepare environment") {
            steps {
                checkout scm
            }
        }
        stage("Build") {
            steps {
                script {
                    sh './mvnw install -DskipTests=true -Dmaven.javadoc.skip=true -B -V'
                }
            }
        }
        stage("Test") {
            steps {
                script {
                    sh './mvnw test -B'
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage("Cleanup") {
            steps{
                script {
                    deleteDir()
                    // after the push to nexus, we need to clean-up the docker image on the server
                }
            }
        }
    }
}
