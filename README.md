# easy_linkedin_login

Added customization to the [linkedin_login](https://pub.dev/packages/linkedin_login) package

## ⭐⭐⭐⭐ Star ⭐⭐⭐⭐ a [Repository](https://github.com/imsujan276/easy_linkedin_login) if you like project. Your support matters to us.⭐⭐⭐⭐

## Important 

You should replace this values
    
    final String redirectUrl = 'YOUR-REDIRECT-URL';
    final String clientId = 'YOUR-CLIENT-ID';
    final String clientSecret = 'YOUR-CLIENT-SECRET';

`Note: clientSecret field is required just for LinkedInUserWidget`

To get these values you need to create App on the [LinkedIn](https://www.linkedin.com/developers/apps/new).

## Standard Widget
Standard LinkedIn button for login. This widget is modifiable.
```dart
  LinkedInButtonStandardWidget(onTap: () {});
```

## Widget with custom widget
```dart
  LinkedInButtonStandardWidget(
    customWidget: Text("Login with Linkedin"),
    onTap: () {},
  );
```

## Widget with customization
```dart
  LinkedInButtonStandardWidget(
    standardButton: false,
    iconAssetPath: IconAsset.linkedinIcon,
    iconWidth: 30,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LinkedInUserWidget(
            redirectUrl: kLinkedinRedirectURL,
            clientId: kLinkedinClientID,
            clientSecret: kLinkedinClientSecret,
            onGetUserProfile: (UserSucceededAction linkedInUser) async {
              print('Access token ${linkedInUser.user.token.accessToken!}');
              print('First name: ${linkedInUser.user.firstName!.localized!.label!}');
              print('Last name: ${linkedInUser.user.lastName!.localized!.label!}');
              Navigator.pop(context);
            },
            onError: (UserFailedAction e) {
              print('Error: ${e.toString()}');
              Navigator.pop(context);
            },
          ),
        ),
      );
    },
  );
```
## Samples
You can just fetch authorization code (clientSecret is not required in this widget):
```dart
    LinkedInAuthCodeWidget(
        redirectUrl: redirectUrl,
        clientId: clientId,
        onGetAuthCode:
            (AuthorizationSucceededAction response) {
                print('Auth code ${response.codeResponse.code!}');
                print('State: ${response.codeResponse.state!}');
            },
        onError: (AuthorizationFailedAction e) {
                print('Error: ${e.toString()}');
             },
    ),
```

If you want to logout user (to clear session from webview) all you need is to forward ```true``` value
to property ```destroySession```  in ```LinkedInUserWidget``` or ```LinkedInAuthCodeWidget```. Please don't forget to destroy your data in your local storage for this user. Currently, LinkedIn doesn't have API point on OAuth 2 which will destroy access token.

## Properties that are available after call for LinkedInUserWidget

```dart
  String firstName;
  String lastName;
  String accessToken;
  int expiresIn;
  String profilePicture;
  String email;
  String userId; (from version 0.1.)
```
## Projection - which properties of user account will be accessible via LinkedIn API
### Available from version 1.2.x

You can control projection, by providing array of strings to projection property of widget 
`LinkedInUserWidget`. By default these properties are included: 

```dart
  static const String id = "id";
  static const String localizedLastName = "localizedLastName";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String localizedFirstName = "localizedFirstName";
```

You can include also `profilePicture` to get URL of user profile image. If you change this property
to some custom value you will override default values, and you need to add every of these manually
to array. For more info see example project.

## Properties that are available after call for LinkedInAuthCodeWidget

```dart
  String code; // authorization code
  String state;
```


