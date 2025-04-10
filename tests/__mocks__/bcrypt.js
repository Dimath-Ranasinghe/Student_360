// Mock implementation of bcrypt
module.exports = {
    genSalt: jest.fn().mockResolvedValue('mock_salt'),
    hash: jest.fn().mockResolvedValue('hashed_password'),
    compare: jest.fn().mockResolvedValue(true)
  };