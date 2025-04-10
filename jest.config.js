module.exports = {
  testEnvironment: 'node',
  verbose: true,
  testTimeout: 30000,
  collectCoverage: true,
  coveragePathIgnorePatterns: [
    '/node_modules/',
    '/tests/fixtures/'
  ],
  setupFilesAfterEnv: ['./tests/setup.js', './jest.setup.js'],
  moduleDirectories: ['node_modules', 'src'],
  rootDir: './'
};