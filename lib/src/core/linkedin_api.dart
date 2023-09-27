import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_linkedin_login/src/model/linkedin_access_token.dart';
import 'package:easy_linkedin_login/src/model/linkedin_config.dart';
import 'package:easy_linkedin_login/src/model/linkedin_user.dart';
import 'package:easy_linkedin_login/src/utils/logger.dart';
import 'package:http/http.dart' as http;

import 'api_endpoint.dart';
import 'exceptions.dart';

/// LinkedIn API service class
class LinkedInApi {
  LinkedInApi._();
  static final instance = LinkedInApi._();

  late LinkedInConfig config;

  final httpClient = http.Client();

  /// login method to get the access token
  Future<LinkedInAccessToken> login({required String? authCode}) async {
    log('LinkedInAuth-steps: trying to login...');
    final Map<String, dynamic> body = {
      'grant_type': 'authorization_code',
      'code': authCode,
      'client_id': config.clientId,
      'client_secret': config.clientSecret,
      'redirect_uri': config.redirectUrl,
    };
    final response = await httpClient.post(
      Uri.parse(ApiEndpoint().accessToken),
      body: body,
    );

    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      log('LinkedInAuth-steps: trying to login DONE');
      return LinkedInAccessToken.fromMap(responseBody);
    } else {
      log('LinkedInAuth-steps: trying to login FAILED');
      throw HttpResponseException(
        statusCode: response.statusCode,
        message: responseBody['error'],
      );
    }
  }

  /// get the user info from the access token
  Future<LinkedInUserModel> getUserInfo({
    required String token,
    required String tokenType,
  }) async {
    log('LinkedInAuth-steps: getting user profile...');
    final response = await httpClient.get(
      Uri.parse(ApiEndpoint().userInfo),
      headers: {
        HttpHeaders.authorizationHeader: '$tokenType $token',
      },
    );
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      log('LinkedInAuth-steps: getting user profile DONE');
      return LinkedInUserModel.fromMap(responseBody);
    } else {
      log('LinkedInAuth-steps: getting user profile FAILED');
      throw HttpResponseException(
        statusCode: response.statusCode,
        message: responseBody['message'],
      );
    }
  }

  String takeUrl(String value) {
    return value.split('?').first;
  }
}
