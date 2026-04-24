/// South African license disk PDF417 barcode parser
/// Format: % delimited fields in fixed position order

class SA417VehicleData {
  const SA417VehicleData({
    required this.licensePlate,
    required this.make,
    required this.model,
    required this.year,
    required this.colour,
    this.vin,
    this.engineNumber,
    this.registrationNumber,
    this.vehicleType,
    this.licenseExpiry,
  });

  final String licensePlate;
  final String make;
  final String model;
  final int year;
  final String colour;
  final String? vin;
  final String? engineNumber;
  final String? registrationNumber;
  final String? vehicleType;
  final DateTime? licenseExpiry;
}

class PDF417ParseException implements Exception {
  const PDF417ParseException(this.message);
  final String message;
  @override
  String toString() => 'PDF417ParseException: $message';
}

class SA417Parser {
  static SA417VehicleData parse(String raw) {
    if (raw.isEmpty) {
      throw const PDF417ParseException('Empty barcode data');
    }

    final fields = raw
        .split('%')
        .map((f) => f.trim())
        .toList();

    final plateRegex = RegExp(r'^[A-Z]{2,3}\d{2,3}[A-Z]{2,3}$');

    String licensePlate = '';
    int plateIndex = -1;
    for (int i = 0; i < fields.length; i++) {
      if (plateRegex.hasMatch(fields[i])) {
        licensePlate = fields[i];
        plateIndex   = i;
        break;
      }
    }

    if (plateIndex == -1 || licensePlate.isEmpty) {
      throw PDF417ParseException(
          'Could not find license plate in barcode data');
    }

    final registrationNumber = _get(fields, plateIndex + 1);
    final vehicleType        = _get(fields, plateIndex + 2);
    final make               = _clean(_get(fields, plateIndex + 3));
    final model              = _clean(_get(fields, plateIndex + 4));
    final colourRaw          = _get(fields, plateIndex + 5);
    final vin                = _get(fields, plateIndex + 6);
    final engineNumber       = _get(fields, plateIndex + 7);
    final expiryStr          = _get(fields, plateIndex + 8);

    final colour = colourRaw.contains('/')
        ? colourRaw.split('/').first.trim()
        : colourRaw;

    final expiry = _parseExpiry(expiryStr);
    final year   = _extractYearFromVin(vin) ??
        (expiry != null ? expiry.year - 1 : 0);

    return SA417VehicleData(
      licensePlate:       licensePlate,
      make:               make.isEmpty ? 'Unknown' : make,
      model:              model.isEmpty ? 'Unknown' : model,
      year:               year,
      colour:             colour.isEmpty ? 'Unknown' : colour,
      vin:                vin.isEmpty ? null : vin,
      engineNumber:       engineNumber.isEmpty ? null : engineNumber,
      registrationNumber: registrationNumber.isEmpty ? null : registrationNumber,
      vehicleType:        vehicleType.isEmpty ? null : vehicleType,
      licenseExpiry:      expiry,
    );
  }

  static String _get(List<String> fields, int index) {
    if (index < 0 || index >= fields.length) return '';
    return fields[index].trim();
  }

  static String _clean(String s) =>
      s.replaceAll(RegExp(r'\s+'), ' ').trim();

  static DateTime? _parseExpiry(String s) {
    if (s.isEmpty) return null;
    try {
      if (s.contains('-')) {
        final parts = s.split('-');
        if (parts.length >= 2) {
          return DateTime(int.parse(parts[0]), int.parse(parts[1]));
        }
      }
    } catch (_) {}
    return null;
  }

  static int? _extractYearFromVin(String vin) {
    if (vin.length < 10) return null;
    final code = vin[9].toUpperCase();

    const letters = {
      'A': [1980, 2010], 'B': [1981, 2011], 'C': [1982, 2012],
      'D': [1983, 2013], 'E': [1984, 2014], 'F': [1985, 2015],
      'G': [1986, 2016], 'H': [1987, 2017], 'J': [1988, 2018],
      'K': [1989, 2019], 'L': [1990, 2020], 'M': [1991, 2021],
      'N': [1992, 2022], 'P': [1993, 2023], 'R': [1994, 2024],
      'S': [1995, 2025], 'T': [1996, 2026], 'V': [1997, 2027],
      'W': [1998, 2028], 'X': [1999, 2029], 'Y': [2000, 2030],
    };
    const digits = {
      '1': 2001, '2': 2002, '3': 2003, '4': 2004, '5': 2005,
      '6': 2006, '7': 2007, '8': 2008, '9': 2009,
    };

    if (letters.containsKey(code)) {
      final years = letters[code]!;
      final currentYear = DateTime.now().year;
      return years.lastWhere(
            (y) => y <= currentYear,
        orElse: () => years.first,
      );
    }
    if (digits.containsKey(code)) return digits[code];
    return null;
  }
}