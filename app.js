// Load environment variables from .env file into process.env
require('dotenv').config();
const express = require('express');
const connectDB = require('./config/db');
const teacherProfileRoutes = require('./routes/teacherProfileRoutes');

// Initialize the Express application
const app = express();

// Connect to MongoDB
connectDB();

// Middleware to parse incoming JSON requests
app.use(express.json());

// Define API routes for teacher profiles
app.use('/api/teachers', teacherProfileRoutes);

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});