import 'package:homeless/packages.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final String about =
      'This app was co-designed with the Youth in Walvis Bay, aimed to sensitize the community towards the homeless living within the Walvis Bay area.';
  static const String email = 'design@sketchdm.co.za';
  static const String phone = '+27722326766';
  static const String version = '3.0.6-Beta';

  @override
  void initState() {
    super.initState();
  }

  _launchMail() async {
    const String url =
        'mailto:<$email>?subject=Homeless App Info Request&body=More Info Required on you App';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCall() async {
    const String url = 'tel:<$phone>';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.chipBackground,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        titleSpacing: 1.2,
        centerTitle: false,
        backgroundColor: AppTheme.chipBackground,
        title: Text(
          "About",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: 1.2,
            color: AppTheme.dark_grey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 600,
                height: 155,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: SvgPicture.asset("assets/images/Human-Standing-01.svg"),
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
    );
  }
}
