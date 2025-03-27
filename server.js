require("dotenv").config();

const http = require("http");
const app = require("./src/app");
const connectDB = require("./src/config/db");
const socketHandler = require("./src/sockets/socketHandler");
const socketIo = require("socket.io");


connectDB();
const server = http.createServer(app);

const io = socketIo(server, {
    cors: { origin: "*", methods: ["GET", "POST"] },
});

socketHandler(io);

server.listen(process.env.PORT || 3001, () => console.log(`Server running`));
