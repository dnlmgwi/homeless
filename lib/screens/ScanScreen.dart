
import 'package:homeless/api/client.dart';
import 'package:homeless/data/memberCheck.dart';
import 'package:homeless/models/person.dart';
import 'package:homeless/packages.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<Person> listPerson = List<Person>();

  Config config = Config();

  void checkMember({String id}) async {
    QueryMember queryMember = QueryMember();
    GraphQLClient _client = config.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(queryMember.getUser(id: id)),
        variables: <String, dynamic>{
          '_id': id,
        },
      ),
    );

    if (!result.hasException) {
      // it can be either Map or List
      // final List<LazyCacheMap> todos =
      //     (result.data['member'] as List<dynamic>).cast<LazyCacheMap>();
      Map repositories = result.data['data'];
      print('Result: $repositories');
    }

    if (result.hasException) {
      print(result.exception.toString());
    }
    print(result.data.toString());
  }

  Future _scan() async {
    //_scan() Receives QR code String and stores value in qrCodeScanRec
    try {
      String scanData = await FlutterBarcodeScanner.scanBarcode(
        "#32CD32",
        "Back",
        true,
        ScanMode.QR,
      );
      setState(() {
        //calling setstate to update UI with the link of the current user
        if (scanData.isNotEmpty) {
          this.qrCode = scanData;
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkMember(id: "5e8a07743335344cbe000048");
    // _scan();
  }

  //This Method Launches the alert Dialogue for an API Error
  _alert({context, error}) {
    showDialog(
        context: context, //builds a context of its own
        builder: (BuildContext context) {
          return RichAlertDialog(
            //uses the custom alert dialog imported
            alertTitle: richTitle("Network Error"),
            alertSubtitle: richSubtitle(
                "This feature requires internet access.\n Please turn on mobile data or Wifi"),
            alertType: RichAlertType.ERROR,
            actions: <Widget>[
              RaisedButton(
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/dash');
                }, //closes the dialogue
              )
            ],
          );
        });
  }

  static String id = "";
  String qrCode;
  String name = 'Loading';
  String surname = 'Loading';
  String points = 'Loading';

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: CacheProvider(
          child: Container(
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
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      //This is the Icon for a QR Code
                      Icons.center_focus_weak,
                      color: AppTheme.white,
                      size: 32,
                    ),
                    onPressed: () {
                      setState(() {
                        _scan();
                      });
                    }),
              ],
              title: Text(
                "Verify User",
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
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                  child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text('$name + $surname'),
                    trailing: Text('$points'),
                  ),
                ],
              )),
            ),
          ),
        ),
      )),
    );
  }
}
