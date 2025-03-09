const express = require('express');
const messagesRouter = require('./routees/messages');
const usersRouter = require('./routes/users');
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


//Socket.io for real time communication

const http = require('http');
const socketIo = require('socket.io');

const server = http.createServer(app);
const io = socketIo(server, {cors:{origin:"*",meathods:["GET","POST"]}});
//API
app.use('/api/messages', messagesRouter);
app.use('/api/users', usersRouter);

//Socket.io  for real time communication
io.on('connection', (socket) => {
    console.log('New client connected');
    socket.on('sendMessage',(data)=>{
        io.emit('receiveMessage',data);//mew message
    });
    socket.on('disconnect', () => {
        console.log('Client disconnected');
    });
});

//server
server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
