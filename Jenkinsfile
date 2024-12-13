"start jenkins with docker sudo docker run -p 8080:8080 -p 50000:50000 -d --restart=always \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/usr/bin/docker \
  --name jenkins jenkins/jenkins:lts "
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

