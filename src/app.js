const express = require("express");
const cors = require("cors");
const studentRoutes = require("./routes/studentRoutes");

const app = express();

// Middleware
app.use(express.json());
app.use(cors()); // Added CORS
