
//Jenkinsfile 
pipeline{
    agent any
    stages{
        stage("sonar quality check"){
            agent {
                docker {
                    image 'openjdk:11'
                }
            }
            steps{
                script{
                    // Print the workspace path for debugging
                    echo "Workspace: ${env.WORKSPACE}"
                    
                    // Print the list of files in the workspace for debugging
                    sh "ls -al ${env.WORKSPACE}"
                    
                    // Print the list of files in the gradle directory for debugging
                    sh "ls -al ${env.WORKSPACE}/gradle"

                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh "chmod +x gradlew"
                        sh "./gradlew sonarqube"
                    }

                }
            }
        }
    }
   
}