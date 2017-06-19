pipeline {
    agent any
    triggers {
        pollSCM("")
    }
    stages {
        stage("Build") {
            steps {
                script {
                    checkout scm
                    sh './mvnw install -DskipTests=true -Dmaven.javadoc.skip=true -B -V'
                    sh './mvnw test -B'
                }
                withSonarQubeEnv('SonarQube') {
                 sh '/opt/sonar-scanner-3.0.3.778-linux/bin/sonar-scanner'
                }
            }
        }
       stage("qa") {
            steps {
                script {
                    ansiblePlaybook credentialsId: 'pradeep-cloud-user', extras: '-e app_env=qa -e app_name=demo', playbook: 'deploy/main.yml', sudoUser: null
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
