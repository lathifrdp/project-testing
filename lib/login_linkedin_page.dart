import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

class LoginLinkedinPage extends StatefulWidget {
  const LoginLinkedinPage({super.key});

  @override
  State<LoginLinkedinPage> createState() => _LoginLinkedinPageState();
}

class _LoginLinkedinPageState extends State<LoginLinkedinPage> {
  String redirectUrl = 'https://www.youtube.com/callback';
  String clientId = '77smebhz9cdgwa';
  String clientSecret = 'tJ8IvisfOv5pnbVG';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
              Tab(icon: Icon(Icons.text_fields), text: 'Auth code')
            ],
          ),
          title: const Text('LinkedIn Authorization'),
        ),
        body: TabBarView(
          children: [
            linkedInProfileExamplePage(),
            linkedInAuthCodeExamplePage(),
          ],
        ),
      ),
    );
  }

  Widget linkedInProfileExamplePage() {
    UserObject user = UserObject();
    bool logoutUser = false;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          LinkedInButtonStandardWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (final BuildContext context) => LinkedInUserWidget(
                    appBar: AppBar(
                      title: const Text('OAuth User'),
                    ),
                    destroySession: logoutUser,
                    redirectUrl: redirectUrl,
                    clientId: clientId,
                    clientSecret: clientSecret,
                    projection: const [
                      ProjectionParameters.id,
                      ProjectionParameters.localizedFirstName,
                      ProjectionParameters.localizedLastName,
                      ProjectionParameters.firstName,
                      ProjectionParameters.lastName,
                      ProjectionParameters.profilePicture,
                    ],
                    onError: (final UserFailedAction e) {
                      print('Error: ${e.toString()}');
                      print('Error: ${e.stackTrace.toString()}');
                    },
                    onGetUserProfile: (final UserSucceededAction linkedInUser) {
                      print(
                        'Access token ${linkedInUser.user.token.accessToken}',
                      );

                      print('User id: ${linkedInUser.user.userId}');
                      print(linkedInUser.user.firstName?.localized?.label);

                      user = UserObject(
                        firstName:
                            linkedInUser.user.firstName?.localized?.label ?? "",
                        lastName:
                            linkedInUser.user.lastName?.localized?.label ?? "",
                        email: linkedInUser.user.email?.elements?[0].handleDeep
                                ?.emailAddress ??
                            "",
                        profileImageUrl: linkedInUser
                                .user
                                .profilePicture
                                ?.displayImageContent
                                ?.elements?[0]
                                .identifiers?[0]
                                .identifier ??
                            "",
                      );

                      user.firstName =
                          linkedInUser.user.firstName?.localized?.label ?? "";

                      setState(() {
                        logoutUser = false;
                        print(user.firstName);
                      });

                      Navigator.pop(context);
                    },
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          LinkedInButtonStandardWidget(
            onTap: () {
              setState(() {
                user = UserObject();
                logoutUser = true;
              });
            },
            buttonText: 'Logout',
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('First: ${user.firstName} '),
              Text('Last: ${user.lastName} '),
              Text('Email: ${user.email}'),
              Text('Profile image: ${user.profileImageUrl}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget linkedInAuthCodeExamplePage() {
    AuthCodeObject authorizationCode = AuthCodeObject();
    bool logoutUser = false;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        LinkedInButtonStandardWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (final BuildContext context) => LinkedInAuthCodeWidget(
                  destroySession: logoutUser,
                  redirectUrl: redirectUrl,
                  clientId: clientId,
                  onError: (final AuthorizationFailedAction e) {
                    print('Error: ${e.toString()}');
                    print('Error: ${e.stackTrace.toString()}');
                  },
                  onGetAuthCode: (final AuthorizationSucceededAction response) {
                    print('Auth code ${response.codeResponse.code}');

                    print('State: ${response.codeResponse.state}');

                    authorizationCode = AuthCodeObject(
                      code: response.codeResponse.code ?? "",
                      state: response.codeResponse.state ?? "",
                    );
                    setState(() {});

                    Navigator.pop(context);
                  },
                ),
                fullscreenDialog: true,
              ),
            );
          },
        ),
        LinkedInButtonStandardWidget(
          onTap: () {
            setState(() {
              authorizationCode = AuthCodeObject();
              logoutUser = true;
            });
          },
          buttonText: 'Logout user',
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Auth code: ${authorizationCode.code} '),
              Text('State: ${authorizationCode.state} '),
            ],
          ),
        ),
      ],
    );
  }
}

class AuthCodeObject {
  AuthCodeObject({this.code, this.state});

  String? code;
  String? state;
}

class UserObject {
  UserObject({
    this.firstName,
    this.lastName,
    this.email,
    this.profileImageUrl,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? profileImageUrl;
}
