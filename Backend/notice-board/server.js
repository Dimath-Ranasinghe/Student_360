const express = require('express');
const app = express();
const noticeRoutes = require('./routes/noticeRoutes');
const port = 3000;
const mongoose = require('mongoose');

// Middleware
app.use(express.json());
app.use((req, res, next) => {
  console.log(`${req.method} ${req.url}`);
  next();
});

// MongoDB Connection
const db = require('./db');
db.then(() => console.log('MongoDB connected')).catch(err => console.error(err));

// Routes
app.use('/api/notices', noticeRoutes);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

require('dotenv').config();
mongoose.connect(process.env.DB_URI);
