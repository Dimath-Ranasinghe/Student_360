require("dotenv").config();

const http = require("http");
const app = require("./src/app");
const connectDB = require("./src/config/db");

connectDB();
const server = http.createServer(app);

server.listen(process.env.PORT || 5000, () => console.log(`Server running`));
