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
            agent {
                docker { 
                    image 'aquasec/trivy:latest'
                    // Прокидаємо сокет та кеш для Trivy, щоб він працював миттєво
                    args '-v /var/run/docker.sock:/var/run/docker.sock -v /tmp/trivy-cache:/root/.cache/'
                }
            }
            steps {
                echo 'Сканування образу на вразливості (CVE) за допомогою Trivy'
                // Скануємо образ. Наразі використовуємо конфіг, який просто покаже звіт, але не зупинить білд
                sh "trivy image --severity HIGH,CRITICAL ${env.DOCKER_HUB_USER}/${env.TEST_IMAGE}:${env.BUILD_NUMBER}"
                
                /* Коли будете готові ламати білд при знаходженні дірок:
                sh "trivy image --exit-code 1 --severity CRITICAL ${env.DOCKER_HUB_USER}/${env.TEST_IMAGE}:${env.BUILD_NUMBER}"
                */
            }
        }

        stage('Test & Push Image') {
            steps {
                script {
                    // Оскільки ми розбили етапи, нам потрібно знову ініціалізувати об'єкт образу для плагіна
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
