
pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'Docker'  // Replace with your Docker Hub credentials ID
        IMAGE_NAME = 'yousefelhattab/project'     // Replace with your Docker Hub username and image name
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t ${IMAGE_NAME}:latest .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push Docker image to Docker Hub
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID]) {
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }
}

