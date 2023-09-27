import 'package:easy_linkedin_login/src/core/exceptions.dart';

import 'models.dart';

/// Callbacks for LinkedIn Login which returns [LinkedInAccessToken]
///
/// [LinkedInAccessToken] contains the access token and expiry time
typedef OnGetAuthToken = void Function(LinkedInAccessToken data);

/// Callbacks for LinkedIn Login which returns [LinkedInUserModel]
///
/// [LinkedInUserModel] contains the user profile
typedef OnGetUserProfile = void Function(LinkedInUserModel user);

/// Callbacks for LinkedIn Login error which returns [HttpResponseException]
///
/// [HttpResponseException] contains the error message and status code
typedef OnError = void Function(HttpResponseException error);
