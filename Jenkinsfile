pipeline {
    agent any

    environment {
        IMAGE_NAME = 'arvindbhatia123/hello-world-app'
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

        stage('Run Docker Container') {
            steps {
                // You can change 8090 if port is in use
                bat "docker run -d -p 8090:80 %IMAGE_NAME%"
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
                echo 'Running tests...'
                // Add actual test commands if needed
            }
        }

        stage('Success Message') {
            steps {
                echo 'Docker image built, pushed, and container running successfully!'
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed!'
        }
    }
}
