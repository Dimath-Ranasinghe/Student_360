const express = require('express');
const app = express();
const noticeRoutes = require('./routes/noticeRoutes');
const port = 3000;

// Middleware
app.use(express.json());

// MongoDB Connection
const db = require('./db');
db.then(() => console.log('MongoDB connected')).catch(err => console.error(err));

// Routes
app.use('/api/notices', noticeRoutes);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
