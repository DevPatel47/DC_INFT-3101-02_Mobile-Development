# LakeridgeCare Flutter Frontend

A complete Flutter frontend for the LakeridgeCare Medical Appointment Booking System.

## Features

✅ **Authentication**

- User registration with email, name, phone, and password
- Login with JWT token storage
- Auto-login on app start
- Secure token management with flutter_secure_storage

✅ **Doctor Management**

- View all doctors with ratings and departments
- Search doctors by name
- Filter doctors by department
- View detailed doctor profiles with bio and reviews
- Rate and review doctors

✅ **Appointment System**

- Book appointments with date and time selection
- View upcoming and past appointments
- Cancel appointments
- Real-time appointment status tracking

✅ **User Profile**

- View and edit profile information (name, email, phone)
- Change password
- Theme preferences (light/dark mode)

✅ **Settings**

- Toggle between light and dark themes
- Theme preference synced with backend
- Logout functionality

## Project Structure

```
lib/
├── core/
│   ├── api.dart              # Base API service with HTTP client
│   ├── app_theme.dart        # Light and dark theme definitions
│   └── app_router.dart       # App navigation routes
├── models/
│   ├── user.dart            # User model
│   ├── doctor.dart          # Doctor model
│   ├── appointment.dart     # Appointment model
│   └── review.dart          # Review model
├── services/
│   ├── auth_service.dart    # Authentication API calls
│   ├── doctor_service.dart  # Doctor API calls
│   ├── appointment_service.dart  # Appointment API calls
│   ├── review_service.dart  # Review API calls
│   └── user_service.dart    # User profile API calls
├── providers/
│   ├── auth_provider.dart   # Authentication state management
│   ├── doctor_provider.dart # Doctor list state management
│   ├── appointment_provider.dart  # Appointment state management
│   ├── review_provider.dart # Review state management
│   └── settings_provider.dart  # Settings and theme state management
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── doctors/
│   │   ├── doctor_list_screen.dart
│   │   └── doctor_details_screen.dart
│   ├── appointments/
│   │   ├── appointment_list_screen.dart
│   │   └── book_appointment_screen.dart
│   ├── profile/
│   │   └── profile_screen.dart
│   └── settings/
│       └── settings_screen.dart
├── widgets/
│   ├── doctor_card.dart     # Reusable doctor card widget
│   ├── appointment_card.dart # Reusable appointment card widget
│   ├── review_card.dart     # Reusable review card widget
│   ├── loading_indicator.dart # Loading indicator widget
│   └── primary_button.dart  # Primary button widget
└── main.dart                # App entry point
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (included with Flutter)
- Android Studio / Xcode (for mobile development)
- Backend server running (see backend README)

### Installation

1. **Navigate to the Flutter project directory:**

   ```bash
   cd lakeridgecare_flutter
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Configure Backend URL:**

   Open `lib/core/api.dart` and update the `baseUrl`:

   ```dart
   static const String baseUrl = 'http://YOUR_BACKEND_URL:5000/api';
   ```

   **For different platforms:**

   - Android Emulator: `http://10.0.2.2:5000/api`
   - iOS Simulator: `http://localhost:5000/api`
   - Physical Device: `http://YOUR_COMPUTER_IP:5000/api`

4. **Run the app:**
   ```bash
   flutter run
   ```

## API Endpoints Used

The app connects to the following backend endpoints:

### Authentication

- `POST /auth/register` - Register new user
- `POST /auth/login` - Login user
- `GET /auth/me` - Get current user

### Doctors

- `GET /doctors` - Get all doctors (with optional query params: department, search)
- `GET /doctors/:id` - Get doctor by ID

### Appointments

- `POST /appointments` - Book appointment
- `GET /appointments/me` - Get user's appointments
- `GET /appointments/me/next` - Get next appointment
- `PATCH /appointments/:id/cancel` - Cancel appointment

### Reviews

- `POST /reviews` - Create or update review
- `GET /reviews/:doctorId` - Get reviews for a doctor

### User Profile

- `GET /users/me` - Get user profile
- `PATCH /users/me` - Update user profile
- `PATCH /users/me/password` - Update password

## State Management

This app uses **Provider** for state management with the following providers:

- **AuthProvider**: Manages authentication state, login, register, and logout
- **DoctorProvider**: Manages doctor list, filtering, and search
- **AppointmentProvider**: Manages appointments (booking, fetching, canceling)
- **ReviewProvider**: Manages doctor reviews
- **SettingsProvider**: Manages theme and user settings

## Key Features Implementation

### 1. Secure Token Storage

JWT tokens are stored securely using `flutter_secure_storage` package. Tokens are automatically attached to authenticated API requests.

### 2. Auto-Login

On app start, the app checks for stored token and validates it. If valid, user is automatically logged in.

### 3. Theme Management

Users can toggle between light and dark themes. The preference is stored in the backend and synced across devices.

### 4. Error Handling

- Network errors are caught and displayed to users
- Form validation with clear error messages
- Backend error messages are displayed in SnackBars

### 5. Pull-to-Refresh

Most screens support pull-to-refresh for data updates:

- Home screen
- Doctor list
- Appointment list
- Doctor details (reviews)

### 6. Loading States

All async operations show loading indicators to improve UX.

## Testing

### Manual Testing Checklist

**Authentication Flow:**

- [ ] Register new user
- [ ] Login with credentials
- [ ] Auto-login on app restart
- [ ] Logout

**Doctor Features:**

- [ ] View all doctors
- [ ] Search doctors by name
- [ ] Filter doctors by department
- [ ] View doctor details
- [ ] Submit review for doctor

**Appointment Features:**

- [ ] Book appointment with date/time picker
- [ ] View upcoming appointments
- [ ] View past appointments
- [ ] Cancel appointment

**Profile & Settings:**

- [ ] View profile information
- [ ] Edit profile (name, email, phone)
- [ ] Change password
- [ ] Toggle theme (light/dark)

## Common Issues and Solutions

### Issue: Cannot connect to backend

**Solution:** Ensure backend is running and check the baseUrl in `lib/core/api.dart`

### Issue: Android network security error

**Solution:** Add the following to `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:usesCleartextTraffic="true"
    ...>
```

### Issue: iOS cannot connect to localhost

**Solution:** Use your computer's IP address instead of localhost

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1 # State management
  http: ^1.1.0 # HTTP client
  flutter_secure_storage: ^9.0.0 # Secure storage for JWT
  intl: ^0.18.1 # Date formatting
  cupertino_icons: ^1.0.2 # iOS-style icons
```

## Design Patterns

- **Repository Pattern**: Service layer abstracts API calls
- **Provider Pattern**: State management with ChangeNotifier
- **MVC Pattern**: Clear separation between UI, logic, and data
- **Widget Composition**: Reusable widget components

## Performance Optimizations

- Efficient state updates with Provider
- Image caching for doctor avatars
- Lazy loading for lists
- Debouncing for search functionality

## Future Enhancements

- Add unit and widget tests
- Implement pagination for doctor and appointment lists
- Add notifications for upcoming appointments
- Implement in-app chat with doctors
- Add payment integration
- Support multiple languages (i18n)

## License

This project is part of the LakeridgeCare Medical Appointment Booking System.

## Support

For issues or questions, please contact the development team.
