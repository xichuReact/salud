// Generates a high-definition iOS app icon PNG (1024x1024)
// with a red heart on a white background.
// Run: dart run tool/generate_app_icon.dart

import 'dart:io';
import 'package:image/image.dart' as img;

void main() async {
  const size = 1024; // Apple App Store icon size
  final image = img.Image(width: size, height: size);

  // Background: pure white
  img.fill(image, color: img.ColorRgba8(255, 255, 255, 255));

  // Draw a centered red-to-pink gradient heart that works well with circular Android icons
  // Heart equation: (x^2 + y^2 - 1)^3 - x^2 * y^3 <= 0 in normalized coords
  const heartScale = 0.50; // larger centered heart (~50% of icon)
  final red = img.ColorRgba8(220, 0, 40, 255);
  final pink = img.ColorRgba8(255, 105, 180, 255); // gradient top

  // Center of heart: exactly in the middle
  final heartCenterX = size * 0.50;
  final heartCenterY = size * 0.50;
  final heartSize = size * heartScale;

  for (int py = 0; py < size; py++) {
    for (int px = 0; px < size; px++) {
      // Translate to heart-local coordinates
      final dx = px - heartCenterX;
      final dy = py - heartCenterY;
      
      // Normalize to [-1.2, 1.2] range for the heart equation
      final xn = dx / (heartSize * 0.5);
      final yn = -dy / (heartSize * 0.5); // invert Y to keep heart upright
      
      final x2 = xn * xn;
      final y2 = yn * yn;
      final expr = (x2 + y2 - 1);
      final value = expr * expr * expr - x2 * yn * yn * yn;
      
      if (value <= 0) {
        // Gradient from pink at top to red at bottom
        final t = (yn + 1.2) / 2.4; // 0..1 from top to bottom
        final r = (pink.r * (1 - t) + red.r * t).round();
        final g = (pink.g * (1 - t) + red.g * t).round();
        final b = (pink.b * (1 - t) + red.b * t).round();
        image.setPixel(px, py, img.ColorRgba8(r, g, b, 255));
      }
    }
  }

  // Slight edge smoothing: a single-pass box blur on alpha edges (optional minimal)
  // Skipped to keep heart crisp on iOS icons.

  final outDir = Directory('assets/icon');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }
  final outFile = File('assets/icon/icon.png');
  outFile.writeAsBytesSync(img.encodePng(image));
  stdout.writeln('Generated iOS icon at: ${outFile.path}');
}
