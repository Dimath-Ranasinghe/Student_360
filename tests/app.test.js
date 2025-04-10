const { testRequest } = require('./utils');

describe('App Integration Tests', () => {
  it('should respond to the root route', async () => {
    const response = await testRequest().get('/');
    
    expect(response.status).toBe(200);
    expect(response.text).toBe('Student360 Backend is Running...');
  });
  
  it('should return 404 for non-existent routes', async () => {
    const response = await testRequest().get('/non-existent-route');
    
    expect(response.status).toBe(404);
  });
  
  it('should handle CORS headers', async () => {
    const response = await testRequest()
      .get('/')
      .set('Origin', 'http://example.com');
    
    expect(response.headers['access-control-allow-origin']).toBeTruthy();
  });
  
  it('should parse JSON body', async () => {
    const response = await testRequest()
      .post('/api/notices')
      .send({ title: 'Test Notice', content: 'Test Content' });
    
    expect(response.status).toBe(201);
    expect(response.body.notice.title).toBe('Test Notice');
  });
});