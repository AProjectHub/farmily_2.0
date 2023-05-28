class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇮🇳", "हिंदी", "hi"),
      Language(3, "🇮🇳", "मराठी", "mr"),
      Language(4, "🇮🇳", "ਪੰਜਾਬੀ", "pa"),
      Language(5, "🇮🇳", "తెలుగు", "te"),
      Language(6, "🇮🇳", "অসমীয়া", "as")
    ];
  }
}