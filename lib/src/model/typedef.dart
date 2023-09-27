import 'package:easy_linkedin_login/src/core/exceptions.dart';

import 'models.dart';

typedef OnGetAuthToken = void Function(LinkedInAccessToken data);
typedef OnGetUserProfile = void Function(LinkedInUserModel user);
typedef OnError = void Function(HttpResponseException error);
