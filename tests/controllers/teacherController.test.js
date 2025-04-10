const { testRequest } = require('../utils');
const Teacher = require('../../src/models/teacher');

describe('Teacher Controller Tests', () => {
  describe('POST /api/teachers/register', () => {
    it('should register a new teacher', async () => {
      const teacherData = {
        teacherID: 'T54321',
        name: 'New Teacher',
        username: 'newteacher',
        password: 'password123'
      };

      const response = await testRequest()
        .post('/api/teachers/register')
        .send(teacherData);

      expect(response.status).toBe(201);
      expect(response.body.message).toBe('Teacher registered successfully');
      expect(response.body.teacher.teacherID).toBe(teacherData.teacherID);
      expect(response.body.teacher.name).toBe(teacherData.name);
      
      // Verify teacher was saved to database
      const savedTeacher = await Teacher.findOne({ teacherID: teacherData.teacherID });
      expect(savedTeacher).not.toBeNull();
      
      // Verify password was hashed
      expect(savedTeacher.password).not.toBe(teacherData.password);
    });

    it('should return 400 if required fields are missing', async () => {
      const incompleteData = {
        teacherID: 'T54321',
        name: 'New Teacher'
        // Missing username and password
      };

      const response = await testRequest()
        .post('/api/teachers/register')
        .send(incompleteData);

      expect(response.status).toBe(400);
      expect(response.body.message).toBe('Missing required fields');
    });

    it('should return 400 if username is already taken', async () => {
      // Create a teacher with this username first
      await Teacher.create({
        teacherID: 'T12345',
        name: 'Existing Teacher',
        username: 'existingteacher',
        password: 'password123'
      });
      
      // Try to create another teacher with the same username
      const response = await testRequest()
        .post('/api/teachers/register')
        .send({
          teacherID: 'T54321',
          name: 'New Teacher',
          username: 'existingteacher',
          password: 'password123'
        });

      expect(response.status).toBe(400);
      expect(response.body.message).toBe('Username already taken');
    });
  });
});