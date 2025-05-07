# demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Fire Stick WebView App

A high-performance webview application optimized for Amazon Fire Stick.

## Important Optimizations for Fire Stick

### 1. Performance Optimizations
- Set preferred orientation to landscape for better TV experience
- Use dark theme for better visibility on TV screens
- Implement proper memory management with cache clearing
- Use hardware acceleration for smooth rendering

### 2. Memory Management
- Clear WebView cache and local storage on dispose
- Implement proper state management
- Optimize image loading and rendering

### 3. TV-Specific Features
- Use SafeArea widget for proper TV screen handling
- Implement proper focus management for TV remote controls
- Use large touch targets for better TV interaction
- Implement proper navigation handling for TV remote

### 4. WebView Configuration
- Enable JavaScript for web functionality
- Set proper background color for transparency
- Implement navigation delegate for better control
- Add error handling for web resources

## Requirements
- Flutter SDK
- Android SDK
- Amazon Fire TV Stick or emulator

## Running the App
1. Connect your Fire Stick to your TV
2. Build the app using Flutter
3. Install the APK on your Fire Stick
4. Launch the app from your Fire Stick home screen
