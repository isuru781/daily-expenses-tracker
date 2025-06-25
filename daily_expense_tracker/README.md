# Daily Expenses Tracker

A beautiful Flutter application for tracking daily expenses with a modern and intuitive user interface.

## Features

- User Authentication (Login, Signup, Forgot Password)
- Beautiful UI with custom logo integration
- Modern design with mint green color scheme
- Responsive layout for mobile devices

## Logo Integration

The app uses a custom logo located at `assets/logo.png`. The logo is integrated into:

- Login screen
- Signup screen 
- Forgot password screen
- Home page app bar
- Any other screens that require branding

### Logo Specifications

- Format: PNG
- Recommended size: 512x512 pixels or higher
- Background: Transparent or solid color
- Colors: Should complement the app's mint green color scheme

## Getting Started

1. Ensure you have Flutter installed on your machine
2. Place your logo file at `assets/logo.png`
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

## Project Structure

```
lib/
├── AuthenicationScreen/
│   ├── login.dart
│   ├── signup.dart
│   └── forgot_password.dart
├── constants/
│   └── colors.dart
├── pages/
│   └── home.dart
├── router/
│   └── router.dart
└── main.dart
assets/
└── logo.png
```

## Dependencies

- `flutter`: SDK
- `go_router`: Navigation and routing
- `cupertino_icons`: iOS style icons

## Color Scheme

The app uses a beautiful color palette defined in `lib/constants/colors.dart`:

- **Mint Green** (#A8E6CF) - Primary color
- **Warm Coral** (#FF8B94) - Accent color  
- **Sky Blue** (#89CFF0) - Highlight color
- **Sand Beige** (#F9F6F2) - Background color
- **Charcoal** (#333333) - Primary text
- **Soft Gray** (#666666) - Secondary text

## Contributing

Feel free to contribute to this project by submitting issues and pull requests.
