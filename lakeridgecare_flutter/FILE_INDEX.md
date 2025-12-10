# 📱 LakeridgeCare Flutter - Complete File Index

## 📂 Project Files Overview

### 🎯 Quick Navigation

- [Core Files](#core-files)
- [Models](#models)
- [Services](#services)
- [Providers](#providers)
- [Screens](#screens)
- [Widgets](#widgets)
- [Documentation](#documentation)

---

## Core Files

### `lib/core/api.dart`

**Purpose:** Base API service for all HTTP requests  
**Key Features:**

- HTTP client wrapper (GET, POST, PATCH, DELETE)
- JWT token management
- Request/response handling
- Error handling
- Base URL configuration

**Main Classes:**

- `ApiService` - Singleton API client

**Usage:**

```dart
final api = ApiService();
final response = await api.get('/doctors', requiresAuth: false);
```

---

### `lib/core/app_theme.dart`

**Purpose:** Theme definitions for light and dark modes  
**Key Features:**

- Material Design 3 themes
- Light theme configuration
- Dark theme configuration
- Consistent styling across app

**Main Classes:**

- `AppTheme` - Static theme data

**Usage:**

```dart
theme: AppTheme.lightTheme,
darkTheme: AppTheme.darkTheme,
```

---

### `lib/core/app_router.dart`

**Purpose:** Centralized navigation and routing  
**Key Features:**

- Named routes
- Route generation
- Type-safe navigation
- 404 handling

**Routes:**

- `/login` - LoginScreen
- `/register` - RegisterScreen
- `/home` - HomeScreen
- `/doctors` - DoctorListScreen
- `/doctor-details` - DoctorDetailsScreen
- `/appointments` - AppointmentListScreen
- `/book-appointment` - BookAppointmentScreen
- `/profile` - ProfileScreen
- `/settings` - SettingsScreen

**Usage:**

```dart
Navigator.of(context).pushNamed(AppRouter.doctorList);
```

---

## Models

### `lib/models/user.dart`

**Purpose:** User data model  
**Properties:**

- `id` - User ID
- `name` - Full name
- `email` - Email address
- `phone` - Phone number
- `theme` - Theme preference (light/dark)

**Methods:**

- `fromJson()` - Parse from API response
- `toJson()` - Convert to JSON
- `copyWith()` - Create modified copy

---

### `lib/models/doctor.dart`

**Purpose:** Doctor data model  
**Properties:**

- `id` - Doctor ID
- `name` - Doctor name
- `department` - Medical department
- `bio` - Biography
- `imageUrl` - Profile image URL
- `ratingAvg` - Average rating (0-5)
- `ratingCount` - Number of reviews

**Methods:**

- `fromJson()` - Parse from API response
- `toJson()` - Convert to JSON

---

### `lib/models/appointment.dart`

**Purpose:** Appointment data model  
**Properties:**

- `id` - Appointment ID
- `userId` - User ID
- `doctorId` - Doctor ID
- `date` - Appointment date (YYYY-MM-DD)
- `time` - Appointment time (HH:mm)
- `status` - Status (booked/cancelled/completed)
- `doctor` - Populated doctor object

**Methods:**

- `fromJson()` - Parse from API response
- `toJson()` - Convert to JSON
- `isUpcoming` - Check if appointment is upcoming
- `isPast` - Check if appointment is past

---

### `lib/models/review.dart`

**Purpose:** Review data model  
**Properties:**

- `id` - Review ID
- `userId` - User ID
- `doctorId` - Doctor ID
- `rating` - Rating (1-5)
- `comment` - Review comment
- `userName` - Reviewer name
- `createdAt` - Creation date

**Methods:**

- `fromJson()` - Parse from API response
- `toJson()` - Convert to JSON

---

## Services

### `lib/services/auth_service.dart`

**Purpose:** Authentication API calls  
**Methods:**

- `register()` - Register new user
- `login()` - Login user
- `getMe()` - Get current user
- `logout()` - Logout user
- `isLoggedIn()` - Check login status

**API Endpoints Used:**

- `POST /auth/register`
- `POST /auth/login`
- `GET /auth/me`

---

### `lib/services/doctor_service.dart`

**Purpose:** Doctor-related API calls  
**Methods:**

- `getDoctors()` - Get all doctors (with filters)
- `getDoctorById()` - Get doctor by ID
- `getDepartments()` - Get unique departments

**API Endpoints Used:**

- `GET /doctors`
- `GET /doctors/:id`

**Query Parameters:**

- `department` - Filter by department
- `search` - Search by name

---

### `lib/services/appointment_service.dart`

**Purpose:** Appointment management API calls  
**Methods:**

- `createAppointment()` - Book new appointment
- `getMyAppointments()` - Get user's appointments
- `getNextAppointment()` - Get next upcoming appointment
- `cancelAppointment()` - Cancel appointment

**API Endpoints Used:**

- `POST /appointments`
- `GET /appointments/me`
- `GET /appointments/me/next`
- `PATCH /appointments/:id/cancel`

---

### `lib/services/review_service.dart`

**Purpose:** Review management API calls  
**Methods:**

- `createOrUpdateReview()` - Submit or update review
- `getReviewsByDoctor()` - Get reviews for doctor

**API Endpoints Used:**

- `POST /reviews`
- `GET /reviews/:doctorId`

---

### `lib/services/user_service.dart`

**Purpose:** User profile API calls  
**Methods:**

- `getProfile()` - Get user profile
- `updateProfile()` - Update profile info
- `updatePassword()` - Change password

**API Endpoints Used:**

- `GET /users/me`
- `PATCH /users/me`
- `PATCH /users/me/password`

---

## Providers

### `lib/providers/auth_provider.dart`

**Purpose:** Authentication state management  
**State:**

- `_user` - Current user
- `_isLoading` - Loading state
- `_error` - Error message
- `isAuthenticated` - Auth status

**Methods:**

- `register()` - Register user
- `login()` - Login user
- `loadUser()` - Load current user
- `checkAuth()` - Check authentication
- `logout()` - Logout user
- `updateUser()` - Update user data
- `clearError()` - Clear error

**Used In:**

- LoginScreen
- RegisterScreen
- HomeScreen
- All authenticated screens

---

### `lib/providers/doctor_provider.dart`

**Purpose:** Doctor list state management  
**State:**

- `_doctors` - All doctors
- `_filteredDoctors` - Filtered doctors
- `_departments` - Department list
- `_selectedDepartment` - Selected filter
- `_searchQuery` - Search query

**Methods:**

- `fetchDoctors()` - Load doctors
- `filterByDepartment()` - Apply department filter
- `searchDoctors()` - Search by name
- `clearFilters()` - Clear all filters
- `getDoctorById()` - Get specific doctor

**Used In:**

- DoctorListScreen
- HomeScreen

---

### `lib/providers/appointment_provider.dart`

**Purpose:** Appointment state management  
**State:**

- `_upcomingAppointments` - Future appointments
- `_pastAppointments` - Past appointments
- `_nextAppointment` - Next appointment
- `_isLoading` - Loading state
- `_error` - Error message

**Methods:**

- `fetchAppointments()` - Load all appointments
- `bookAppointment()` - Book new appointment
- `cancelAppointment()` - Cancel appointment
- `clearError()` - Clear error

**Used In:**

- BookAppointmentScreen
- AppointmentListScreen
- HomeScreen

---

### `lib/providers/review_provider.dart`

**Purpose:** Review state management  
**State:**

- `_reviewsByDoctor` - Reviews map (doctorId -> reviews)
- `_isLoading` - Loading state
- `_error` - Error message

**Methods:**

- `fetchReviews()` - Load reviews for doctor
- `submitReview()` - Submit or update review
- `getReviewsForDoctor()` - Get cached reviews
- `clearError()` - Clear error

**Used In:**

- DoctorDetailsScreen

---

### `lib/providers/settings_provider.dart`

**Purpose:** Settings and theme state management  
**State:**

- `_themeMode` - Current theme mode
- `_isLoading` - Loading state
- `_error` - Error message
- `isDarkMode` - Dark mode status

**Methods:**

- `initializeTheme()` - Initialize theme from user
- `toggleTheme()` - Switch theme
- `updateProfile()` - Update user profile
- `updatePassword()` - Change password
- `clearError()` - Clear error

**Used In:**

- SettingsScreen
- ProfileScreen
- Main app (theme management)

---

## Screens

### `lib/screens/auth/login_screen.dart`

**Purpose:** User login  
**Features:**

- Email/password form
- Form validation
- Show/hide password
- Navigate to register
- Auto-navigate on success

**Form Fields:**

- Email (email validation)
- Password (required)

**Actions:**

- Login button
- Navigate to Register

---

### `lib/screens/auth/register_screen.dart`

**Purpose:** User registration  
**Features:**

- Multi-field registration form
- Form validation
- Password confirmation
- Show/hide passwords
- Navigate to login

**Form Fields:**

- Name (required)
- Email (email validation)
- Phone (required)
- Password (min 6 chars)
- Confirm Password (match validation)

**Actions:**

- Register button
- Navigate to Login

---

### `lib/screens/home/home_screen.dart`

**Purpose:** Main dashboard  
**Features:**

- Welcome message
- Quick action cards
- Next appointment widget
- Upcoming appointments preview
- Navigation drawer
- Pull-to-refresh

**Sections:**

- Welcome header
- Quick actions (Find Doctor, Appointments)
- Next appointment card
- Upcoming appointments list (top 3)
- Drawer menu

**Navigation:**

- Drawer: Home, Doctors, Appointments, Profile, Settings, Logout

---

### `lib/screens/doctors/doctor_list_screen.dart`

**Purpose:** Browse and search doctors  
**Features:**

- Doctor list with cards
- Search functionality
- Department filter
- Pull-to-refresh
- Empty state handling

**UI Elements:**

- Search bar
- Filter button
- Department chips
- Doctor cards (name, dept, rating)

**Actions:**

- Tap doctor card → Doctor Details
- Search by name
- Filter by department

---

### `lib/screens/doctors/doctor_details_screen.dart`

**Purpose:** View doctor profile and reviews  
**Features:**

- Doctor profile display
- Bio section
- Reviews list
- Write review dialog
- Book appointment button
- Pull-to-refresh

**Sections:**

- Doctor header (image, name, dept, rating)
- About/Bio section
- Book Appointment button
- Reviews section
- Write Review button

**Actions:**

- Book Appointment
- Write/Update Review

---

### `lib/screens/appointments/appointment_list_screen.dart`

**Purpose:** View all appointments  
**Features:**

- Tabbed view (Upcoming/Past)
- Appointment cards
- Cancel functionality
- Confirmation dialogs
- Empty states
- Pull-to-refresh

**Tabs:**

- Upcoming (booked, future)
- Past (completed, cancelled, past)

**Actions:**

- Cancel appointment (upcoming only)
- View appointment details

---

### `lib/screens/appointments/book_appointment_screen.dart`

**Purpose:** Book new appointment  
**Features:**

- Doctor info display
- Date picker (future dates only)
- Time picker
- Booking validation
- Success/error feedback

**UI Elements:**

- Doctor info card
- Date selection
- Time selection
- Book button

**Validation:**

- Date required
- Time required
- Future dates only

---

### `lib/screens/profile/profile_screen.dart`

**Purpose:** View and edit user profile  
**Features:**

- Profile display
- Edit mode toggle
- Change password dialog
- Form validation
- Save/cancel actions

**Form Fields:**

- Name
- Email
- Phone

**Actions:**

- Edit profile
- Save changes
- Cancel edit
- Change password

---

### `lib/screens/settings/settings_screen.dart`

**Purpose:** App settings and preferences  
**Features:**

- User info display
- Theme toggle
- Navigation links
- App version display
- Logout functionality

**Sections:**

- User info header
- Appearance (theme toggle)
- Account (profile, appointments)
- About (version, terms, privacy)
- Logout button

**Actions:**

- Toggle dark mode
- Navigate to Profile
- Navigate to Appointments
- Logout (with confirmation)

---

## Widgets

### `lib/widgets/doctor_card.dart`

**Purpose:** Reusable doctor card component  
**Props:**

- `doctor` - Doctor object
- `onTap` - Tap callback

**Display:**

- Doctor image/avatar
- Name
- Department
- Rating (stars + count)

---

### `lib/widgets/appointment_card.dart`

**Purpose:** Reusable appointment card  
**Props:**

- `appointment` - Appointment object
- `onCancel` - Cancel callback (optional)

**Display:**

- Doctor info
- Date (formatted)
- Time (formatted)
- Status badge
- Cancel button (if applicable)

---

### `lib/widgets/review_card.dart`

**Purpose:** Reusable review card  
**Props:**

- `review` - Review object

**Display:**

- User avatar
- User name
- Review date
- Rating (stars)
- Comment text

---

### `lib/widgets/loading_indicator.dart`

**Purpose:** Reusable loading widget  
**Props:**

- `message` - Optional loading message

**Display:**

- Circular progress indicator
- Optional message text

---

### `lib/widgets/primary_button.dart`

**Purpose:** Reusable primary button  
**Props:**

- `text` - Button text
- `onPressed` - Tap callback
- `isLoading` - Loading state
- `icon` - Optional icon

**States:**

- Normal
- Loading (shows spinner)
- Disabled

---

## Documentation

### `README.md`

**Content:**

- Project overview
- Features list
- Project structure
- Setup instructions
- API endpoints
- Dependencies
- Troubleshooting

**Sections:** 40+  
**Pages:** ~15

---

### `SETUP.md`

**Content:**

- Quick setup guide
- Prerequisites
- Step-by-step installation
- Platform-specific config
- Test credentials
- Quick test flow
- Troubleshooting
- Common commands

**Focus:** Getting started quickly

---

### `TESTING.md`

**Content:**

- 100+ test cases
- Module-by-module testing
- Test case templates
- Bug report templates
- Edge cases
- Performance metrics
- Regression checklist

**Sections:** 12 modules  
**Test Cases:** 100+

---

### `API_INTEGRATION.md`

**Content:**

- All API endpoints
- Request/response examples
- Authentication flow
- JWT token management
- Error handling
- Debugging tips
- Network configuration

**Endpoints Documented:** 15  
**Examples:** 30+

---

### `PROJECT_SUMMARY.md`

**Content:**

- Project completion status
- Features checklist
- Statistics
- Architecture overview
- Quality metrics
- Production readiness

**Focus:** High-level overview

---

## Configuration Files

### `pubspec.yaml`

**Purpose:** Flutter project configuration  
**Contains:**

- Project metadata
- Dependencies
- Dev dependencies
- Flutter configuration

---

### `analysis_options.yaml`

**Purpose:** Dart linter configuration  
**Contains:**

- Linter rules
- Code style preferences

---

### `.gitignore`

**Purpose:** Git ignore patterns  
**Excludes:**

- Build artifacts
- IDE files
- Platform-specific files
- Dependencies

---

## Entry Point

### `lib/main.dart`

**Purpose:** App entry point  
**Features:**

- MultiProvider setup
- Theme configuration
- Routing setup
- Splash screen with auto-login

**Main Classes:**

- `MyApp` - Root app widget
- `SplashScreen` - Initial loading screen

---

## File Count Summary

| Category      | Count   |
| ------------- | ------- |
| Core Files    | 3       |
| Models        | 4       |
| Services      | 5       |
| Providers     | 5       |
| Screens       | 10      |
| Widgets       | 5       |
| Documentation | 5       |
| Config Files  | 3       |
| **TOTAL**     | **40+** |

---

## Lines of Code Summary

| Category      | Approx. Lines |
| ------------- | ------------- |
| Core          | 300           |
| Models        | 250           |
| Services      | 500           |
| Providers     | 750           |
| Screens       | 2,000         |
| Widgets       | 500           |
| Documentation | 3,000         |
| **TOTAL**     | **~7,300**    |

---

## Dependencies Map

```
main.dart
  ├─ AuthProvider
  ├─ DoctorProvider
  ├─ AppointmentProvider
  ├─ ReviewProvider
  └─ SettingsProvider
      ├─ AuthService
      ├─ DoctorService
      ├─ AppointmentService
      ├─ ReviewService
      └─ UserService
          └─ ApiService
              └─ flutter_secure_storage
                  └─ JWT Token
```

---

## Navigation Flow

```
Splash Screen
  ├─ Check Token
  │   ├─ Valid → Home Screen
  │   └─ Invalid → Login Screen
  │
Login/Register
  └─ Success → Home Screen
      ├─ Find Doctors → Doctor List
      │   └─ Doctor Details
      │       ├─ Book Appointment
      │       └─ Write Review
      │
      ├─ Appointments → Appointment List
      │   └─ Cancel Appointment
      │
      ├─ Profile → Profile Screen
      │   └─ Change Password
      │
      └─ Settings → Settings Screen
          ├─ Toggle Theme
          └─ Logout → Login Screen
```

---

## API Flow Diagram

```
Screen → Provider → Service → ApiService → Backend API
  ↓         ↓          ↓           ↓            ↓
  ←─────────←──────────←───────────←────────────←
```

---

## State Management Flow

```
User Action
  ↓
Screen calls Provider method
  ↓
Provider sets loading = true
  ↓
Provider calls Service
  ↓
Service calls ApiService
  ↓
ApiService makes HTTP request
  ↓
Backend processes & responds
  ↓
ApiService parses response
  ↓
Service returns data/throws error
  ↓
Provider updates state
  ↓
Provider notifies listeners
  ↓
UI rebuilds with new state
```

---

## Complete Feature Matrix

| Feature            | Screen                | Provider            | Service            | Widget          | Status |
| ------------------ | --------------------- | ------------------- | ------------------ | --------------- | ------ |
| Login              | LoginScreen           | AuthProvider        | AuthService        | -               | ✅     |
| Register           | RegisterScreen        | AuthProvider        | AuthService        | -               | ✅     |
| Auto-Login         | SplashScreen          | AuthProvider        | AuthService        | -               | ✅     |
| View Doctors       | DoctorListScreen      | DoctorProvider      | DoctorService      | DoctorCard      | ✅     |
| Search Doctors     | DoctorListScreen      | DoctorProvider      | DoctorService      | -               | ✅     |
| Filter Doctors     | DoctorListScreen      | DoctorProvider      | DoctorService      | -               | ✅     |
| Doctor Details     | DoctorDetailsScreen   | DoctorProvider      | DoctorService      | -               | ✅     |
| View Reviews       | DoctorDetailsScreen   | ReviewProvider      | ReviewService      | ReviewCard      | ✅     |
| Write Review       | DoctorDetailsScreen   | ReviewProvider      | ReviewService      | -               | ✅     |
| Book Appointment   | BookAppointmentScreen | AppointmentProvider | AppointmentService | -               | ✅     |
| View Appointments  | AppointmentListScreen | AppointmentProvider | AppointmentService | AppointmentCard | ✅     |
| Cancel Appointment | AppointmentListScreen | AppointmentProvider | AppointmentService | -               | ✅     |
| View Profile       | ProfileScreen         | SettingsProvider    | UserService        | -               | ✅     |
| Edit Profile       | ProfileScreen         | SettingsProvider    | UserService        | -               | ✅     |
| Change Password    | ProfileScreen         | SettingsProvider    | UserService        | -               | ✅     |
| Toggle Theme       | SettingsScreen        | SettingsProvider    | UserService        | -               | ✅     |
| Logout             | SettingsScreen        | AuthProvider        | AuthService        | -               | ✅     |

---

**Total Features Implemented:** 17/17 ✅

---

## Quick Reference Commands

```bash
# Navigate to project
cd lakeridgecare_flutter

# Get dependencies
flutter pub get

# Run app
flutter run

# Clean build
flutter clean

# Analyze code
flutter analyze

# Format code
flutter format lib/

# Build APK
flutter build apk

# View devices
flutter devices
```

---

## Final Checklist

- ✅ All files created
- ✅ No compilation errors
- ✅ All imports resolved
- ✅ All features implemented
- ✅ Documentation complete
- ✅ Code formatted
- ✅ Ready for testing

---

**Project Status:** 100% Complete ✅
