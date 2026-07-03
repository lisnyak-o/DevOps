import requests
import json

URL = "http://127.0.0.1:5000/students"
results_file = open("results.txt", "w", encoding="utf-8")

def log_and_print(text):
    print(text)
    results_file.write(text + "\n")

def log_response(step_name, response):
    log_and_print(f"=== {step_name} ===")
    log_and_print(f"Status Code: {response.status_code}")
    try:
        log_and_print(f"Response Body:\n{json.dumps(response.json(), indent=4, ensure_ascii=False)}")
    except:
        log_and_print(f"Response Text: {response.text}")
    log_and_print("-" * 40)

# 1. Отримати всіх наявних студентів
res = requests.get(URL)
log_response("1. GET ALL STUDENTS (INITIAL)", res)

# 2. Створити трьох студентів
s1 = {"first_name": "Олександр", "last_name": "Петренко", "age": 20}
s2 = {"first_name": "Марія", "last_name": "Іванова", "age": 22}
s3 = {"first_name": "Дмитро", "last_name": "Коваленко", "age": 19}

res1 = requests.post(URL, json=s1)
res2 = requests.post(URL, json=s2)
res3 = requests.post(URL, json=s3)
log_response("2. POST STUDENT 1", res1)
log_response("2. POST STUDENT 2", res2)
log_response("2. POST STUDENT 3", res3)

# 3. Отримати інформацію про всіх наявних студентів
res = requests.get(URL)
log_response("3. GET ALL STUDENTS AFTER POST", res)

# 4. Оновити вік другого студента (PATCH)
res = requests.patch(f"{URL}/2", json={"age": 23})
log_response("4. PATCH STUDENT 2 (AGE TO 23)", res)

# 5. Отримати інформацію про другого студента
res = requests.get(f"{URL}?id=2")
log_response("5. GET STUDENT 2 BY ID", res)

# 6. Оновити імʼя, прізвище та вік третього студента (PUT)
updated_s3 = {"first_name": "Тарас", "last_name": "Шевченко", "age": 25}
res = requests.put(f"{URL}/3", json=updated_s3)
log_response("6. PUT STUDENT 3", res)

# 7. Отримати інформацію про третього студента
res = requests.get(f"{URL}?id=3")
log_response("7. GET STUDENT 3 BY ID", res)

# 8. Отримати всіх наявних студентів
res = requests.get(URL)
log_response("8. GET ALL STUDENTS", res)

# 9. Видалити першого користувача
res = requests.delete(f"{URL}/1")
log_response("9. DELETE STUDENT 1", res)

# 10. Отримати всіх наявних студентів
res = requests.get(URL)
log_response("10. GET ALL STUDENTS (FINAL)", res)

results_file.close()
print("Тестування завершено! Результати записано в results.txt.")
