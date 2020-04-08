import 'package:homeless/api/client.dart';
import 'package:homeless/models/person.dart';
import 'package:homeless/packages.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rating_bar/rating_bar.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  String qrCode = '';

  AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 100),
    );
    animationController.forward();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    String id = '5e8a07743335344cbe000048';

    return GraphQLProvider(
        client: Config.client,
        child: Container(
          color: AppTheme.nearlyWhite,
          child: SafeArea(
            top: false,
            child: Scaffold(
              backgroundColor: AppTheme.chipBackground,
              resizeToAvoidBottomPadding: false,
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: AppTheme.dark_grey,
                child: Icon(
                  //This is the Icon for a QR Code
                  Icons.report_problem,
                  color: AppTheme.white,
                  size: 30,
                ),
              ),
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
                  "User Profile",
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
                  child: Container(
                    child: Query(
                        options: QueryOptions(
                            documentNode: gql(Queries.verifyUser()),
                            variables: {
                              '_id': '$id',
                            }),
                        builder: (QueryResult result,
                            {VoidCallback refetch, FetchMore fetchMore}) {
                          if (result.loading) {
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 9,
                                backgroundColor: AppTheme.dark_grey,
                              ),
                            );
                          }
                          if (result.hasException) {
                            print(result.exception.toString());
                          }

                          if (!result.hasException) {
                            final List<dynamic> repositories = result
                                .data['MemberCollection'] as List<dynamic>;

                            for (var person in repositories) {
                              return Container(
                                  margin: EdgeInsets.all(20.0),
                                  padding: EdgeInsets.all(30.0),
                                  decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: AppTheme.grey.withOpacity(0.2),
//                                         offset: Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: new BoxDecoration(
                                          color: AppTheme.grey,
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(
                                                "http://www.sketchdm.co.za${person['picture']['path']}"),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                        "${person['name']}, ${person['age']}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              AppTheme.fontName,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 25,
                                                          letterSpacing: 1,
                                                          color: AppTheme
                                                              .darkerText,
                                                        )), //Name & Age
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Experience".toUpperCase(),
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontName,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                      letterSpacing: 1,
                                                      color: AppTheme
                                                          .deactivatedText,
                                                    )),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.all(5),
                                                      child: Text(
                                                          "${person['rating']}",
                                                          style: TextStyle(
                                                            fontFamily: AppTheme
                                                                .fontName,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 25,
                                                            letterSpacing: 1,
                                                            color: AppTheme
                                                                .darkerText,
                                                          )),
                                                    ),
                                                    RatingBar.readOnly(
                                                      maxRating: 5,
                                                      initialRating: double.parse(
                                                          "${person['rating']}"),
                                                      filledIcon: Icons.star,
                                                      emptyIcon:
                                                          Icons.star_border,
                                                      halfFilledIcon:
                                                          Icons.star_half,
                                                      isHalfAllowed: true,
                                                      filledColor:
                                                          AppTheme.darkText,
                                                      emptyColor: AppTheme
                                                          .deactivatedText,
                                                      halfFilledColor:
                                                          AppTheme.darkText,
                                                      size: 35,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                        "About Me"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              AppTheme.fontName,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15,
                                                          letterSpacing: 1,
                                                          color: AppTheme
                                                              .deactivatedText,
                                                        )),
                                                    Spacer(),
                                                    Text(
                                                        "Joined: ${DateTime.parse(person['_created'])}"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              AppTheme.fontName,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15,
                                                          letterSpacing: 1,
                                                          color: AppTheme
                                                              .deactivatedText,
                                                        )), // Date Joined
                                                  ],
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    "${person['about']}",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontName,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 19,
                                                      letterSpacing: 0.5,
                                                      color:
                                                          AppTheme.nearlyBlack,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "${person['location']["address"]}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                    letterSpacing: 0.5,
                                                    color: AppTheme
                                                        .deactivatedText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Points".toUpperCase(),
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontName,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                      letterSpacing: 1,
                                                      color: AppTheme
                                                          .deactivatedText,
                                                    )),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.all(2),
                                                      child: Text("HL",
                                                          style: TextStyle(
                                                            fontFamily: AppTheme
                                                                .fontName,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 25,
                                                            letterSpacing: 1,
                                                            color: AppTheme
                                                                .darkerText,
                                                          )),
                                                    ),
                                                    Text("${person['points']}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              AppTheme.fontName,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 50,
                                                          letterSpacing: 1,
                                                          color: AppTheme
                                                              .darkerText,
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ));
                            }

                            if (repositories.isEmpty) {
                              print('User Doesnt Exist!');
                            }
                          }

                          return Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Load More"),
                                  ],
                                ),
                                onPressed: () {
                                  refetch;
                                },
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

//Widget _handleCurrentScreen(bool isLoading) {
//  if (isLoading) {
//    return
//  } else {
//    return ListView.separated(
//      separatorBuilder: (context, int) {
//        return Divider();
//      },
//      itemBuilder: (context, int) {
//        bool active = rewardsList.settingsRewards[int].active == 'true';
//
//        return ListTile(
//          enabled: active,
//          onTap: () {},
//          leading: active
//              ? Icon(
//            Icons.check_circle,
//            color: Colors.green,
//          )
//              : Icon(
//            Icons.cancel,
//            color: Colors.red,
//          ),
//          trailing: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Text('${rewardsList.settingsRewards[int].fields.punchCost}',
//                  style: TextStyle(
//                    fontFamily: AppTheme.fontName,
//                    fontWeight: FontWeight.w700,
//                    fontSize: 25,
//                    color: AppTheme.dark_grey,
//                  )),
//              Text('HL Points',
//                  style: TextStyle(
//                    fontFamily: AppTheme.fontName,
//                    fontWeight: FontWeight.normal,
//                    fontSize: 10,
//                    letterSpacing: 1.2,
//                    color: AppTheme.lightText,
//                  )),
//            ],
//          ),
//          subtitle:
//          Text('${rewardsList.settingsRewards[int].fields.description}',
//              style: TextStyle(
//                fontFamily: AppTheme.fontName,
//                fontWeight: FontWeight.normal,
//                fontSize: 12,
//                letterSpacing: 1.2,
//                color: AppTheme.deactivatedText,
//              )),
//          title: Text("${rewardsList.settingsRewards[int].fields.rewardName}",
//              style: TextStyle(
//                fontFamily: AppTheme.fontName,
//                fontWeight: FontWeight.w700,
//                fontSize: 20,
//                letterSpacing: 1,
//                color: AppTheme.darkerText,
//              )),
//        );
//      },
//      itemCount: (rewardsList == null ||
//          rewardsList.settingsRewards == null ||
//          rewardsList.settingsRewards.length == 0)
//          ? 0
//          : rewardsList.settingsRewards.length,
//    );
//  }

//ListTile(
//title: Text(
//'${person['name'] + person['surname']}'),
//trailing: Text('${person['points']}'),
//)
//}
