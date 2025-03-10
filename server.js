require('dotenv').config();
const express = require('express');
const connectDB = require('./config/db');
const teacherProfileRoutes = require('./routes/teacherProfileRoutes');
const cors = require('cors');

const app = express();

// Connect to MongoDB
connectDB();

// Middleware
app.use(express.json()); 
app.use(cors()); 

app.use('/api/teachers', teacherProfileRoutes);

app.get('/', (req, res) => {
    res.send('API is running...');
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});