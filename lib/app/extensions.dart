// extension on string
extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
}

// extension on string
extension NonNullInteger on int? {
  int orEmpty() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

// extension on double
extension NonNullDouble on double? {
  double orEmpty() {
    if (this == null) {
      return 0.0;
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
