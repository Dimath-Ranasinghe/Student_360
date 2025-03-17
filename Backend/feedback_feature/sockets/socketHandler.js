module.exports = function(io) {
    io.on('connection', (socket) => {
      console.log('New client connected');
  
      socket.on('sendMessage', (data) => {
        // send new messages to all connected users
        io.emit('receiveMessage', data);
      });
  
      socket.on('disconnect', () => {
        console.log('Client disconnected');
      });
    });
  };
  