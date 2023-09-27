import 'package:easy_linkedin_login/src/core/exceptions.dart';
import 'package:easy_linkedin_login/src/core/linkedin_api.dart';
import 'package:easy_linkedin_login/src/model/models.dart';
import 'package:easy_linkedin_login/src/webview/linked_in_web_view_handler.dart';
import 'package:flutter/material.dart';

/// Class will generate standard flutter button
@immutable
class LinkedInStandardButton extends StatefulWidget {
  const LinkedInStandardButton({
    required this.config,
    this.appBar,
    this.onGetUserProfile,
    this.onGetAuthToken,
    this.onError,
    this.iconHeight,
    this.iconWidth,
    this.iconAssetPath,
    this.destroySession = false,
    this.mini = false,
  });

  final LinkedInConfig config;
  final PreferredSizeWidget? appBar;
  final OnGetUserProfile? onGetUserProfile;
  final OnGetAuthToken? onGetAuthToken;
  final OnError? onError;
  final double? iconHeight, iconWidth;
  final String? iconAssetPath;
  final bool destroySession;
  final bool mini;

  @override
  State<LinkedInStandardButton> createState() => _LinkedInStandardButtonState();
}

class _LinkedInStandardButtonState extends State<LinkedInStandardButton> {
  @override
  void initState() {
    LinkedInApi.instance.config = widget.config;
    super.initState();
  }

  double iconWidth() {
    if (widget.iconWidth != null) {
      return widget.iconWidth!;
    } else if (widget.mini) {
      return 35;
    } else {
      return 175;
    }
  }

  double iconHeight() {
    if (widget.iconHeight != null) {
      return widget.iconHeight!;
    } else if (widget.mini) {
      return 35;
    } else {
      return 35;
    }
  }

  String getIconPath() {
    if (widget.iconAssetPath != null) {
      return widget.iconAssetPath!;
    } else if (widget.mini) {
      return 'assets/linked_in_logo.png';
    } else {
      return 'assets/linkedin-signin-button.png';
    }
  }

  @override
  Widget build(BuildContext context) => Material(
        child: InkWell(
          child: Image.asset(
            getIconPath(),
            package:
                widget.iconAssetPath == null ? 'easy_linkedin_login' : null,
            width: iconWidth(),
            height: iconHeight(),
            fit: BoxFit.cover,
          ),
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
