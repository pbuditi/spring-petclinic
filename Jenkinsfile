pipeline {
    agent any
    triggers {
        pollSCM("")
    }
    stages {
        stage("Checkut") {
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
                }
            }
        }
        stage("SonarQube analysis") {
            tools {
                sonarQube 'SonarQube Scanner 2.8'
            }
            steps {
              withSonarQubeEnv('SonarQube') {
                 sh 'sonar-scanner'
              }
           }
       }
  }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
            archive "target/*.jar"
        }
    }
}
