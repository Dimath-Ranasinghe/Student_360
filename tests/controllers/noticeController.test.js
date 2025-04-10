const { testRequest, generateObjectId } = require('../utils');
const path = require('path');
const Notice = require(path.join(__dirname, '../../src/models/Notice'));

describe('Notice Controller Tests', () => {
  describe('POST /api/notices', () => {
    it('should create a new notice', async () => {
      const noticeData = {
        title: 'Test Notice',
        content: 'This is a test notice content.'
      };

      const response = await testRequest()
        .post('/api/notices')
        .send(noticeData);

      expect(response.status).toBe(201);
      expect(response.body.message).toBe('Notice created successfully');
      expect(response.body.notice.title).toBe(noticeData.title);
      expect(response.body.notice.content).toBe(noticeData.content);
      
      // Verify notice was saved to database
      const notices = await Notice.find({});
      expect(notices.length).toBe(1);
      expect(notices[0].title).toBe(noticeData.title);
    });

    it('should return 400 if title or content is missing', async () => {
      const incompleteData = {
        title: 'Test Notice'
        // Missing content
      };

      const response = await testRequest()
        .post('/api/notices')
        .send(incompleteData);

      expect(response.status).toBe(400);
      expect(response.body.error).toBe('Title and content are required');
    });
  });

  describe('GET /api/notices', () => {
    it('should get all notices', async () => {
      // Create some test notices
      await Notice.create([
        { title: 'Notice 1', content: 'Content 1' },
        { title: 'Notice 2', content: 'Content 2' },
        { title: 'Notice 3', content: 'Content 3' }
      ]);

      const response = await testRequest()
        .get('/api/notices');

      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Notices fetched successfully');
      expect(response.body.data.length).toBe(3);
      // Notices should be sorted by date in descending order
      expect(new Date(response.body.data[0].date).getTime())
        .toBeGreaterThanOrEqual(new Date(response.body.data[2].date).getTime());
    });

    it('should return empty array if no notices exist', async () => {
      const response = await testRequest()
        .get('/api/notices');

      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Notices fetched successfully');
      expect(response.body.data.length).toBe(0);
    });
  });

  describe('DELETE /api/notices/:id', () => {
    it('should delete an existing notice', async () => {
      // Create a test notice
      const notice = await Notice.create({
        title: 'Test Notice to Delete',
        content: 'This notice will be deleted'
      });

      const response = await testRequest()
        .delete(`/api/notices/${notice._id}`);

      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Notice deleted successfully');
      
      // Verify notice was deleted
      const deletedNotice = await Notice.findById(notice._id);
      expect(deletedNotice).toBeNull();
    });

    it('should return 404 if notice to delete does not exist', async () => {
      const nonExistentId = generateObjectId();
      
      const response = await testRequest()
        .delete(`/api/notices/${nonExistentId}`);

      expect(response.status).toBe(404);
      expect(response.body.error).toBe('Notice not found');
    });
  });
});