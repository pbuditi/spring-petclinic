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
            steps {
              withSonarQubeEnv('SonarQube') {
                 sh '/opt/sonar-scanner-3.0.3.778-linux/bin/sonar-scanner'
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
