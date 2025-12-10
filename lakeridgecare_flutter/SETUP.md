# LakeridgeCare Flutter - Quick Setup Guide

## 1. Prerequisites Check

```bash
flutter --version  # Ensure Flutter 3.0.0+
dart --version     # Should be included with Flutter
```

## 2. Quick Start

### Step 1: Navigate to project

```bash
cd lakeridgecare_flutter
```

### Step 2: Install dependencies

```bash
flutter pub get
```

### Step 3: Configure Backend URL

**Option A: Using Android Emulator**

- Open `lib/core/api.dart`
- Change `baseUrl` to: `http://10.0.2.2:5000/api`

**Option B: Using iOS Simulator**

- Open `lib/core/api.dart`
- Keep `baseUrl` as: `http://localhost:5000/api`

**Option C: Using Physical Device**

- Find your computer's IP address:
  - Windows: `ipconfig` (look for IPv4 Address)
  - Mac/Linux: `ifconfig` or `ip addr`
- Open `lib/core/api.dart`
- Change `baseUrl` to: `http://YOUR_IP:5000/api`
- Example: `http://192.168.1.100:5000/api`

### Step 4: Ensure Backend is Running

```bash
# In the backend directory
npm start
```

Backend should be running on `http://localhost:5000`

### Step 5: Run the Flutter App

```bash
flutter run
```

## 3. Platform-Specific Setup

### Android

If you encounter network security errors, add to `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:usesCleartextTraffic="true"
    ...>
```

### iOS

1. Ensure you have Xcode installed
2. Run: `cd ios && pod install && cd ..`
3. Open iOS Simulator before running

## 4. Test Credentials

You can create a new account or use these test accounts (if available in your backend):

**Test User 1:**

- Email: `test@example.com`
- Password: `password123`

**Test User 2:**

- Email: `john@example.com`
- Password: `password123`

## 5. Quick Test Flow

1. **Register**: Create new account
2. **Home**: View dashboard
3. **Find Doctors**: Browse and search doctors
4. **Doctor Details**: View doctor profile and reviews
5. **Book Appointment**: Select date and time
6. **My Appointments**: View booked appointments
7. **Profile**: Edit your profile
8. **Settings**: Toggle dark mode

## 6. Troubleshooting

### Problem: "Cannot connect to backend"

**Solution:**

- Verify backend is running (`npm start` in backend folder)
- Check the URL in `lib/core/api.dart`
- For physical devices, ensure device and computer are on same network

### Problem: "SocketException: OS Error: Connection refused"

**Solution:**

- Use correct IP address based on your platform
- Ensure firewall is not blocking the connection

### Problem: "Unhandled Exception: type '\_Map<String, dynamic>' is not a subtype"

**Solution:**

- Clear app data and restart
- Ensure backend is returning correct data format

### Problem: App crashes on startup

**Solution:**

```bash
flutter clean
flutter pub get
flutter run
```

## 7. Development Tips

### Hot Reload

Press `r` in terminal while app is running to hot reload changes.

### Hot Restart

Press `R` in terminal to fully restart the app.

### View Logs

```bash
flutter logs
```

### Check for Issues

```bash
flutter analyze
```

## 8. Build for Release

### Android APK

```bash
flutter build apk --release
```

APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### iOS

```bash
flutter build ios --release
```

Then use Xcode to archive and distribute.

## 9. Code Structure Quick Reference

- **API Service**: `lib/core/api.dart`
- **Models**: `lib/models/`
- **Services**: `lib/services/`
- **Providers**: `lib/providers/`
- **Screens**: `lib/screens/`
- **Widgets**: `lib/widgets/`

## 10. Common Commands

```bash
# Get dependencies
flutter pub get

# Run on specific device
flutter run -d <device_id>

# List devices
flutter devices

# Clean build
flutter clean

# Check for updates
flutter upgrade

# Format code
flutter format lib/

# Analyze code
flutter analyze
```

## Support

For detailed documentation, see [README.md](README.md)
For testing guide, see [TESTING.md](TESTING.md)
