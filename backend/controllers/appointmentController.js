const Appointment = require("../models/Appointment");
const Doctor = require("../models/Doctor");
const catchAsync = require("../utils/catchAsync");

// @desc    Create a new appointment
// @route   POST /api/appointments
// @access  Private
exports.createAppointment = catchAsync(async (req, res) => {
  const { doctorId, date, time } = req.body;

  // Validate input
  if (!doctorId || !date || !time) {
    return res.status(400).json({
      success: false,
      message: "Please provide doctorId, date, and time",
    });
  }

  // Check if doctor exists
  const doctor = await Doctor.findById(doctorId);

  if (!doctor) {
    return res.status(404).json({
      success: false,
      message: "Doctor not found",
    });
  }

  // Create appointment
  const appointment = await Appointment.create({
    userId: req.user.id,
    doctorId,
    date,
    time,
    status: "booked",
  });

  // Populate doctor details
  await appointment.populate("doctorId", "name department imageUrl");

  res.status(201).json({
    success: true,
    message: "Appointment booked successfully",
    data: appointment,
  });
});

// @desc    Get user's appointments (upcoming and past)
// @route   GET /api/appointments/me
// @access  Private
exports.getMyAppointments = catchAsync(async (req, res) => {
  const appointments = await Appointment.find({ userId: req.user.id })
    .populate("doctorId", "name department imageUrl")
    .sort({ date: -1, time: -1 });

  const today = new Date().toISOString().split("T")[0];

  // Separate upcoming and past appointments
  const upcoming = appointments.filter(
    (apt) => apt.status === "booked" && apt.date >= today
  );

  const past = appointments.filter(
    (apt) =>
      apt.status === "completed" ||
      apt.status === "cancelled" ||
      apt.date < today
  );

  res.status(200).json({
    success: true,
    data: {
      upcoming,
      past,
    },
  });
});

// @desc    Get user's next upcoming appointment
// @route   GET /api/appointments/me/next
// @access  Private
exports.getNextAppointment = catchAsync(async (req, res) => {
  const today = new Date().toISOString().split("T")[0];

  const appointment = await Appointment.findOne({
    userId: req.user.id,
    status: "booked",
    date: { $gte: today },
  })
    .populate("doctorId", "name department imageUrl")
    .sort({ date: 1, time: 1 });

  if (!appointment) {
    return res.status(404).json({
      success: false,
      message: "No upcoming appointments found",
    });
  }

  res.status(200).json({
    success: true,
    data: appointment,
  });
});

// @desc    Cancel an appointment
// @route   PATCH /api/appointments/:id/cancel
// @access  Private
exports.cancelAppointment = catchAsync(async (req, res) => {
  const appointment = await Appointment.findById(req.params.id);

  if (!appointment) {
    return res.status(404).json({
      success: false,
      message: "Appointment not found",
    });
  }

  // Check if appointment belongs to user
  if (appointment.userId.toString() !== req.user.id) {
    return res.status(403).json({
      success: false,
      message: "Not authorized to cancel this appointment",
    });
  }

  // Check if appointment is already cancelled
  if (appointment.status === "cancelled") {
    return res.status(400).json({
      success: false,
      message: "Appointment is already cancelled",
    });
  }

  appointment.status = "cancelled";
  await appointment.save();

  res.status(200).json({
    success: true,
    message: "Appointment cancelled successfully",
    data: appointment,
  });
});
