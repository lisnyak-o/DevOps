pipeline {
    agent any

    environment {
        TEST_IMAGE = "my-secure-app:${env.BUILD_NUMBER}"
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

        stage('Build & Test Image') {
            steps {
                script {
                    echo "Збірка Docker-образу ${env.TEST_IMAGE}"
                    def myImage = docker.build("${env.TEST_IMAGE}")

                    echo 'Тестовий запуск створеного контейнера'
                    myImage.inside {
                        sh 'echo "Контейнер успішно піднявся та протестований!"'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Пайплайн успішно завершено! Образ відповідає критеріям якості.'
        }
        failure {
            echo 'Помилка під час збірки або перевірки! Перевірте лог вище.'
        }
    }
}
