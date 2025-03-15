const User = require('../models/User');

exports.searchUser = async (req, res) => {
  const { userId } = req.query;
  try {
    const user = await User.findOne({ userId });
    if (user) {
      res.json(user);
    } else {
      res.status(404).json({ message: 'User not found' });
    }
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.createUser = async (req, res) => {
  const { userId, name, role } = req.body;
  const user = new User({ userId, name, role });
  try {
    const savedUser = await user.save();
    res.status(201).json(savedUser);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};
