pipeline {
    agent any

    environment {
        IMAGE_TAG = "myapp:${GIT_COMMIT}"
    }

    stages {

        stage('Checkout') {
            steps {
                git url: 'https://github.com/rajconfig/registration-app.git', branch: 'main'
            }
        }

        stage('Build Docker Images') {
            steps {
                echo "Building Docker images..."
                sh 'docker-compose build'
            }
        }

        stage('Stop Old Containers') {
            steps {
                echo "Stopping old containers..."
                sh '''
                    docker-compose down || true
                '''
            }
        }

        stage('Deploy Containers') {
            steps {
                echo "Starting new containers..."
                sh 'docker-compose up -d'
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Checking running containers..."
                sh 'docker ps'
            }
        }
    }

    post {
        always {
            echo "Cleaning up unused images"
            sh 'docker image prune -f'
        }
        success {
            echo "Deployment successful!"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
