# DevOps & System Administration Journey

Ласкаво просимо до мого репозиторію, де я збираю практичні роботи, конспекти, скрипти та конфігураційні файли, створені в межах мого комплексного 6-місячного плану навчання з DevOps та системного адміністрування.

Цей проєкт відображає мій шлях від базового адміністрування Linux до побудови безпечної, масштабованої та автоматизованої інфраструктури.

---

## 🛠 Стек технологій & Інструменти

* **OS/Environment:** Windows 11 (Host) + WSL2 (Ubuntu 22.04 LTS), Linux (Ubuntu/Debian Сервери)
* **Automation & IaC:** Bash scripting, Ansible
* **Virtualization & Containerization:** Vagrant, VirtualBox, Docker, Docker Desktop, Kubernetes
* **CI/CD & Tools:** Git, GitHub, 1Password CLI (для безпечного керування секретами)
* **Security & Compliance:** DevSecOps практики, IAM, OIDC, знання стандартів ISO 27001 / SOC 2 / PCI DSS

---

## Структура репозиторію та виконані проєкти

Репозиторій розбитий на логічні блоки відповідно до етапів навчання та автоматизації:

### 1. Bash Automation & Server Monitoring (`/bash-scripts`)
Набір скриптів для автоматизації рутинних завдань системного адміністрування та моніторингу стану системи у реальному часі:
* **Directory Watcher:** Скрипт на базі `inotifywait`, який відстежує зміни у директоріях в реальному часі.
* **Disk Usage Alert:** Автоматизований моніторинг дискового простору за допомогою `crontab`, що надсилає сповіщення у разі перевищення критичного ліміту.
* **Server Diagnostics:** Скрипти для аналізу логів та діагностики ядра Linux.

### 2. Infrastructure as Code (IaC) & Provisioning (`/ansible-vagrant`)
Практична реалізація локальної багатокомпонентної інфраструктури:
* **Multi-tier Vagrant Environment:** Розгортання ізольованого середовища з розподілом на App та Database віртуальні машини за допомогою Vagrant та VirtualBox.
* **Ansible Playbooks:** Повна автоматизація конфігурації серверів та розгортання багаторівневого застосунку **PetClinic** (автоматичне налаштування залежностей, конфігурація бази даних та запуск сервісів).

### 3. Containerization & Orchestration (`/docker-k8s`)
* Конфігурація локального середовища розробки (Docker Desktop + WSL2).
* Контейнеризація застосунків, оптимізація Dockerfile та робота з Docker Compose.
* *В процесі:* Вивчення оркестрації за допомогою Kubernetes.

---

## Безпека та Найкращі Практики (DevSecOps)

Усі проєкти розробляються з урахуванням сучасних стандартів безпеки:
* **Secret Management:** Жодних захардкоджених секретів чи паролів у репозиторії. Використовується інтеграція з **1Password CLI** та механізми динамічного підтягування токенів.
* **Доступ:** Налаштування автентифікації на базі безпечних SSH-ключів, інтеграція IAM та OIDC.

---

## 📈 План розвитку (Roadmap)

### Базовий та Середній рівні:
- [x] Автоматизація на Bash та адміністрування Linux (діагностика ядра, керування процесами).
- [x] TCP/IP Network Addressing, Networking tools for troubleshooting, DNS Network connections (NAT/Bridge)
- [x] Firewalls and network security basics, VPN.
- [x] Web Servers (nginx, apache) 
- [x] SSL/TSL, Lets encrypt, Cerbot
- [x] Git flow, setup git server using gitlab
- [x] Database basics (MySQL)
- [x] Оркестрація локальних ВМ (Vagrant) та конфігурація через Ansible.
- [x] REST API, python basic, HTTP requests
- [x] Контейнеризація застосунків (Docker).
- [ ] Глибоке занурення в Kubernetes (K8s).
- [ ] Побудова CI/CD конвеєрів (GitHub Actions / GitLab CI).
- [ ] Моніторинг та логування (Prometheus, Grafana, ELK stack).


### Продвинутий рівень (Advanced DevSecOps):
- [ ] **Cloud & Managed Kubernetes (Azure / AWS)**
    * Вивчення Cloud Fundamentals & Cloud Security.
    * Розгортання та адміністрування керованих кластерів (Azure AKS / AWS EKS).
- [ ] **Просунутий IaC та Конфігурація (Terraform & Terragrunt)**
    * Структурування проєктів Terraform для multi-account / multi-region архітектури за допомогою Terragrunt.
    * Керування залежностями між інфраструктурними модулями.
    * Безпечне зберігання state-файлів у хмарних сховищах (S3 / Azure Blob Storage) із шифруванням та локуванням.
    * Автоматична перевірка конфігурацій за допомогою лінтерів та сканерів безпеки (Checkov, tfsec, KICS) у CI/CD пайплайнах.
- [ ] **Екосистема HashiCorp (Vault, Consul, Nomad)**
    * Централізоване керування секретами (Vault).
    * Service Mesh та Service Discovery (Consul).
- [ ] **Безпека Даних, Черг (Data Security) та Комплайєнс**
    * Захист, шифрування та моніторинг баз даних (PostgreSQL, MongoDB, Cassandra) & Apache Kafka.
    * Практична відповідність інфраструктури стандартам безпеки (SOC 2, ISO 27001, PCI DSS).
- [ ] **CI/CD Security & Incident Response**
    * Впровадження DevSecOps практик (SAST/DAST, сканування образів) в інструменти автоматизації (GitLab CI, Jenkins, GitHub Actions).
    * Побудова процесів моніторингу безпеки та реагування на інциденти.

---
*Created fckngspecial*
