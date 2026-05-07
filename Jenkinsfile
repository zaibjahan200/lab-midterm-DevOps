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

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Train Model (inside container)') {
            steps {
                sh "docker run --rm -v \$(pwd):/app ${IMAGE_NAME} python train.py"
            }
        }

        stage('Restart API Container') {
            steps {
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
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
            echo "Deployment successful: API running on port 8000"
        }
        failure {
            echo "Pipeline failed - check logs"
        }
    }
}