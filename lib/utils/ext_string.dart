extension ExtString on String {
  bool get isUrl {
    const urlPattern =
        r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,,.;]*)?";
    final urlRegExp = RegExp(urlPattern, caseSensitive: false);
    return urlRegExp.hasMatch(this);
  }
}
