// Mock modules globally for all tests
jest.mock('bcrypt', () => ({
  genSalt: jest.fn().mockResolvedValue('mock_salt'),
  hash: jest.fn().mockResolvedValue('hashed_password'),
  compare: jest.fn().mockResolvedValue(true)
}));