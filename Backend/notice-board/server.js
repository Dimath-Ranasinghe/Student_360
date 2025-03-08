const express = require('express');
const app = express();
const port = 3000;

// Middleware
app.use(express.json());

// MongoDB Connection
const mongoose = require('mongoose');
mongoose.connect('mongodb://localhost:27017/student', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('MongoDB connected'))
.catch(err => console.error(err));


app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
