# Daily Expense Tracker

A beautiful Flutter application for tracking daily expenses with a modern and intuitive user interface, featuring comprehensive expense management, analytics, and multi-platform support.

## 🌟 Features

### Core Functionality
- **Expense Tracking**: Add, edit, and delete expenses with categories
- **Analytics Dashboard**: Visual insights into spending patterns
- **Category Management**: Organize expenses by customizable categories
- **User Authentication**: Login, signup, and forgot password functionality
- **Responsive Design**: Beautiful UI that works across all screen sizes
- **Performance Optimized**: Lightweight architecture for smooth performance

### UI/UX Features
- Modern Material Design 3 interface
- Mint green color scheme with warm accents
- Custom logo integration throughout the app
- Tab-based navigation with caching for better performance
- Smooth animations and transitions
- Dark mode ready color palette

### Platform Support
- **Android** (API 21+)
- **iOS** (12.0+)
- **Web** (Progressive Web App)
- **macOS** (10.14+)
- **Linux** (Desktop)
- **Windows** (Desktop)

## 📱 Screenshots & UI Components

The app features several key screens and components:

- [`lib/AuthenticationScreen/login.dart`](lib/AuthenticationScreen/login.dart) - User login interface
- [`lib/AuthenticationScreen/signup.dart`](lib/AuthenticationScreen/signup.dart) - User registration
- [`lib/AuthenticationScreen/forgot_password.dart`](lib/AuthenticationScreen/forgot_password.dart) - Password recovery
- [`lib/pages/home.dart`](lib/pages/home.dart) - Main dashboard and expense management
- [`lib/pages/navigation_lightweight.dart`](lib/pages/navigation_lightweight.dart) - Optimized navigation system

### Tab Structure
- **Expenses Tab** ([`lib/pages/tabs/expenses_tab.dart`](lib/pages/tabs/expenses_tab.dart)): View and manage all expenses
- **Analytics Tab** ([`lib/pages/tabs/analytics_tab.dart`](lib/pages/tabs/analytics_tab.dart)): Spending insights and charts
- **Categories Tab** ([`lib/pages/tabs/categories_tab.dart`](lib/pages/tabs/categories_tab.dart)): Category management
- **Settings Tab** ([`lib/pages/tabs/settings_tab.dart`](lib/pages/tabs/settings_tab.dart)): App configuration

## 🎨 Design System

### Color Palette
The app uses a carefully crafted color scheme defined in [`lib/constants/colors.dart`](lib/constants/colors.dart):

