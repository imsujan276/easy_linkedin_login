import 'dart:convert';

/// LinkedIn Locale information
class LinkedInLocale {
  LinkedInLocale({this.country, this.language});

  factory LinkedInLocale.fromMap(Map<String, dynamic> map) {
    return LinkedInLocale(
      country: map['country'] != null ? map['country'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
    );
  }

  factory LinkedInLocale.fromJson(String source) =>
      LinkedInLocale.fromMap(json.decode(source) as Map<String, dynamic>);

  final String? country;
  final String? language;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'language': language,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'LinkedInLocale(country: $country, language: $language)';
}
