const { testRequest } = require('../utils');
const User = require('../../src/models/User');

describe('User Controller Tests', () => {
  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      const userData = {
        userId: 'U12345',
        name: 'Test User',
        role: 'student'
      };

      const response = await testRequest()
        .post('/api/users')
        .send(userData);

      expect(response.status).toBe(201);
      expect(response.body.userId).toBe(userData.userId);
      expect(response.body.name).toBe(userData.name);
      expect(response.body.role).toBe(userData.role);
      
      // Verify user was saved to database
      const savedUser = await User.findOne({ userId: userData.userId });
      expect(savedUser).not.toBeNull();
    });

    it('should validate role field', async () => {
      const userData = {
        userId: 'U54321',
        name: 'Test User',
        role: 'invalid_role' // Not in enum ['teacher', 'student']
      };

      const response = await testRequest()
        .post('/api/users')
        .send(userData);

      expect(response.status).toBe(400);
      expect(response.body.message).toBeTruthy();
    });
  });

  describe('GET /api/users/search', () => {
    it('should find an existing user', async () => {
      // Create a user first
      const user = await User.create({
        userId: 'U12345',
        name: 'Test User',
        role: 'student'
      });

      const response = await testRequest()
        .get('/api/users/search')
        .query({ userId: user.userId });

      expect(response.status).toBe(200);
      expect(response.body.userId).toBe(user.userId);
      expect(response.body.name).toBe(user.name);
      expect(response.body.role).toBe(user.role);
    });

    it('should return 404 if user does not exist', async () => {
      const response = await testRequest()
        .get('/api/users/search')
        .query({ userId: 'nonexistentID' });

      expect(response.status).toBe(404);
      expect(response.body.message).toBe('User not found');
    });
  });
});