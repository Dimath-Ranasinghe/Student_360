const express = require('express');
const dotenv = require('dotenv');
const morgan = require('morgan');
const cors = require('cors');
const fileUpload = require('express-fileupload');
const path = require('path');

// Load env vars
dotenv.config();

// Connect to database
const connectDB = require('./config/db');
connectDB();

// Route files
const studentProfileRoutes = require('./routes/studentProfileRoutes');

const app = express();

// Body parser
app.use(express.json());

// Enable CORS
app.use(cors());

// File upload middleware
app.use(fileUpload());

// Set static folder
app.use(express.static(path.join(__dirname, 'public')));

// Dev logging middleware
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
}

// Mount routers
app.use('/api/students', studentProfileRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    error: 'Server Error'
  });
});

// Home route
app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to Student 360'
  });
});

module.exports = app;