const express = require('express');
const app = express();
app.use(express.json());
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Feedback Feature Backend');
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
//connect to mongodb
const mongoose = requires ('mongoose');
const mongoURI = process.env.MONGO_URI ||'mongodb://localhost:27017/feedbackApp';
mongoose.connect(mongoURI, {useNewUrlParser: true, useUnifiedTopology: true})
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('MongoDB connection error:', err));