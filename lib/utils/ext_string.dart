extension ExtString on String {
  bool get isUrl {
    const urlPattern =
        r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,,.;]*)?";
    final urlRegExp = RegExp(urlPattern, caseSensitive: false);
    return urlRegExp.hasMatch(this);
  }

  String formatDuration() {
    final parts = split(':');
    if (parts.length == 3) {
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      // final seconds = int.tryParse(parts[2]) ?? 0;

      final totalMinutes = hours * 60 + minutes;

      return '$totalMinutes m';
    } else {
      return this; // Kembalikan string asli jika formatnya tidak valid
    }
  }
}
