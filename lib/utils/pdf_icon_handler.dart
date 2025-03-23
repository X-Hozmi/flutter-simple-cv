import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PDFIconHandler {
  static pw.Font? fontAwesomeFont;
  static Map<String, pw.ImageProvider> iconImages = {};

  static Future<void> initialize() async {
    try {
      // Load Font Awesome font
      final fontAwesomeData = await rootBundle.load('fonts/fa-solid-900.ttf');
      fontAwesomeFont = pw.Font.ttf(fontAwesomeData);

      // Preload SVG icon images from assets
      await _preloadSvgIcons();
    } catch (e) {
      log('Failed to load icon fonts: $e');
    }
  }

  static Future<void> _preloadSvgIcons() async {
    try {
      // Define SVG icon paths
      final icons = {
        'github': 'icons/github.svg',
        'linkedin': 'icons/linkedin.svg',
        'instagram': 'icons/instagram.svg',
        'envelope': 'icons/envelope.svg',
        'phone': 'icons/phone.svg',
        'location-dot': 'icons/location-dot.svg',
        'link': 'icons/link.svg',
      };

      for (final entry in icons.entries) {
        try {
          // Check if the asset exists before trying to load it
          bool exists = await _assetExists(entry.value);
          if (!exists) {
            log('Asset not found: ${entry.value}');
            continue;
          }

          final svgString = await rootBundle.loadString(entry.value);
          final pngBytes = await _svgToPng(svgString, 512, 512);

          if (pngBytes != null) {
            final image = pw.MemoryImage(pngBytes);
            iconImages[entry.key] = image;
          }
        } catch (e) {
          log('Failed to load SVG icon for ${entry.key}: $e');
        }
      }
    } catch (e) {
      log('Error in preloading SVG icons: $e');
    }
  }

  static String generateFallbackSvg(String iconName) {
    // Create a simple SVG with the first letter of the icon name
    final letter = iconName.isNotEmpty ? iconName[0].toUpperCase() : 'I';
    return '''
  <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 64 64">
    <circle cx="32" cy="32" r="30" fill="#CCCCCC" />
    <text x="32" y="40" font-family="Arial" font-size="24" text-anchor="middle" fill="#666666">$letter</text>
  </svg>
  ''';
  }

  // Helper method to check if an asset exists
  static Future<bool> _assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  // Helper method to convert SVG to PNG bytes using the updated SVG API
  static Future<Uint8List?> _svgToPng(
      String svgString, double width, double height) async {
    try {
      // Load the SVG picture using SvgStringLoader
      final PictureInfo pictureInfo =
          await vg.loadPicture(SvgStringLoader(svgString), null);

      // Convert to an image with specified dimensions
      final ui.Image image =
          await pictureInfo.picture.toImage(width.toInt(), height.toInt());

      // Clean up resources
      pictureInfo.picture.dispose();

      // Get the bytes from the Image
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        return byteData.buffer.asUint8List();
      }

      return null;
    } catch (e) {
      log('Error converting SVG to PNG: $e');
      return null;
    }
  }

  static bool get fontsLoaded => fontAwesomeFont != null;

  static pw.Widget fontAwesomeIcon(IconData icon,
      {double size = 16, PdfColor color = PdfColors.black}) {
    // Try to find the matching icon name for the given IconData
    String? iconName;
    if (icon.codePoint == FontAwesomeIcons.github.codePoint) {
      iconName = 'github';
    } else if (icon.codePoint == FontAwesomeIcons.linkedin.codePoint) {
      iconName = 'linkedin';
    } else if (icon.codePoint == FontAwesomeIcons.instagram.codePoint) {
      iconName = 'instagram';
    } else if (icon.codePoint == FontAwesomeIcons.envelope.codePoint) {
      iconName = 'envelope';
    } else if (icon.codePoint == FontAwesomeIcons.phone.codePoint) {
      iconName = 'phone';
    } else if (icon.codePoint == FontAwesomeIcons.locationDot.codePoint) {
      iconName = 'location-dot';
    } else if (icon.codePoint == FontAwesomeIcons.link.codePoint) {
      iconName = 'link';
    }

    // If we have a rasterized image for this icon, use it
    if (iconName != null && iconImages.containsKey(iconName)) {
      return pw.Image(
        iconImages[iconName]!,
        width: size,
        height: size,
        fit: pw.BoxFit.contain,
      );
    }

    // Try to use the font if available
    if (fontAwesomeFont != null) {
      try {
        return pw.Text(
          String.fromCharCode(icon.codePoint),
          style: pw.TextStyle(
            font: fontAwesomeFont,
            fontSize: size,
            color: color,
          ),
        );
      } catch (e) {
        log('Failed to render icon with font: $e');
        // Fall through to the fallback
      }
    }

    // Text fallback if font rendering fails and no image is available
    return pw.Text(
      _getUnicodeForFAIcon(icon),
      style: pw.TextStyle(fontSize: size, color: color),
    );
  }

  static pw.Widget socialIcon(String iconName,
      {double size = 16, PdfColor color = PdfColors.black}) {
    // If we have an image for this icon, use it directly
    if (iconImages.containsKey(iconName)) {
      return pw.Image(
        iconImages[iconName]!,
        width: size,
        height: size,
        fit: pw.BoxFit.contain,
      );
    }

    // Otherwise, try to use the font awesome icon
    final iconMap = {
      'envelope': FontAwesomeIcons.envelope,
      'phone': FontAwesomeIcons.phone,
      'github': FontAwesomeIcons.github,
      'linkedin': FontAwesomeIcons.linkedin,
      'instagram': FontAwesomeIcons.instagram,
      'location-dot': FontAwesomeIcons.locationDot,
      'link': FontAwesomeIcons.link,
    };

    final icon = iconMap[iconName] ?? FontAwesomeIcons.link;
    return fontAwesomeIcon(icon, size: size, color: color);
  }

  static String _getUnicodeForFAIcon(IconData icon) {
    if (icon.codePoint == FontAwesomeIcons.envelope.codePoint) return '✉️';
    if (icon.codePoint == FontAwesomeIcons.phone.codePoint) return '📞';
    if (icon.codePoint == FontAwesomeIcons.github.codePoint) return 'GH';
    if (icon.codePoint == FontAwesomeIcons.linkedin.codePoint) return 'LI';
    if (icon.codePoint == FontAwesomeIcons.instagram.codePoint) return 'IG';
    if (icon.codePoint == FontAwesomeIcons.locationDot.codePoint) return '📍';
    return '🔗';
  }
}
