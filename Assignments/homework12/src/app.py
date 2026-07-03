from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)
CSV_FILE = 'students.csv'

def read_students():
    if not os.path.exists(CSV_FILE):
        return []
    with open(CSV_FILE, mode='r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        return list(reader)

def write_students(students):
    with open(CSV_FILE, mode='w', encoding='utf-8', newline='') as f:
        fieldnames = ['id', 'first_name', 'last_name', 'age']
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(students)

#Method GET /students 
@app.route('/students', methods=['GET'])
def get_students():
    students = read_students()
    student_id = request.args.get('id')
    last_name = request.args.get('last_name')

    #Find with ID
    if student_id:
        student = next((s for s in students if s['id'] == student_id), None)
        if not student:
            return jsonify({"error": f"Student with ID {student_id} not found"}), 404
        return jsonify(student), 200

    #Find by last_name
    if last_name:
        filtered = [s for s in students if s['last_name'].lower() == last_name.lower()]
        if not filtered:
            return jsonify({"error": f"Students with last name '{last_name}' not found"}), 404
        return jsonify(filtered), 200

    #Return all students
    return jsonify(students), 200

#Method POST /students
@app.route('/students', methods=['POST'])
def create_student():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing request body"}), 400

    allowed_fields = {'first_name', 'last_name', 'age'}
    # Check for non-existent fields
    if not set(data.keys()).issubset(allowed_fields):
        return jsonify({"error": "Request contains invalid fields"}), 400

    #Check for required fields
    for field in allowed_fields:
        if field not in data:
            return jsonify({"error": f"Missing required field: {field}"}), 400

    students = read_students()
    
    # Generation ID (find max number and + 1)
    if not students:
        next_id = "1"
    else:
        next_id = str(max(int(s['id']) for s in students) + 1)
    
    #stucture new student
    new_student = {
        "id": next_id,
        "first_name": str(data['first_name']),
        "last_name": str(data['last_name']),
        "age": str(data['age'])
    }
    
    students.append(new_student)
    write_students(students) # update list in students.csv 
    return jsonify(new_student), 201 # return created new student and code-status

#Method PUT /students/<id>
@app.route('/students/<student_id>', methods=['PUT'])
def update_student_put(student_id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing request body"}), 400

    allowed_fields = {'first_name', 'last_name', 'age'}
    if not set(data.keys()).issubset(allowed_fields) or not data:
        return jsonify({"error": "Invalid or empty fields"}), 400

    for field in allowed_fields:
        if field not in data:
            return jsonify({"error": f"Missing required field for PUT: {field}"}), 400

    students = read_students()
    
    student = next((s for s in students if s['id'] == student_id), None)
    if not student:
        return jsonify({"error": f"Student with ID {student_id} not found"}), 404

    #Use 3 fields, because use method PUT in HTTP is required fields
    student['first_name'] = str(data['first_name'])
    student['last_name'] = str(data['last_name'])
    student['age'] = str(data['age'])

    write_students(students)
    return jsonify(student), 200

#Method PATCH /students/<id>
@app.route('/students/<student_id>', methods=['PATCH'])
def update_student_patch(student_id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing request body"}), 400

    if list(data.keys()) != ['age']:
        return jsonify({"error": "PATCH body must contain ONLY the 'age' field"}), 400

    students = read_students()
    student = next((s for s in students if s['id'] == student_id), None)
    if not student:
        return jsonify({"error": f"Student with ID {student_id} not found"}), 404

    student['age'] = str(data['age'])
    write_students(students)
    return jsonify(student), 200

#Method DELETE /students/<id>
@app.route('/students/<student_id>', methods=['DELETE'])
def delete_student(student_id):
    students = read_students()
    student = next((s for s in students if s['id'] == student_id), None)
    if not student:
        return jsonify({"error": f"Student with ID {student_id} not found"}), 404

    students = [s for s in students if s['id'] != student_id]
    write_students(students)
    return jsonify({"message": f"Student with ID {student_id} successfully deleted"}), 200

if __name__ == '__main__':
    app.run(debug=True, port=5000)
