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
            echo 'I failed :('
            emailext
                to: 'looksunnoglare@gmail.com',
                body: "Something is wrong with ${env.BUILD_URL}", 
                subject: "Failed Pipeline: ${currentBuild.fullDisplayName}"
        }
        changed {
            echo 'Things were different before...'
        }
    }
}
