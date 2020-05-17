import 'package:homeless/packages.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
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
              AutoSizeText(
                'App Version: ${ConstantDetails.version}',
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  letterSpacing: 1.2,
                  color: AppTheme.deactivatedText,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  child: AutoSizeText(
                    ConstantDetails.about,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                  leading: Icon(FontAwesomeIcons.google),
                  title: Text('Email'),
                  subtitle: Text(ConstantDetails.email),
                  onTap: ConstantDetails.launchMail,
                  onLongPress: () {
                    Clipboard.setData(
                        ClipboardData(text: ConstantDetails.email));
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Text Copied'),
                              content: Text(ConstantDetails.email),
                            ));
                  }),
              SizedBox(
                height: 10,
              ),
              ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                  subtitle: Text(ConstantDetails.phone),
                  onTap: ConstantDetails.launchCall,
                  onLongPress: () {
                    Clipboard.setData(
                        ClipboardData(text: ConstantDetails.phone));
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Text Copied'),
                              content: Text(ConstantDetails.phone),
                            ));
                  }),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, right: 15.0, left: 15.0, bottom: 50.0),
                child: Text("Made possible by",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: AppTheme.headline),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children: <Widget>[
                  Image.asset(
                    'assets/images/UNDPLogo2020.jpg',
                    width: 200,
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/TechHubLogo.png',
                    width: 200,
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/muhoko.png',
                    width: 200,
                    height: 150,
                  ),
                ],
              ),
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
