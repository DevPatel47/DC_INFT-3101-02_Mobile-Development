import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/doctors/doctor_list_screen.dart';
import '../screens/doctors/doctor_details_screen.dart';
import '../screens/appointments/appointment_list_screen.dart';
import '../screens/appointments/book_appointment_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../models/doctor.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String doctorList = '/doctors';
  static const String doctorDetails = '/doctor-details';
  static const String appointments = '/appointments';
  static const String bookAppointment = '/book-appointment';
  static const String profile = '/profile';
  static const String settingsRoute = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case doctorList:
        return MaterialPageRoute(builder: (_) => const DoctorListScreen());

      case doctorDetails:
        final doctor = settings.arguments as Doctor;
        return MaterialPageRoute(
          builder: (_) => DoctorDetailsScreen(doctor: doctor),
        );

      case appointments:
        return MaterialPageRoute(builder: (_) => const AppointmentListScreen());

      case bookAppointment:
        final doctor = settings.arguments as Doctor;
        return MaterialPageRoute(
          builder: (_) => BookAppointmentScreen(doctor: doctor),
        );

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
