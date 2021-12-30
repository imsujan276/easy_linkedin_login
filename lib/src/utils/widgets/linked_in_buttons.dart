import 'package:flutter/material.dart';

/// Class will generate standard flutter button, but with properties you can
/// modify look of the button
/// Also, you don't need to use this widget, you can use standard button widget
@immutable
class LinkedInButtonStandardWidget extends StatelessWidget {
  /// Create button with some default values, which you can of course change
  /// whenever you want
  const LinkedInButtonStandardWidget({
    required this.onTap,
    this.iconHeight = 30,
    this.iconWidth = 30,
    this.iconAssetPath,
    this.buttonText = 'Sign in with LinkedIn',
    this.buttonColor = Colors.white,
    this.textPadding = const EdgeInsets.all(4),
    this.standardButton = true,
    this.customWidget,
  });

  final Function onTap;
  final double iconHeight, iconWidth;
  final String? iconAssetPath;
  final String buttonText;
  final Color buttonColor;
  final EdgeInsets textPadding;
  final bool standardButton;
  final Widget? customWidget;

  @override
  Widget build(BuildContext context) => Material(
        child: InkWell(
          onTap: onTap as void Function()?,
          // ignore: prefer_if_null_operators
          child: customWidget != null
              ? customWidget
              : standardButton
                  ? Container(
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            iconAssetPath ?? 'assets/linked_in_logo.png',
                            package: iconAssetPath == null
                                ? 'easy_linkedin_login'
                                : null,
                            width: iconWidth,
                            height: iconHeight,
                          ),
                          Container(
                            padding: textPadding,
                            color: Colors.blue,
                            child: Text(
                              buttonText,
                              style: TextStyle(
                                color: buttonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Image.asset(
                      iconAssetPath ?? 'assets/linked_in_logo.png',
                      package:
                          iconAssetPath == null ? 'easy_linkedin_login' : null,
                      width: iconWidth,
                      height: iconHeight,
                    ),
        ),
      );
}
