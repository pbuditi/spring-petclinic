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
          // requires SonarQube Scanner 2.8+
          def scannerHome = tool 'sonar-runner;
           //def scannerHome = "/opt/sonar-runner-2.4"
            withSonarQubeEnv('SonarQube') {
                sh "${scannerHome}/bin/sonar-scanner"
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
