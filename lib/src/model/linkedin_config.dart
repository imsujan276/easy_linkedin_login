import 'package:uuid/uuid.dart';

/// LinkedIn configuration class
class LinkedInConfig {
  LinkedInConfig({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUrl,
    this.scopes = const ['openid', 'profile', 'email'],
  });

  final String clientId;
  final String clientSecret;
  final String redirectUrl;
  final List<String> scopes;

  String get initialUrl => 'https://www.linkedin.com/oauth/v2/authorization?'
      'response_type=code'
      '&client_id=$clientId'
      '&redirect_uri=$redirectUrl'
      '&state=${const Uuid().v4()}'
      '&scope=${scopes.join('%20')}';
}
