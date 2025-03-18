const express = require("express");
const usersController = require("../controllers/userController");

const router = express.Router();

router.get("/search", usersController.searchUser);
router.post("/", usersController.createUser);

module.exports = router;
