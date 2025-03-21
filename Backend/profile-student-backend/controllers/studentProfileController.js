exports.getStudentProfiles = async (req, res) => {
    try {
        let query;
        const reqQuery = { ...req.query };
        
        // Loop over removeFields and delete them from reqQuery
        const removeFields = ['select', 'sort', 'page', 'limit'];
        removeFields.forEach(param => delete reqQuery[param]);
      
        let queryStr = JSON.stringify(reqQuery);
        
        // Create operators 
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
      
        // Executing query
        const students = await query;
        
        res.status(200).json({
            success: true,
            count: students.length,
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