const mongoose = require('mongoose');
const connectDB = require('../../src/config/db');

describe('Database Connection', () => {
  
  it('should have a connection function', () => {
    expect(typeof connectDB).toBe('function');
  });
  
  it('should use mongoose for database operations', () => {
    expect(mongoose).toBeDefined();
    expect(mongoose.connect).toBeDefined();
  });
});