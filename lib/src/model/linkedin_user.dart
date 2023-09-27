import 'dart:convert';
import 'package:easy_linkedin_login/src/model/linkedin_access_token.dart';
import 'linkedin_locale.dart';

/// LinkedIn User information
class LinkedInUserModel {
  LinkedInUserModel({
    this.name,
    this.familyName,
    this.givenName,
    this.email,
    this.picture,
    this.sub,
    this.locale,
    this.accessToken,
  });

  factory LinkedInUserModel.fromMap(Map<String, dynamic> map) {
    return LinkedInUserModel(
      name: map['name'] != null ? map['name'] as String : null,
      familyName:
          map['family_name'] != null ? map['family_name'] as String : null,
      givenName: map['given_name'] != null ? map['given_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      sub: map['sub'] != null ? map['sub'] as String : null,
      locale: map['locale'] != null
          ? LinkedInLocale.fromMap(map['locale'] as Map<String, dynamic>)
          : null,
    );
  }

  factory LinkedInUserModel.fromJson(String source) =>
      LinkedInUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  final String? name;
  final String? familyName;
  final String? givenName;
  final String? email;
  final String? picture;
  final String? sub;
  final LinkedInLocale? locale;
  final LinkedInAccessToken? accessToken;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'family_name': familyName,
      'given_name': givenName,
      'email': email,
      'picture': picture,
      'sub': sub,
      'locale': locale?.toMap(),
      'accessToken': accessToken?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LinkedInUserModel(name: $name, familyName: $familyName, givenName: $givenName, email: $email, picture: $picture, sub: $sub, locale: $locale)';
  }

  LinkedInUserModel copyWith({
    String? name,
    String? familyName,
    String? givenName,
    String? email,
    String? picture,
    String? sub,
    LinkedInLocale? locale,
    LinkedInAccessToken? accessToken,
  }) {
    return LinkedInUserModel(
      name: name ?? this.name,
      familyName: familyName ?? this.familyName,
      givenName: givenName ?? this.givenName,
      email: email ?? this.email,
      picture: picture ?? this.picture,
      sub: sub ?? this.sub,
      locale: locale ?? this.locale,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
