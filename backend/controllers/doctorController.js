const Doctor = require("../models/Doctor");
const catchAsync = require("../utils/catchAsync");

// @desc    Get all doctors with optional filtering
// @route   GET /api/doctors?department=&search=
// @access  Public
exports.getDoctors = catchAsync(async (req, res) => {
  const { department, search } = req.query;

  let query = {};

  // Filter by department
  if (department) {
    query.department = { $regex: department, $options: "i" };
  }

  // Search by name
  if (search) {
    query.name = { $regex: search, $options: "i" };
  }

  const doctors = await Doctor.find(query).sort({ name: 1 });

  res.status(200).json({
    success: true,
    count: doctors.length,
    data: doctors,
  });
});

// @desc    Get single doctor by ID
// @route   GET /api/doctors/:id
// @access  Public
exports.getDoctorById = catchAsync(async (req, res) => {
  const doctor = await Doctor.findById(req.params.id);

  if (!doctor) {
    return res.status(404).json({
      success: false,
      message: "Doctor not found",
    });
  }

  res.status(200).json({
    success: true,
    data: doctor,
  });
});
