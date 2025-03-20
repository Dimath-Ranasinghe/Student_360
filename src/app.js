const express = require("express");
const cors = require("cors");
const studentRoutes = require("./routes/studentRoutes");
const noticeRoutes = require("./routes/noticeRoutes");
const messageRoutes = require("./routes/messages");
const userRoutes = require("./routes/users");

const app = express();

// Middleware
app.use(express.json());
app.use(cors()); // Added CORS

// Default Route
app.get("/", (req, res) => {
    res.send("Student360 Backend is Running...");
  });

  
// Routes
app.use("/api/students", studentRoutes);
app.use("/api/notices", noticeRoutes);
app.use("/api/messages", messageRoutes);
app.use("/api/users", userRoutes);
app.use('/api/teachers', teacherProfileRoutes);

module.exports = app;
