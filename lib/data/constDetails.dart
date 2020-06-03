import 'package:homeless/packages.dart';

class ConstantDetails {
  static String about =
      'This app was co-designed with the Youth in Walvis Bay, aimed to sensitize the community towards the homeless living within the Walvis Bay area.';
  static final String summary =
      'Our Mobile App is still under development and we have come a long way, but the future looks bright...';
  static const String privacyUrl = 'http://www.google.com';
  static const String termsUrl = 'http://www.google.com';
  static const String eulaUrl = 'http://www.google.com';
  static const String whatsAppNumber = '+27722326766';
  static const String appStoreLink = 'https://ictechhub.com/inventions/';
  static const String email = 'design@sketchdm.co.za';
  static const String phone = '+27722326766';
  static const String version = '3.1.1-Beta';
  static const String bankDetails = 'Current Account \n'
      '00000123456 \n'
      'First National Bank \n'
      'Ausspannplatz Branch \n';

  static final String address = 'Erf 3033 \n'
      'Narraville Municipal Offices \n'
      'P.O Box 8011 \n'
      'Walvis Bay \n';

  static String consent({memberName}) {
    return 'I, $memberName hereby request Homeless status and authorize and consent to the completion of this form and its submission to MoHSS and to the disclosure to governmental entities of any additional information it may request to clarify information on this form.';
  }

  static String signUpConsent({memberName}) {
    return 'I, $memberName hereby request authorize and consent to the completion of this form and its submission to MoHSS and to the disclosure to governmental entities of any additional information it may request to clarify information on this form.';
  }

  static shareApp() {
    Share.share(appStoreLink);
  }

  //Opens whatapp to share feedback message.
  static launchWhatsApp({String feedbackText}) async {
    FlutterOpenWhatsapp.sendSingleMessage(
        whatsAppNumber, "Homeless App Feedback: $feedbackText");
  }

  static launchPrivacy() async {
    const String url = privacyUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchEULA() async {
    const String url = eulaUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchMail() async {
    const String url =
        'mailto:<$email>?subject=Homeless App Info Request&body=More Info Required on you App';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchTerms() async {
    const String url = termsUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchCall() async {
    const String url = 'tel:<$phone>';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

ConstantDetails constDetails = ConstantDetails();
