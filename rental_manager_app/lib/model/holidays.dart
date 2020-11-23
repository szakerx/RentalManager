class Holidays {
  Map<DateTime, List<String>> holidaysMap = Map();

  Holidays._singleton() {
    holidaysMap = _getHolidaysMap();
  }
  static final Holidays _instance = Holidays._singleton();

  factory Holidays() {
    return _instance;
  }

  Map<DateTime, List<String>> _getHolidaysMap() {
    return {
      DateTime(2020, 11, 23): ["Przykład 1", "Przykład 2"],
    };
  }
}