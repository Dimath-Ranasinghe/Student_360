const express = require('express');
const mongoose = requires ('mongoose');
const http = require('http');
const socketIo = require('socket.io');
const messagesRouter = require('./routees/messages');
const usersRouter = require('./routes/users');

const app = express();

app.use(express.json());


app.get('/', (req, res) => {
  res.send('Feedback Feature Backend');
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
//connect to mongodb

const mongoURI = process.env.MONGO_URI ||'mongodb://localhost:27017/feedbackApp';
mongoose.connect(mongoURI, {useNewUrlParser: true, useUnifiedTopology: true})
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('MongoDB connection error:', err));





//HTTP server
const server = http.createServer(app);
const io = socketIo(server, {
    cors:{origin:"*",meathods:["GET","POST"]}});
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
const PORT = process.env.PORT || 3000;
//server
server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
