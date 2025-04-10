const { testRequest, createTestStudent } = require('../utils');
const Student = require('../../src/models/student');
const StudentRecord = require('../../src/models/StudentRecord');

describe('Student Controller Tests', () => {
  describe('POST /api/students/add-student', () => {
    it('should add a new student successfully', async () => {
      const studentData = {
        studentID: 'S54321',
        name: 'New Student',
        grade: 2,
        class: 'B',
        username: 'newstudent',
        password: 'password123'
      };

      const response = await testRequest()
        .post('/api/students/add-student')
        .send(studentData);

      expect(response.status).toBe(201);
      expect(response.body.message).toBe('Student added successfully');
      expect(response.body.student.studentID).toBe(studentData.studentID);
      expect(response.body.student.name).toBe(studentData.name);
      
      // Verify student was saved to database
      const savedStudent = await Student.findOne({ studentID: studentData.studentID });
      expect(savedStudent).not.toBeNull();
    });

    it('should return 400 if required fields are missing', async () => {
      const incompleteData = {
        studentID: 'S54321',
        name: 'New Student'
        // Missing other required fields
      };

      const response = await testRequest()
        .post('/api/students/add-student')
        .send(incompleteData);

      expect(response.status).toBe(400);
      expect(response.body.message).toBe('Missing required fields');
    });

    it('should return 400 if student already exists', async () => {
      // Create a student first
      const student = await createTestStudent();
      
      // Try to create the same student again
      const response = await testRequest()
        .post('/api/students/add-student')
        .send({
          studentID: student.studentID,
          name: 'Duplicate Student',
          grade: 3,
          class: 'A',
          username: 'duplicatestudent',
          password: 'password123'
        });

      expect(response.status).toBe(400);
      expect(response.body.message).toBe('Student already exists');
    });
  });

  describe('POST /api/students/enter-marks', () => {
    it('should enter marks for an existing student', async () => {
      // Create a student first
      const student = await createTestStudent();
      
      const marksData = {
        studentID: student.studentID,
        grade: student.grade,
        class: student.class,
        term: '1st Term',
        subjects: [
          { subjectName: 'Mathematics', marks: 85 },
          { subjectName: 'English', marks: 78 }
        ],
        totalDaysHeld: 100,
        totalDaysAttended: 98
      };

      const response = await testRequest()
        .post('/api/students/enter-marks')
        .send(marksData);

      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Marks updated successfully');
      
      // Verify student record was saved to database
      const savedRecord = await StudentRecord.findOne({ studentID: student.studentID });
      expect(savedRecord).not.toBeNull();
      expect(savedRecord.terms.length).toBe(1);
      expect(savedRecord.terms[0].term).toBe('1st Term');
      
      // Should ensure fixed subjects are included
      expect(savedRecord.terms[0].subjects.length).toBeGreaterThanOrEqual(5); // At least the 5 fixed subjects
    });

    it('should return 404 if student does not exist', async () => {
      const marksData = {
        studentID: 'nonexistentID',
        grade: 3,
        class: 'A',
        term: '1st Term',
        subjects: [
          { subjectName: 'Mathematics', marks: 85 }
        ],
        totalDaysHeld: 100,
        totalDaysAttended: 98
      };

      const response = await testRequest()
        .post('/api/students/enter-marks')
        .send(marksData);

      expect(response.status).toBe(404);
      expect(response.body).toBe('Student not found in the school database.');
    });
  });

  describe('GET /api/students/view-marks/:studentID', () => {
    it('should get marks for an existing student', async () => {
      // Create a student
      const student = await createTestStudent();
      
      // Create a record for this student
      const record = new StudentRecord({
        studentID: student.studentID,
        grade: student.grade,
        class: student.class,
        terms: [{
          term: '1st Term',
          subjects: [
            { subjectName: 'Mathematics', marks: 85 },
            { subjectName: 'English', marks: 78 }
          ],
          totalMarks: 163,
          average: 81.5,
          totalDaysHeld: 100,
          totalDaysAttended: 98
        }]
      });
      await record.save();
      
      const response = await testRequest()
        .get(`/api/students/view-marks/${student.studentID}`);

      expect(response.status).toBe(200);
      expect(response.body.studentID).toBe(student.studentID);
      expect(response.body.terms.length).toBe(1);
      expect(response.body.terms[0].subjects.length).toBe(2);
    });

    it('should return 404 if student record does not exist', async () => {
      const response = await testRequest()
        .get('/api/students/view-marks/nonexistentID');

      expect(response.status).toBe(404);
      expect(response.body.message).toBe('Student not found');
    });
  });

  describe('DELETE /api/students/delete/:studentID', () => {
    it('should delete an existing student record', async () => {
      // Create a student
      const student = await createTestStudent();
      
      // Create a record for this student
      const record = new StudentRecord({
        studentID: student.studentID,
        grade: student.grade,
        class: student.class,
        terms: []
      });
      await record.save();
      
      const response = await testRequest()
        .delete(`/api/students/delete/${student.studentID}`);

      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Student record deleted successfully');
      
      // Verify record was deleted
      const deletedRecord = await StudentRecord.findOne({ studentID: student.studentID });
      expect(deletedRecord).toBeNull();
    });

    it('should return 404 if student record does not exist', async () => {
      const response = await testRequest()
        .delete('/api/students/delete/nonexistentID');

      expect(response.status).toBe(404);
      expect(response.body.message).toBe('Student not found');
    });
  });
});