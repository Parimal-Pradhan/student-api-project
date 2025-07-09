pipeline {
    agent any

    environment {
        IMAGE = "yourdockerhub/student-api"
        TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/yourusername/student-api.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE:$TAG ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push $IMAGE:$TAG"
                }
            }
        }

        stage('Deploy to Kubernetes with Helm') {
            steps {
                sh "helm upgrade --install student-api helm/student-api --set image.repository=$IMAGE --set image.tag=$TAG"
            }
        }
    }
}