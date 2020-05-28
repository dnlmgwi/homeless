import 'package:homeless/packages.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({
    Key key,
  }) : super(key: key);
  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    // Platform messages may fail, so we use a try/catch PlatformException.

    String scanData = await FlutterBarcodeScanner.scanBarcode(
        "#32CD32", "Back", true, ScanMode.QR);

    if (scanData.isNotEmpty) {
      Navigator.pushReplacementNamed(context, RegistrationScreen.routeName,
          arguments: ScreenArgsRegistration(homeless_id: scanData ??= 'none'));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => RegistrationScreen(
      //       homeless_id: scanData,
      //     ),
      //   ),
      // );
      print("Scanned $scanData");
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
          "How To Register",
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
              SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/images/useApp-01.svg',
                height: 200,
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: AutoSizeText(
                  'Follow These simple steps to register a member',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: AutoSizeText(
                  'Step 1:',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Wrap(
                  spacing: 10,
                  children: <Widget>[
                    AutoSizeText(
                      'Scan The Card',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  scanQR();
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: AutoSizeText(
                  'Step 2:',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Wrap(
                  spacing: 10,
                  children: <Widget>[
                    AutoSizeText(
                      'Read out the benefits of being part of this app',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: AutoSizeText(
                  'Step 3:',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Wrap(
                  spacing: 10,
                  children: <Widget>[
                    AutoSizeText(
                      'Direct user to the nearest Hope Facility',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                  ),
                  child: Text(
                    "Start".toUpperCase(),
                  ),
                  textColor: AppTheme.white,
                  onPressed: () {
                    scanQR();
                  },
                  splashColor: AppTheme.nearlyWhite,
                  color: AppTheme.nearlyBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
