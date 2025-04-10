const Student = require('../../src/models/student');
const bcrypt = require('bcrypt');

// Mock bcrypt for faster tests
jest.mock('bcrypt', () => ({
  genSalt: jest.fn().mockResolvedValue('salt'),
  hash: jest.fn().mockResolvedValue('hashed_password')
}));

describe('Student Model Tests', () => {
  it('should create a valid student', async () => {
    const studentData = {
      studentID: 'S12345',
      name: 'Test Student',
      grade: 3,
      class: 'A',
      username: 'teststudent',
      password: 'password123'
    };

    const student = new Student(studentData);
    const savedStudent = await student.save();
    
    expect(savedStudent.studentID).toBe(studentData.studentID);
    expect(savedStudent.name).toBe(studentData.name);
    expect(savedStudent.grade).toBe(studentData.grade);
    expect(savedStudent.class).toBe(studentData.class);
    expect(savedStudent.username).toBe(studentData.username);
    
    // Password should be hashed
    expect(savedStudent.password).not.toBe(studentData.password);
    expect(bcrypt.genSalt).toHaveBeenCalled();
    expect(bcrypt.hash).toHaveBeenCalled();
  });

  it('should require all required fields', async () => {
    try {
      const student = new Student({
        // Missing required fields
        name: 'Test Student'
      });
      await student.save();
      // Should not reach here
      expect(true).toBe(false);
    } catch (error) {
      expect(error).toBeDefined();
      expect(error.name).toBe('ValidationError');
      expect(error.errors.studentID).toBeDefined();
      expect(error.errors.grade).toBeDefined();
      expect(error.errors.class).toBeDefined();
      expect(error.errors.username).toBeDefined();
      expect(error.errors.password).toBeDefined();
    }
  });

  it('should validate grade is within enum values', async () => {
    try {
      const student = new Student({
        studentID: 'S12345',
        name: 'Test Student',
        grade: 10,
        class: 'A',
        username: 'teststudent',
        password: 'password123'
      });
      await student.save();
      // Should not reach here
      expect(true).toBe(false);
    } catch (error) {
      expect(error).toBeDefined();
      expect(error.name).toBe('ValidationError');
      expect(error.errors.grade).toBeDefined();
    }
  });

  it('should validate class format', async () => {
    try {
      const student = new Student({
        studentID: 'S12345',
        name: 'Test Student',
        grade: 3,
        class: 'AB', // Not matching /^[A-Z]$/
        username: 'teststudent',
        password: 'password123'
      });
      await student.save();
      // Should not reach here
      expect(true).toBe(false);
    } catch (error) {
      expect(error).toBeDefined();
      expect(error.name).toBe('ValidationError');
      expect(error.errors.class).toBeDefined();
    }
  });

  it('should not hash password if not modified', async () => {
    // Create a student
    const student = new Student({
      studentID: 'S12349',
      name: 'Test Student',
      grade: 3,
      class: 'A',
      username: 'teststudent9',
      password: 'password123'
    });
    await student.save();
    
    // Reset mock
    bcrypt.genSalt.mockClear();
    bcrypt.hash.mockClear();
    
    // Update a field other than password
    student.name = 'Updated Name';
    student.isModified = jest.fn().mockReturnValue(false); // Mock isModified to return false for password
    await student.save();
    
    // Password hash function should not be called
    expect(bcrypt.genSalt).not.toHaveBeenCalled();
    expect(bcrypt.hash).not.toHaveBeenCalled();
  });
});