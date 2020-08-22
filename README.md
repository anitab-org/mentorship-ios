# Mentorship System (iOS)

[Mentorship System](https://github.com/anitab-org/mentorship-backend) is an application that allows women in tech to mentor each other, on career development topics, through 1:1 relations for a certain period.

This is the iOS client for the Mentorship System.

## Setting up the project

1. Make sure you have Xcode IDE downloaded on your machine for development.<br />
2. Fork the project. Go to [mentorship-ios](https://github.com/anitab-org/mentorship-ios) and click on Fork in the top right corner to fork the repository to your Github account.<br />
3. Clone the project. Open the forked mentorship-ios repository from your GitHub account and click on the "Clone or Download" button. You should be able to see the option "Open in Xcode"; this is the recommended option and should be used to get a local copy of the project on your machine.<br />
4. Open your terminal and go to the project folder on your machine. Run the command `pod install` (note: you may first need to install cocoapods using `sudo gem install cocoapods`). A new .xcworkspace file shall be created.
4. You're all set now! Use the .xcworkspace file for development.<br />

## Setting up social sign-in (Optional)
The Mentorship iOS app currently supports two different social sign in providers - Apple and Google. 
The set-up for both of these is a little different and are explained below-
#### Set-up Sign in with Apple
1. You will need an Apple Developer Account and the 'Account Holder' or 'Admin' rights for that account.
2. Add capability in Xcode project as explained [here](https://help.apple.com/developer-account/?lang=en#/devde676e696).
3. Register outbound email domain (mentorshiptest@mail.com) on your Apple Developer account. [Instructions](https://help.apple.com/developer-account/?lang=en#/devf822fb8fc)
#### Set-up Sign in with Google
1. Generate OAuth client id for project from [here](https://developers.google.com/identity/sign-in/ios/start?ver=swift). You shall get a Configuration.plist file, save that for convenience.
2. Add reversed client id (from Configuration.plist file) as an URL type in Xcode project.
3. Add the client id in Config.plist file in the project for the key 'googleAuthClientId'.
4. To test Sign in with Google, you'll have to set-up the backend locally and use this same client-id as an environment variable. Please see the [instructions](https://github.com/anitab-org/mentorship-backend) for setting up the backend locally.

## Contributing 

For contributing, you first need to configure the remotes and then submit pull requests with your changes. Both of these steps are explained in detail in the links below and we recommend all contributors to go through them-<br />

1. [Configuring Remotes](https://github.com/anitab-org/mentorship-ios/blob/develop/Docs/Configuring%20Remotes.md)<br />
2. [Contributing and developing a feature](https://github.com/anitab-org/mentorship-ios/blob/develop/Docs/Contributing%20and%20Developing.md)<br />

Please read our [Contributing Guidelines](https://github.com/anitab-org/mentorship-ios/blob/develop/.github/contributing_guidelines.md), [Code of Conduct](https://github.com/anitab-org/mentorship-ios/blob/develop/.github/code_of_conduct.md), and [Reporting Guidelines](https://github.com/anitab-org/mentorship-ios/blob/develop/.github/reporting_guidelines.md).

## A note on the unit test suite of the app
The app features a comprehensive set of unit tests to verify that everything works as expected. A lot of these unit tests are for the networking code in the app and hence run the code for fetching of user auth token from the keychain. For this reason, before running the test suite, it is essential to login in the app.

## Contact

You can reach our community at [AnitaB.org Open Source Zulip](https://anitab-org.zulipchat.com/).

We use [#mentorship-system](https://anitab-org.zulipchat.com/#narrow/stream/222534-mentorship-system) stream on Zulip to discuss this project and interact with the community. If you're interested in contributing to this project, join us there!

## License

Mentorship System is licensed under the GNU General Public License v3.0. Learn more about it in the [LICENSE](LICENSE) file.
