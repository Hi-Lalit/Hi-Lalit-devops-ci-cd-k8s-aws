pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gautam009/flask-app:latest"
    }

    stages {

        stage('Terraform Apply') {
            steps {
                dir('terraform-aws-infra') {
                    // Make Terraform executable
                    sh 'chmod +x run-terraform.sh'
                    sh './run-terraform.sh'
                }
            }
        }

        stage('Ansible Setup') {
            steps {
                dir('ansible') {
                    // Make Ansible scripts executable
                    sh 'chmod +x run-ansible.sh'
                    sh './run-ansible.sh'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh "docker build -t flask-app ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh "docker push flask-app"
                }
            }
        }

        stage('Deploy Flask App to EC2') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook -i inventory.yml deploy.yml'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up unused Docker images...'
            sh 'docker image prune -f'
        }
    }
}
