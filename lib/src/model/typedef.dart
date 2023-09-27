import 'package:easy_linkedin_login/src/core/exceptions.dart';

import 'models.dart';

/// Callbacks for LinkedIn Login which returns [LinkedInAccessToken]
typedef OnGetAuthToken = void Function(LinkedInAccessToken data);

/// Callbacks for LinkedIn Login which returns [LinkedInUserModel]
typedef OnGetUserProfile = void Function(LinkedInUserModel user);

/// Callbacks for LinkedIn Login error which returns [HttpResponseException]
typedef OnError = void Function(HttpResponseException error);
