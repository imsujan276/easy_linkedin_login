import 'package:easy_linkedin_login/src/core/exceptions.dart';
import 'package:easy_linkedin_login/src/core/linkedin_api.dart';
import 'package:easy_linkedin_login/src/model/models.dart';
import 'package:easy_linkedin_login/src/webview/linked_in_web_view_handler.dart';
import 'package:flutter/material.dart';

/// Class will generate custom flutter button of your choice
///
///
@immutable
class LinkedInCustomButton extends StatefulWidget {
  const LinkedInCustomButton({
    required this.config,
    required this.child,
    this.onGetUserProfile,
    this.onGetAuthToken,
    this.onError,
    this.appBar,
    this.destroySession = false,
  });

  final LinkedInConfig config;
  final PreferredSizeWidget? appBar;
  final OnGetUserProfile? onGetUserProfile;
  final OnGetAuthToken? onGetAuthToken;
  final OnError? onError;
  final Widget child;
  final bool destroySession;

  @override
  State<LinkedInCustomButton> createState() => _LinkedInCustomButtonState();
}

class _LinkedInCustomButtonState extends State<LinkedInCustomButton> {
  @override
  void initState() {
    LinkedInApi.instance.config = widget.config;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: InkWell(
          child: widget.child,
          onTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LinkedInWebViewHandler(
                  appBar: widget.appBar,
                  getUserProfile: widget.onGetUserProfile != null,
                  destroySession: widget.destroySession,
                ),
                fullscreenDialog: true,
              ),
            );
            if (result is LinkedInAccessToken) {
              widget.onGetAuthToken?.call(result);
            } else if (result is LinkedInUserModel) {
              widget.onGetUserProfile?.call(result);
            } else if (result is HttpResponseException) {
              widget.onError?.call(result);
            }
          },
        ),
      );
}
