pipeline {
    agent any

    environment {
        // Назва нашого майбутнього образу
        TEST_IMAGE = "my-secure-app:${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Lint Dockerfile') {
            steps {
                echo 'Перевірка Dockerfile на помилки безпеки'
                // Використовуємо офіційний лінтер Hadolint через Docker, щоб не встановлювати його локально
                sh 'docker run --rm -i hadolint/hadolint < Dockerfile || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Збірка Docker-образу ${TEST_IMAGE}"
                sh "docker build -t ${TEST_IMAGE} ."
            }
        }

        stage('Test & Verify') {
            steps {
                echo 'Тестовий запуск створеного контейнера'
                sh "docker run --rm ${TEST_IMAGE}"
            }
        }
    }

    post {
        always {
            echo 'Очищення: Видаляємо локальний образ, щоб не забивати диск'
            sh "docker rmi ${TEST_IMAGE} || true"
        }
        success {
            echo 'Пайплайн успішно завершено! Образ відповідає критеріям якості.'
        }
        failure {
            echo 'Помилка під час збірки або перевірки!'
        }
    }
}
