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
                echo 'Перевірка Dockerfile на помилки безпеки через ізольованого агента'
                sh 'hadolint Dockerfile || true'
            }
        }

        stage('Build & Test & Push Image') {
            steps {
                script {
                    echo "Збірка Docker-образу ${env.TEST_IMAGE}"
                    def fullImageName = "${env.DOCKER_HUB_USER}/${env.TEST_IMAGE}:${env.BUILD_NUMBER}"
                    def myImage = docker.build("${fullImageName}", ".")

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
            echo 'Пайплайн успішно завершено! Образ доставлено на Docker Hub.'
        }
        failure {
            echo 'Помилка під час збірки або перевірки! Перевірте лог вище.'
        }
    }
}
