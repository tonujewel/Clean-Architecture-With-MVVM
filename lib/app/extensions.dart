// extension on string
import '../data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return EMPTY;
    } else {
      return this!;
    }
  }
}

// extension on string
extension NonNullInteger on int? {
  int orEmpty() {
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}

// extension on double
extension NonNullDouble on double? {
  double orEmpty() {
    if (this == null) {
      return DOUBLE_ZERO;
    } else {
      return this!;
    }
  }
}

// extension on bool
extension NonNullBoolean on bool? {
  bool orEmpty() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}