- **Primary**: Mint Green (#A8E6CF) - Main branding color
- **Accent**: Warm Coral (#FF8B94) - Delete actions and highlights
- **Secondary**: Sky Blue (#89CFF0) - Information and secondary actions
- **Background**: Sand Beige (#F9F6F2) - App background
- **Text Primary**: Charcoal (#333333) - Main text
- **Text Secondary**: Soft Gray (#666666) - Secondary text
- **Text Tertiary**: Light Gray (#999999) - Placeholder text

### Logo Integration
Custom logo support with [`assets/logo.png`](assets/logo.png):
- Recommended size: 512x512 pixels or higher
- Format: PNG with transparent background
- Used across authentication screens and app header
- Optimized for both light and dark themes

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK (included with Flutter)
- Platform-specific development tools:
  - **Android**: Android Studio/VS Code with Android SDK
  - **iOS**: Xcode (macOS only)
  - **Web**: Chrome/Edge browser
  - **Desktop**: Platform-specific build tools

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd daily_expense_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add your logo** (Optional)
   - Place your logo file at [`assets/logo.png`](assets/logo.png)
   - Ensure it's 512x512 pixels or higher

4. **Run the application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
daily_expense_tracker/
├── lib/
│   ├── AuthenticationScreen/          # User authentication
│   │   ├── login.dart
│   │   ├── signup.dart
│   │   └── forgot_password.dart
│   ├── constants/                     # App constants
│   │   └── colors.dart
│   ├── models/                        # Data models
│   │   ├── expense.dart
│   │   └── category_utils.dart
│   ├── pages/                         # Main application pages
│   │   ├── home.dart
│   │   ├── navigation_lightweight.dart
│   │   └── tabs/
│   │       ├── expenses_tab.dart
│   │       ├── analytics_tab.dart
│   │       ├── categories_tab.dart
│   │       └── settings_tab.dart
│   ├── widgets/                       # Reusable components
│   │   ├── expense_card.dart
│   │   ├── add_expense_dialog.dart
│   │   └── add_expense_dialog_lightweight.dart
│   ├── router/                        # Navigation
│   │   └── router.dart
│   └── main.dart                      # App entry point
├── assets/                            # Static assets
│   └── logo.png
├── android/                           # Android platform
├── ios/                              # iOS platform
├── web/                              # Web platform
├── macos/                            # macOS platform
├── linux/                            # Linux platform
├── windows/                          # Windows platform
├── pubspec.yaml                      # Dependencies
├── analysis_options.yaml            # Code analysis rules
├── README.md                         # This file
└── PERFORMANCE_GUIDE.md             # Performance optimization guide
```

## 📦 Dependencies

### Core Dependencies
- **flutter**: SDK framework
- **cupertino_icons**: ^1.0.8 - iOS-style icons
- **go_router**: ^15.2.4 - Declarative routing

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: ^5.0.0 - Linting rules for code quality

## 🛠️ Build Commands

### Development
```bash
# Run in debug mode
flutter run

# Run with hot reload
flutter run --hot

# Run on specific device
flutter run -d <device-id>
```

### Production Builds

#### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

#### iOS
```bash
# Build for iOS
flutter build ios --release

# Build IPA for App Store
flutter build ipa --release
```

#### Web
```bash
# Build for web
flutter build web --release
```

#### Desktop
```bash
# Build for macOS
flutter build macos --release

# Build for Linux
flutter build linux --release

# Build for Windows
flutter build windows --release
```

## ⚡ Performance Optimizations

The app implements several performance optimizations detailed in [`PERFORMANCE_GUIDE.md`](PERFORMANCE_GUIDE.md):

### Implemented Features
- **Lazy Loading**: Tabs load only when accessed
- **Widget Caching**: Prevents unnecessary rebuilds
- **Lightweight Components**: Optimized UI components
- **Memory Management**: Proper disposal and cleanup
- **Minimal Dependencies**: Only essential packages

### Performance Benefits
- ✅ Faster app startup time
- ✅ Lower memory usage  
- ✅ Smooth navigation
- ✅ Better performance on low-end devices
- ✅ Smaller APK size

## 🔧 Configuration

### Platform-Specific Settings

#### Android
- **Package ID**: `com.example.daily_expense_tracker`
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 34 (Android 14)
- **Compile SDK**: 34

#### iOS
- **Bundle ID**: `com.example.dailyExpenseTracker`
- **Deployment Target**: iOS 12.0+
- **Development Team**: Configure in Xcode

#### Web
- **App Name**: `daily_expense_tracker`
- **Theme Color**: `#A8E6CF` (Mint Green)
- **Manifest**: Progressive Web App support

#### Desktop
- **macOS**: 10.14+ (Mojave)
- **Windows**: Windows 10+
- **Linux**: Modern distributions with GTK 3.0+

### App Configuration
Key configuration files:
- [`pubspec.yaml`](pubspec.yaml) - Dependencies and assets
- [`analysis_options.yaml`](analysis_options.yaml) - Code quality rules
- [`lib/constants/colors.dart`](lib/constants/colors.dart) - Color scheme

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📊 Code Quality

The project follows strict code quality standards:

- **Flutter Lints**: Comprehensive linting rules
- **Type Safety**: Strict typing enabled
- **Performance Rules**: Optimized widget patterns
- **Code Organization**: Clean architecture principles

Key rules from [`analysis_options.yaml`](analysis_options.yaml):
- Prefer const constructors
- Avoid function literals in forEach
- Use single quotes for strings
- Proper disposal patterns

## 🚀 Deployment

### Android Play Store
1. Build signed app bundle: `flutter build appbundle --release`
2. Upload to Google Play Console
3. Configure store listing and releases

### iOS App Store
1. Build IPA: `flutter build ipa --release`
2. Upload via Xcode or Transporter
3. Submit for review in App Store Connect

### Web Hosting
1. Build web version: `flutter build web --release`
2. Deploy `build/web` folder to hosting service
3. Configure domain and SSL

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make your changes**
4. **Follow code style guidelines**
5. **Add tests if applicable**
6. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
7. **Push to your branch**
   ```bash
   git push origin feature/amazing-feature
   ```
8. **Open a Pull Request**

### Code Style
- Follow Dart conventions
- Use meaningful variable names
- Add comments for complex logic
- Keep widgets small and focused
- Follow the existing color scheme

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:
- Create an issue in the repository
- Check existing issues for solutions
- Review the [`PERFORMANCE_GUIDE.md`](PERFORMANCE_GUIDE.md) for optimization tips

## 🔄 Version History

- **v1.0.0+1** - Initial release
  - Core expense tracking functionality
  - Multi-platform support
  - Authentication system
  - Analytics dashboard
  - Performance optimizations

## 🎯 Roadmap

Future features planned:
- [ ] Data export functionality
- [ ] Cloud sync capabilities
- [ ] Receipt photo capture
- [ ] Budget planning tools
- [ ] Expense reminders
- [ ] Multi-currency support
- [ ] Advanced analytics
- [ ] Expense sharing

---

**Made with ❤️ using Flutter**

For more detailed information about performance optimizations, see [`PERFORMANCE_GUIDE.md`](PERFORMANCE_GUIDE.md).
