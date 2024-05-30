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
        stage ('Build Docker Image') {
            steps {
                sh 'docker build -t troanh1508/maven-app:2.0 .'
            }
        }
        stage ('Deploy to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker push troanh1508/maven-app:2.0'
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
            emailext body: "Completed successfully. ${BUILD_URL}", subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) succeeded", to: 'looksunnoglare@gmail.com'
        }
        unstable {
            echo 'I am unstable :/'
        }
        failure {
            echo 'I failed :('
            emailext body: "Please go to ${BUILD_URL} and verify the build", subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) failed", to: 'looksunnoglare@gmail.com'                
        }
        changed {
            echo 'Things were different before...'
        }
    }
}
