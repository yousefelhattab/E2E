pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'githubid'  // Replace with your Docker Hub credentials ID
        IMAGE_NAME = 'yousefelhattab/project'  // Replace with your Docker Hub username and image name
        PROMETHEUS_ADMIN_PASSWORD = 'myadminpassword'  // Define Prometheus admin password
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

                    // Deploy Helm Chart (MY gO application)
                    sh 'helm upgrade --install my-helm-chart helm-chart/ --values helm-chart/values.yaml'

                    // Deploy Prometheus and Grafana
                    sh 'helm upgrade --install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace --values helm-chart/templates/prometheus-values.yaml'
                    sh 'helm upgrade --install grafana grafana/grafana --namespace monitoring --set adminPassword=${PROMETHEUS_ADMIN_PASSWORD} --values helm-chart/templates/grafana-values.yaml'
                }
            }
        }

        stage('Check Deployment') {
            steps {
                script {
                    // Check deployments and services
                    sh 'kubectl get deployments -n monitoring'
                    sh 'kubectl get services -n monitoring'
                }
            }
        }

        stage('Port Forward for Prometheus & Grafana') {
            steps {
                script {
                    // Port forwarding Prometheus and Grafana
                    sh 'kubectl port-forward service/prometheus-server 9090:9090 -n monitoring &'  // Prometheus
                    sh 'kubectl port-forward service/grafana 3000:80 -n monitoring &'  // Grafana
                }
            }
        }

        stage('Verify Prometheus & Grafana') {
            steps {
                script {
                    // Verify Prometheus and Grafana are accessible
                    sh 'curl http://localhost:9090'   // Prometheus
                    sh 'curl http://localhost:3000'   // Grafana
                }
            }
        }
    }
}
