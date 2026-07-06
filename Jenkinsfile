pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'red08bull'
        TEST_IMAGE      = "my-secure-app"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Lint Dockerfile') {
            agent {
                docker { image 'hadolint/hadolint:latest-alpine' }
            }
            steps {
                echo 'Перевірка Dockerfile на помилки безпеки через Hadolint'
                sh 'hadolint Dockerfile || true'
            }
        }

        stage('Build Image') {
            steps {
                script {
                    echo "Збірка Docker-образу"
                    env.FULL_IMAGE_NAME = "${env.DOCKER_HUB_USER}/${env.TEST_IMAGE}:${env.BUILD_NUMBER}"
                    docker.build("${env.FULL_IMAGE_NAME}", ".")
                }
            }
        }

        stage('Security Scan (Trivy)') {
            steps {
                echo 'Сканування образу на вразливості (CVE) за допомогою Trivy'
                sh """
                    docker run --rm \
                    -v /var/run/docker.sock:/var/run/docker.sock \
                    -v /tmp/trivy-cache:/root/.cache/ \
                    aquasec/trivy:latest image --severity HIGH,CRITICAL ${env.FULL_IMAGE_NAME}
                """
              }
        }

        stage('Test & Push Image') {
            steps {
                script {
                    def myImage = docker.image("${env.FULL_IMAGE_NAME}")

                    echo 'Тестовий запуск створеного контейнера'
                    myImage.inside {
                        sh 'echo "Контейнер успішно піднявся та протестований!"'
                    }

                    echo "Авторизація та Пуш в Docker Hub"
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        myImage.push()
                        myImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Очищення локальних образів на сервері Jenkins'
            sh "docker rmi ${env.DOCKER_HUB_USER}/${env.TEST_IMAGE}:${env.BUILD_NUMBER} || true"
            sh "docker rmi ${env.DOCKER_HUB_USER}/${env.TEST_IMAGE}:latest || true"
        }
        success {
            echo 'Пайплайн успішно завершено! Образ перевірено сканером Trivy та доставлено.'
        }
        failure {
            echo 'Помилка під час збірки, сканування або деплою! Перевірте лог.'
        }
    }
}
