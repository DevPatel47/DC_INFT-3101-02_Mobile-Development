import 'doctor.dart';

class Appointment {
  final String id;
  final String userId;
  final String doctorId;
  final String date;
  final String time;
  final String status;
  final Doctor? doctor;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.date,
    required this.time,
    required this.status,
    this.doctor,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? '',
      doctorId: json['doctorId'] is String
          ? json['doctorId']
          : json['doctorId']?['_id'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? 'booked',
      doctor:
          json['doctorId'] is Map ? Doctor.fromJson(json['doctorId']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  bool get isUpcoming {
    final appointmentDate = DateTime.parse(date);
    final today = DateTime.now();
    return appointmentDate.isAfter(today) ||
        (appointmentDate.year == today.year &&
            appointmentDate.month == today.month &&
            appointmentDate.day == today.day);
  }

  bool get isPast {
    return !isUpcoming;
  }
}
