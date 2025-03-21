// Get all student profiles
exports.getStudentProfiles = async (req, res) => {
    try {
        let query;
      
        const reqQuery = { ...req.query };
        
        // Fields to exclude
        const removeFields = ['select', 'sort', 'page', 'limit'];
        
        // Loop over removeFields and delete them from reqQuery
        removeFields.forEach(param => delete reqQuery[param]);
        
        // Create query string
        let queryStr = JSON.stringify(reqQuery);
        
        // Create operators ($gt, $gte, etc)
        queryStr = queryStr.replace(/\b(gt|gte|lt|lte|in)\b/g, match => `$${match}`);
        
        // Finding resource
        query = StudentProfile.find(JSON.parse(queryStr));
              
        // Select fields
        if (req.query.select) {
            const fields = req.query.select.split(',').join(' ');
            query = query.select(fields);
        }
      
        // Sort
        if (req.query.sort) {
            const sortBy = req.query.sort.split(',').join(' ');
            query = query.sort(sortBy);
        } else {
            query = query.sort('name');
        }
      
        // Pagination
        const page = parseInt(req.query.page, 10) || 1;
        const limit = parseInt(req.query.limit, 10) || 10;
        const startIndex = (page - 1) * limit;
        const endIndex = page * limit;
        const total = await StudentProfile.countDocuments();
        
        query = query.skip(startIndex).limit(limit);
      
        const students = await query;
        
        // Pagination result
        const pagination = {};
        
        if (endIndex < total) {
            pagination.next = {
            page: page + 1,
            limit
            };
        }
        if (startIndex > 0) {
            pagination.prev = {
            page: page - 1,
            limit
            };
        }      
        res.status(200).json({
            success: true,
            count: students.length,
            pagination,
            data: students
        });

    } catch (err) {
        res.status(500).json({
            success: false,
            message: 'Server Error',
            error: err.message
        });
    }
};

// Get a single student profile
exports.getStudentProfile = async (req, res) => {
    try {
        const student = await StudentProfile.findById(req.params.id);
      
        if (!student) {
            return res.status(404).json({
            success: false,
            message: 'Student profile not found'
            });
        }
      
        res.status(200).json({
            success: true,
            data: student
        });

    } catch (err) {
        res.status(500).json({
            success: false,
            message: 'Server Error',
            error: err.message
        });
    }
};

// Create student profile
exports.createStudentProfile = async (req, res) => {
    try {
        // Check if student with same email already exists
        const existingStudent = await StudentProfile.findOne({ email: req.body.email });
        
        if (existingStudent) {
            return res.status(400).json({
            success: false,
            message: 'A student with this email already exists'
            });
        }
      
        const student = await StudentProfile.create(req.body);
        res.status(201).json({
            success: true,
            data: student
        });

    } catch (err) {
      res.status(400).json({
        success: false,
        message: err.message
      });
    }
};  

// Update student profile
exports.updateStudentProfile = async (req, res) => {
    try {
        let student = await StudentProfile.findById(req.params.id);
        
        if (!student) {
            return res.status(404).json({
            success: false,
            message: 'Student profile not found'
            });
        }
        
        // If updating email, check if it already exists for another student
        if (req.body.email && req.body.email !== student.email) {
            const existingStudent = await StudentProfile.findOne({ email: req.body.email });
            
            if (existingStudent && existingStudent._id.toString() !== req.params.id) {
            return res.status(400).json({
                success: false,
                message: 'A student with this email already exists'
            });
            }
        }
        
        // Update student
        student = await StudentProfile.findByIdAndUpdate(req.params.id, req.body, {
            new: true,
            runValidators: true
        });
        
        res.status(200).json({
            success: true,
            data: student
        });

    } catch (err) {
      res.status(400).json({
        success: false,
        message: err.message
      });
    }
};

// Delete student profile
exports.deleteStudentProfile = async (req, res) => {
    try {
        const student = await StudentProfile.findById(req.params.id);
        
        if (!student) {
            return res.status(404).json({
                success: false,
                message: 'Student profile not found'
            });
        }
        
        // Remove custom profile image if not the default
        if (student.profileImage !== 'default-student.png') {
            const imagePath = path.join(__dirname, '../public/uploads', student.profileImage);
            if (fs.existsSync(imagePath)) {
                fs.unlinkSync(imagePath);
            }
        }
        
        await student.deleteOne();
        
        res.status(200).json({
            success: true,
            data: {}
        });
      
    } catch (err) {
        res.status(500).json({
            success: false,
            message: 'Server Error',
            error: err.message
        });
    }
};  