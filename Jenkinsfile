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
                // Optional: Stop any running container on port 8090
                // Uncomment if needed
                /*
                bat '''
                    FOR /F "tokens=*" %%i IN ('docker ps -q --filter "publish=8090"') DO docker stop %%i
                '''
                */

                // Use port 8090 instead of 8080 to avoid conflicts
                bat 'docker run -d -p 8090:80 %IMAGE_NAME%'
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
                echo 'Test stage - no tests configured yet.'
            }
        }

        stage('Success Message') {
            steps {
                echo '✅ CI/CD pipeline executed successfully!'
            }
        }
    }
}
