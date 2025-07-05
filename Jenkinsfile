pipeline {
    agent any

    environment {
        IMAGE_NAME = 'arvindbhatia123/hello-world-app'
        CONTAINER_NAME = 'hello-world-container'
        HOST_PORT = '8091'
        CONTAINER_PORT = '80'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/arvind0272/Assignment.git'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME% ."
            }
        }

        stage('Clean Up Existing Container') {
            steps {
                // Stops and removes existing container if running
                bat """
                docker stop %CONTAINER_NAME% || exit 0
                docker rm %CONTAINER_NAME% || exit 0
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                bat "docker run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'docker push %IMAGE_NAME%'
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running tests (placeholder)...'
                // Insert test scripts or curl healthcheck here
            }
        }

        stage('Success Message') {
            steps {
                echo "✅ Deployment successful. App is running at http://localhost:%HOST_PORT%"
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline failed. Check logs above."
        }
        always {
            echo "📝 Pipeline execution complete."
        }
    }
}
