pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'githubid'  // Replace with your Docker Hub credentials ID
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

        stage('Deploy Helm Chart') {
            steps {
                script {
                    // Ensure Helm is installed and Helm repos are added
                    sh 'helm repo add stable https://charts.helm.sh/stable'
                    sh 'helm repo add prometheus-community https://prometheus-community.github.io/helm-charts'
                    sh 'helm repo add grafana https://grafana.github.io/helm-charts'
                    sh 'helm repo update'

                    // Deploy Helm Chart
                    sh 'helm upgrade --install my-helm-chart helm-chart/ --values helm-chart/values.yaml'

                    // Deploy Prometheus and Grafana
                    sh 'helm upgrade --install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace'
                    sh 'helm upgrade --install grafana grafana/grafana --namespace monitoring --set adminPassword=myadminpassword'
                }
            }
        }

        stage('Check Deployment') {
            steps {
                script {
                    sh 'kubectl get deployments'
                    sh 'kubectl get services'
                }
            }
        }
    }
}
