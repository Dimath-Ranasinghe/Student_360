const { testRequest } = require('../utils');
const Message = require('../../src/models/Message');

describe('Message Controller Tests', () => {
  describe('POST /api/messages', () => {
    it('should create a new message', async () => {
      const messageData = {
        text: 'This is a test message',
        from: 'user1',
        to: 'user2'
      };

      const response = await testRequest()
        .post('/api/messages')
        .send(messageData);

      expect(response.status).toBe(201);
      expect(response.body.text).toBe(messageData.text);
      expect(response.body.from).toBe(messageData.from);
      expect(response.body.to).toBe(messageData.to);
      
      // Verify message was saved to database
      const messages = await Message.find({});
      expect(messages.length).toBe(1);
      expect(messages[0].text).toBe(messageData.text);
    });

    it('should return 400 if required fields are missing', async () => {
      const incompleteData = {
        text: 'This is a test message',
        from: 'user1'
        // Missing 'to' field
      };

      const response = await testRequest()
        .post('/api/messages')
        .send(incompleteData);

      expect(response.status).toBe(400);
      expect(response.body.message).toContain('required');
    });
  });

  describe('GET /api/messages', () => {
    it('should get messages between two users', async () => {
      // Create some test messages
      await Message.create([
        { text: 'Message 1', from: 'user1', to: 'user2' },
        { text: 'Message 2', from: 'user2', to: 'user1' },
        { text: 'Message 3', from: 'user1', to: 'user3' }
      ]);

      const response = await testRequest()
        .get('/api/messages')
        .query({ from: 'user1', to: 'user2' });

      expect(response.status).toBe(200);
      expect(response.body.length).toBe(2);
      
      // Should include messages in both directions
      const fromUser1 = response.body.find(msg => msg.from === 'user1' && msg.to === 'user2');
      const fromUser2 = response.body.find(msg => msg.from === 'user2' && msg.to === 'user1');
      
      expect(fromUser1).toBeDefined();
      expect(fromUser2).toBeDefined();
    });

    it('should return empty array if no messages exist between users', async () => {
      const response = await testRequest()
        .get('/api/messages')
        .query({ from: 'nonexistent1', to: 'nonexistent2' });

      expect(response.status).toBe(200);
      expect(response.body.length).toBe(0);
    });
  });
});