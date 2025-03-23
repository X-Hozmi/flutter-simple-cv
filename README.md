# Flutter CV Template

A simple, elegant CV (Curriculum Vitae) template built with Flutter for the web. This project allows users to create professional CVs with easy customization options and multiple export formats.

## Features

- **Clean, Professional Design**: Modern CV layout inspired by contemporary resume standards
- **Multiple Export Options**:
  - Preview CV in a new window
  - Preview as PDF in a new window
  - Download as PNG image
  - Download as JPG image
- **JSON-based Configuration**: Easy customization through JSON files
- **Responsive Layout**: Looks great on different screen sizes

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (latest stable version)
- A code editor (VS Code, Android Studio, etc.)
- Basic knowledge of Flutter and Dart

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/X-Hozmi/flutter-simple-cv.git
   ```

2. Navigate to the project directory:

   ```bash
   cd flutter-simple-cv
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Configure your CV data:
   - Navigate to `assets/cv/`
   - Rename the template files by removing the `_template` suffix:
     - `experiences_template.json` → `experiences.json`
     - `profile_template.json` → `profile.json`
     - `socials_template.json` → `socials.json`
     - Any other JSON files that have the `_template` suffix

5. Run the project:

   ```bash
   flutter run -d chrome
   ```

## Customization

### Personal Information

Edit the JSON files in the `assets/cv/` directory to customize your CV:

- `profile.json`: Your name, title, location, and about section
- `experiences.json`: Your work experience
- `socials.json`: Your social media links and contact information

### Styling

To customize the appearance of your CV:

- Modify the layout in `lib/presentation/pages/CV/cv_page.dart`

## Building for Production

To build the web app for deployment:

```bash
flutter build web --release
```

The output will be in the `build/web` directory, which you can deploy to any web hosting service like GitHub Pages, Netlify, or Firebase Hosting.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Acknowledgements

- [PDF](https://pub.dev/packages/pdf) - For PDF generation
- [Printing](https://pub.dev/packages/printing) - For print functionality
- [Google Fonts](https://pub.dev/packages/google_fonts) - For typography

---

Created by [Abdillah Haidar Mahendro](https://github.com/X-Hozmi)****
