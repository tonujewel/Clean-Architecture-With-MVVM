enum LanguageType { ENGLISH, ARABIK }

const String ENGLISH = 'en';
const String ARABIK = 'ar';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIK:
        return ARABIK;
    }
  }
}
