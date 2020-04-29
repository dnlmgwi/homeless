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

  _alert({context, result}) {
    showDialog(
        context: context, //builds a context of its own
        builder: (BuildContext context) {
          print('$result');
          return RichAlertDialog(
            //uses the custom alert dialog imported
            alertTitle: richTitle("Successful"),
            alertSubtitle: richSubtitle("$result"),
            alertType: RichAlertType.SUCCESS,
            actions: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Text("Confirm",
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      letterSpacing: 1,
                      color: AppTheme.nearlyWhite,
                    )),
                textColor: AppTheme.white,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/dash'),
                splashColor: AppTheme.nearlyWhite,
                color: AppTheme.nearlyBlack,
              ),
            ],
          );
        });
  }

  String qrCode;

  Future<String> _scan() async {
    //_scan() Receives QR code String and stores value in qrCodeScanRec
    String scanData = await FlutterBarcodeScanner.scanBarcode(
      "#32CD32",
      "Back",
      true,
      ScanMode.QR,
    );
    try {
      setState(() {
        //calling setstate to update UI with the link of the current user
        if (scanData.isNotEmpty) {
          Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) => RegisterationScreen(
                key: UniqueKey(),
                homeless_id: scanData,
              ),
            ),
          );
        } else {
          _alert(context: this.context);
          this.qrCode = 'No Data';
        }
      });
      // _launchURL(qrCode); // uses barcode parameter once its a valid link.

    } on PlatformException catch (e) {
      //Permission handling is done by the QR Scanner.
      if (e.code == qrCode) {
        setState(() {
          this.qrCode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qrCode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.qrCode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.qrCode = 'Unknown error: $e');
    }

    return scanData;
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
                  _scan();
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
                      'Direct User to the nearest Hope Facility',
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
                    _scan();
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
