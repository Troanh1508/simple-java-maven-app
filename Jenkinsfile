pipeline {
    agent any

    tools {
        maven 'M3'
    }
    stages {
        stage('Static Code Analysis') {
            steps {
                build job: 'static-code-analysis'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') { 
            steps {
                sh 'mvn test' 
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml' 
                }
            }
        }
    }
    post {
        always {
            echo 'One way or another, I have finished'
            deleteDir() /* clean up our workspace */
        }
        success {
            echo 'I succeeded!'
            
        }
        unstable {
            echo 'I am unstable :/'
        }
        failure {
            steps{
                echo 'I failed :('
                emailext body: 'Extented email test body', subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) is waiting for input", to: 'looksunnoglare@gmail.com'                
            }
        }
        changed {
            echo 'Things were different before...'
        }
    }
}
