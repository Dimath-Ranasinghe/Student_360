const fs = {
  existsSync: jest.fn().mockReturnValue(true),
  unlinkSync: jest.fn(),
  readFileSync: jest.fn(),
  writeFileSync: jest.fn()
};

module.exports = fs;