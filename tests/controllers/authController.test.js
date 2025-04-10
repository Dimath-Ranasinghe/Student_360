const { testRequest, createTestStudent, createTestTeacher } = require('../utils');

// Mock bcrypt for faster tests
jest.mock('bcrypt');
const bcrypt = require('bcrypt');

beforeEach(() => {
  // Reset mock implementations before each test
  bcrypt.compare.mockReset();
});

describe('Auth Controller Tests', () => {
  describe('POST /api/auth/login', () => {
    it('should login with valid student credentials', async () => {
      // Create a test student
      const student = await createTestStudent();
      
      // Mock bcrypt.compare to return true (valid password)
      bcrypt.compare.mockResolvedValueOnce(true);
      
      const response = await testRequest()
        .post('/api/auth/login')
        .send({
          userID: student.studentID,
          password: 'password123'
        });
      
      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Login successful');
      expect(response.body.role).toBe('student');
    });

    it('should login with valid teacher credentials', async () => {
      // Create a test teacher
      const teacher = await createTestTeacher();
      
      // Mock bcrypt.compare to return true (valid password)
      bcrypt.compare.mockResolvedValueOnce(true);
      
      const response = await testRequest()
        .post('/api/auth/login')
        .send({
          userID: teacher.teacherID,
          password: 'password123'
        });
      
      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Login successful');
      expect(response.body.role).toBe('teacher');
    });

    it('should return 400 if userID or password are missing', async () => {
      const response = await testRequest()
        .post('/api/auth/login')
        .send({
          userID: 'S12345'
          // Missing password
        });
      
      expect(response.status).toBe(400);
      expect(response.body.message).toBe('Missing user ID or password');
    });

    it('should return 401 if userID is invalid', async () => {
      const response = await testRequest()
        .post('/api/auth/login')
        .send({
          userID: 'nonexistentID',
          password: 'password123'
        });
      
      expect(response.status).toBe(401);
      expect(response.body.message).toBe('Invalid user ID or password');
    });

    it('should return 401 if password is invalid', async () => {
      // Create a test student
      const student = await createTestStudent();
      
      // Mock bcrypt.compare to return false (invalid password)
      bcrypt.compare.mockResolvedValueOnce(false);
      
      const response = await testRequest()
        .post('/api/auth/login')
        .send({
          userID: student.studentID,
          password: 'wrongpassword'
        });
      
      expect(response.status).toBe(401);
      expect(response.body.message).toBe('Invalid user ID or password');
    });
  });
});