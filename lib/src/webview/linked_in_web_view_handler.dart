import 'package:easy_linkedin_login/src/core/exceptions.dart';
import 'package:easy_linkedin_login/src/core/linkedin_api.dart';
import 'package:easy_linkedin_login/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Class will fetch code and access token from the user
/// It will show web view so that we can access to linked in auth page
///
/// [getUserProfile] is required, if you want to get the user profile
/// [appBar] is optional, if you want to show custom app bar
/// [destroySession] is optional, if you want to destroy the session after getting the user profile or auth token
@immutable
class LinkedInWebViewHandler extends StatefulWidget {
  const LinkedInWebViewHandler({
    required this.getUserProfile,
    this.appBar,
    this.destroySession = false,
  });

  final bool destroySession;
  final PreferredSizeWidget? appBar;
  final bool getUserProfile;

  @override
  State createState() => _LinkedInWebViewHandlerState();
}

class _LinkedInWebViewHandlerState extends State<LinkedInWebViewHandler> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) async {
            final isMatch =
                request.url.startsWith(LinkedInApi.instance.config.redirectUrl);
            if (isMatch) {
              await authorizeUser(request.url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(LinkedInApi.instance.config.initialUrl));

    if (widget.destroySession) {
      log('LinkedInAuth-steps: cache clearing... ');
      WebViewCookieManager().clearCookies();
      _controller
        ..clearLocalStorage()
        ..clearCache();
    }
  }

  Future<void> authorizeUser(String url) async {
    try {
      final authCode = url.split('?').last.split('&').first.split('=').last;
      final accessTokenData =
          await LinkedInApi.instance.login(authCode: authCode);
      if (!widget.getUserProfile && mounted) {
        Navigator.of(context).pop(accessTokenData);
        return;
      }
      if (accessTokenData.tokenType != null &&
          accessTokenData.accessToken != null) {
        final userInfo = await LinkedInApi.instance.getUserInfo(
          tokenType: accessTokenData.tokenType!,
          token: accessTokenData.accessToken!,
        );
        if (mounted) {
          Navigator.of(context).pop(
            userInfo.copyWith(accessToken: accessTokenData),
          );
        }
      }
    } on HttpResponseException catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      if (mounted) {
        Navigator.of(context).pop(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.appBar,
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
