import 'dart:convert';

/// When you get authorization code, you need to exchange to get access token
/// Expires in is time, when your access token will be invalid
class LinkedInAccessToken {
  LinkedInAccessToken({
    this.accessToken,
    this.tokenType,
    this.idToken,
    this.scope,
    this.expiresIn,
  });

  factory LinkedInAccessToken.fromMap(Map<String, dynamic> map) {
    return LinkedInAccessToken(
      accessToken:
          map['access_token'] != null ? map['access_token'] as String : null,
      tokenType: map['token_type'] != null ? map['token_type'] as String : null,
      idToken: map['id_token'] != null ? map['id_token'] as String : null,
      scope: map['scope'] != null ? map['scope'] as String : null,
      expiresIn: map['expires_in'] != null ? map['expires_in'] as int : null,
    );
  }

  factory LinkedInAccessToken.fromJson(String source) =>
      LinkedInAccessToken.fromMap(json.decode(source) as Map<String, dynamic>);

  String? accessToken;
  String? tokenType;
  String? idToken;
  String? scope;
  int? expiresIn;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'id_token': idToken,
      'scope': scope,
      'expires_in': expiresIn,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LinkedInAccessToken(accessToken: $accessToken, tokenType: $tokenType, idToken: $idToken, scope: $scope, expiresIn: $expiresIn)';
  }
}
