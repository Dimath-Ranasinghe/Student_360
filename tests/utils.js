const request = require('supertest');
const app = require('../src/app');
const Student = require('../src/models/student');
const Teacher = require('../src/models/teacher');
const mongoose = require('mongoose');

// Helper to create a student for testing
const createTestStudent = async (overrides = {}) => {
  // Create data for a test student
  const studentData = {
    studentID: 'S12345',
    name: 'Test Student',
    grade: 3,
    class: 'A',
    username: 'teststudent',
    password: 'hashed_password',
    ...overrides
  };

  // Skip the middleware by directly creating and inserting the document
  const result = await Student.collection.insertOne(studentData);
  return await Student.findById(result.insertedId);
};

// Helper to create a teacher for testing
const createTestTeacher = async (overrides = {}) => {
  // Create data for a test teacher
  const teacherData = {
    teacherID: 'T12345',
    name: 'Test Teacher',
    username: 'testteacher',
    password: 'hashed_password', // Pre-hashed password
    ...overrides
  };

  // Skip the middleware by directly creating and inserting the document
  const result = await Teacher.collection.insertOne(teacherData);
  return await Teacher.findById(result.insertedId);
};

// Helper for making HTTP requests
const testRequest = () => request(app);

// Generate a valid MongoDB ObjectId
const generateObjectId = () => new mongoose.Types.ObjectId().toString();

module.exports = {
  createTestStudent,
  createTestTeacher,
  testRequest,
  generateObjectId
};