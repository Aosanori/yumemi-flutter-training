class YumemiWeatherRepositoryException implements Exception {
  const YumemiWeatherRepositoryException(this.message);
  final String message;

  @override
  String toString() => message;
}
