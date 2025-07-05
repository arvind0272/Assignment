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

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Run Docker Container') {
            steps {
                bat 'docker run -d -p 8080:80 %IMAGE_NAME%'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat '''
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push %IMAGE_NAME%
                    '''
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Test stage - No automated tests configured.'
            }
        }

        stage('Success Message') {
            steps {
                echo '✅ CI/CD pipeline completed successfully!'
            }
        }
    }
}

