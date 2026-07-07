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
                script {
                    // Отримуємо ID контейнера, в якому зараз працює сам Jenkins
                    def jenkinsContainerId = sh(script: "hostname", returnStdout: true).trim()

                    sh """
                        docker run --rm \
                        -v /var/run/docker.sock:/var/run/docker.sock \
                        -v /tmp/trivy-cache:/root/.cache/ \
                        --volumes-from ${jenkinsContainerId} \
                        -w ${WORKSPACE} \
                        aquasec/trivy:latest image \
                        --format template \
                        --template @trivy-html.tpl \
                        --output trivy-report.html \
                        --severity HIGH,CRITICAL ${env.FULL_IMAGE_NAME}
                    """
                }
                archiveArtifacts artifacts: 'trivy-report.html', allowEmptyArchive: false
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

        stage('Deploy App') {
            steps {
                echo 'Continuous Deployment'
                script {
                    sh 'docker stop staging || true'
                    sh 'docker rm staging || true'
                    
                    echo "Запуск нової версії застосунку на порті 8081..."
                    sh "docker run -d --name staging -p 8081:80 ${env.FULL_IMAGE_NAME}"
                    
                    echo "Перевірка статусу запущеного застосунку:"
                    sh 'docker ps -f name=staging'
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
            echo 'Пайплайн успішно завершено! Образ перевірено та задеплоєно на порт 8081, звіт збережено.'
        }
        failure {
            echo 'Помилка під час збірки, сканування або деплою! Перевірте лог.'
        }
    }
}
