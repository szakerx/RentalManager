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
    var _selectedDay = DateTime.now();
    return {
    _selectedDay.subtract(Duration(days: 30)): [
    'Event A0',
    'Event B0',
    'Event C0'
    ],
    _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
    _selectedDay.subtract(Duration(days: 20)): [
    'Event A2',
    'Event B2',
    'Event C2',
    'Event D2'
    ],
    _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
    _selectedDay.subtract(Duration(days: 10)): [
    'Event A4',
    'Event B4',
    'Event C4'
    ],
    _selectedDay.subtract(Duration(days: 4)): [
    'Event A5',
    'Event B5',
    'Event C5'
    ],
    _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
    _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
    _selectedDay.add(Duration(days: 1)): [
    'Event A8',
    'Event B8',
    'Event C8',
    'Event D8'
    ],
    };
  }
}