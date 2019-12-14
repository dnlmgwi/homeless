import 'package:homeless/packages.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final String about =
      'This app was co-designed with the Youth in Walvis Bay, was aimed to sensitize the community towards the homeless living with in the Walvis Bay area.';
  static final String email = 'info@homeless.com';
  final String phone = '+264850000000';
  final String version = '2.0.3-Beta';

  @override
  void initState() {
    super.initState();
  }

  _launchMail() async {
    const String url =
        'mailto:<info@homeless.com>?subject=Homeless App Info&body=More Info Required on you App';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCall() async {
    const String url = 'tel:<+264850000000>';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.chipBackground,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            titleSpacing: 1.2,
            centerTitle: false,
            backgroundColor: AppTheme.dark_grey,
            title: Text(
              "About",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w700,
                fontSize: 22,
                letterSpacing: 1.2,
                color: AppTheme.nearlyWhite,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: 500,
                  height: 155,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 16,
                      right: 16),
                  child: Image.asset("assets/images/helpImage.png"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'How can we help you?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'App Version: $version',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    letterSpacing: 1.2,
                    color: AppTheme.deactivatedText,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "$about",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                    leading: Icon(FontAwesomeIcons.google),
                    title: Text('Email'),
                    subtitle: Text('$email'),
                    onTap: _launchMail,
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: email));
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('Text Copied'),
                                content: Text('$email'),
                              ));
                    }),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone'),
                    subtitle: Text('$phone'),
                    onTap: _launchCall,
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: phone));
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('Text Copied'),
                                content: Text('$phone'),
                              ));
                    }),
//                Expanded(
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Center(
//                      child: Container(
//                        width: 140,
//                        height: 40,
//                        decoration: BoxDecoration(
//                          color: AppTheme.dark_grey,
//                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
//                          boxShadow: <BoxShadow>[
//                            BoxShadow(
//                                color: Colors.grey.withOpacity(0.6),
//                                offset: Offset(4, 4),
//                                blurRadius: 8.0),
//                          ],
//                        ),
//                        child: new Material(
//                          color: Colors.transparent,
//                          child: InkWell(
//                            onTap: () {},
//                            child: Center(
//                              child: Padding(
//                                padding: const EdgeInsets.all(4.0),
//                                child: Text(
//                                  'Chat with Us',
//                                  style: TextStyle(
//                                    fontWeight: FontWeight.w500,
//                                    color: Colors.white,
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
