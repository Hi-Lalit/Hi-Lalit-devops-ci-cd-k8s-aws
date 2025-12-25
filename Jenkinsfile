pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gautam009/flask-app:latest"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh "docker build -t flask-app ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'USERNAME',
                        passwordVariable: 'PASSWORD'
                    )
                ]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh 'docker push flask-app'
                }
            }
        }

    }   // ✅ THIS WAS MISSING

    post {
        always {
            echo 'Cleaning up unused Docker images...'
            sh 'docker image prune -f'
        }
    }
}
