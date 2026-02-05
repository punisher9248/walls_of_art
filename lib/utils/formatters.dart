/// Utility class for formatting various values
class Formatters {
  Formatters._();

  /// Format file size in human-readable format
  static String fileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Format resolution (e.g., "3840 × 2160")
  static String resolution(int width, int height) {
    return '$width × $height';
  }

  /// Format megapixels (e.g., "8.3 MP")
  static String megapixels(int width, int height) {
    final mp = (width * height) / 1000000;
    return '${mp.toStringAsFixed(1)} MP';
  }

  /// Format aspect ratio (e.g., "16:9")
  static String aspectRatio(int width, int height) {
    final gcd = _gcd(width, height);
    final w = width ~/ gcd;
    final h = height ~/ gcd;
    return '$w:$h';
  }

  /// Calculate GCD using Euclidean algorithm
  static int _gcd(int a, int b) {
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a;
  }

  /// Format count with suffix (e.g., "1.2K", "3.4M")
  static String compactNumber(int number) {
    if (number < 1000) return number.toString();
    if (number < 1000000) return '${(number / 1000).toStringAsFixed(1)}K';
    if (number < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
    return '${(number / 1000000000).toStringAsFixed(1)}B';
  }

  /// Format number with thousands separator
  static String numberWithCommas(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  /// Format duration (e.g., "2h 30m")
  static String duration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  /// Format date as "Jan 15, 2024"
  static String date(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Get resolution label based on dimensions
  static String resolutionLabel(int width, int height) {
    final maxDim = width > height ? width : height;

    if (maxDim >= 7680) return '8K';
    if (maxDim >= 3840) return '4K';
    if (maxDim >= 2560) return 'QHD';
    if (maxDim >= 1920) return 'FHD';
    if (maxDim >= 1280) return 'HD';
    return 'SD';
  }
}
