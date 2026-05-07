pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        IMAGE_NAME = "ml-api"
        CONTAINER_NAME = "ml-container"
        REPO_URL = "https://github.com/zaibjahan200/lab-midterm-DevOps.git"
        BRANCH = "master"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: "${BRANCH}", url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image (includes training)') {
            steps {
                sh "docker build --no-cache -t ${IMAGE_NAME} ."
            }
        }

        stage('Stop Old Container') {
            steps {
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
            }
        }

        stage('Run Container') {
            steps {
                sh "docker run -d -p 8000:8000 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
            }
        }

        stage('Health Check') {
            steps {
                sh "sleep 5"
                sh "curl http://localhost:8000/metrics || true"
            }
        }
    }

    post {
        success {
            echo "SUCCESS: ML API deployed with trained model inside image"
        }
        failure {
            echo "FAILED: check Docker build or app logs"
        }
    }
}