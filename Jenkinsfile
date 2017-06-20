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
                    ansiblePlaybook credentialsId: 'pradeep-cloud-user', extras: "-e app_env=qa -e app_name=petclinic -e app_ver=${env.BUILD_NUMBER}", playbook: 'deploy/main.yml', sudoUser: null
                    ansiblePlaybook credentialsId: 'pradeep-cloud-user', playbook: 'deploy/test.yml', sudoUser: null
                }
            }
        }
        stage("staging") {
            steps {
                script {
                    ansiblePlaybook credentialsId: 'pradeep-cloud-user', extras: "-e app_env=staging -e app_name=petclinic -e app_ver=${env.BUILD_NUMBER}", playbook: 'deploy/main.yml', sudoUser: null
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
