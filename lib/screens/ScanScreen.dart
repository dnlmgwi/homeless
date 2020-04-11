import 'package:homeless/packages.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:soundpool/soundpool.dart';

class ScanScreen extends StatefulWidget {
  final String id;

  ScanScreen({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  // Choose from any of these available methods

  static Soundpool pool = Soundpool(streamType: StreamType.notification);

  Future play() async {
    int soundId = await rootBundle
        .load("assets/sounds/insight.m4r")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);

    return streamId;
  }

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
                child: AutoSizeText('Try Again'),
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
    return GraphQLProvider(
        client: Config.client,
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
                actions: <Widget>[],
                title: AutoSizeText(
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
                padding: EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Query(
                        options: QueryOptions(
                            documentNode: gql(Queries.verifyUser()),
                            variables: {
                              '_id': '${widget.id}',
                            }),
                        builder: (QueryResult result,
                            {VoidCallback refetch, FetchMore fetchMore}) {
                          if (result.loading) {
                            return SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  LoadingProfile(),
                                ],
                              ),
                            );
                          }
                          if (result.hasException) {
                            print(result.exception.toString());
                            _alert(
                                context: this.context,
                                error: result.exception.toString());
                          }

                          if (!result.hasException) {
                            Vibrate.vibrate();
                            play();
                            final List<dynamic> repositories = result
                                .data['MemberCollection'] as List<dynamic>;

                            for (var person in repositories) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(20.0),
                                      padding: EdgeInsets.all(30.0),
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.grey
                                                  .withOpacity(0.2),
//                                         offset: Offset(1.1, 1.1),
                                              blurRadius: 10.0),
                                        ],
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 180.0,
                                            height: 180.0,
                                            decoration: BoxDecoration(
                                              color: AppTheme.grey,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "http://www.sketchdm.co.za${person['picture']['path']}",
                                                ),
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
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        AutoSizeText(
                                                            "${person['name']} ${person['surname']}, ${person['age']}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  AppTheme
                                                                      .fontName,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 25,
                                                              letterSpacing: 1,
                                                              color: AppTheme
                                                                  .darkerText,
                                                            )),
                                                        //Name & Age
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1,
                                                    ),
                                                    AutoSizeText(
                                                        "${person['gender'][0]}"
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
                                                    Divider(),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        AutoSizeText(
                                                            "About Me"
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  AppTheme
                                                                      .fontName,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 15,
                                                              letterSpacing: 1,
                                                              color: AppTheme
                                                                  .deactivatedText,
                                                            )),
                                                        Spacer(),
                                                        AutoSizeText(
                                                            "Joined: ${person['joined']}"
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  AppTheme
                                                                      .fontName,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 15,
                                                              letterSpacing: 1,
                                                              color: AppTheme
                                                                  .deactivatedText,
                                                            )), // Date Joined
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: AutoSizeText(
                                                        "${person['about']}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              AppTheme.fontName,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 19,
                                                          letterSpacing: 0.5,
                                                          color: AppTheme
                                                              .nearlyBlack,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    AutoSizeText(
                                                      "${person['location']["address"]}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppTheme.fontName,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                    AutoSizeText(
                                                        "Points".toUpperCase(),
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
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(2),
                                                          child: AutoSizeText(
                                                              "HL",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    AppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 25,
                                                                letterSpacing:
                                                                    1,
                                                                color: AppTheme
                                                                    .darkerText,
                                                              )),
                                                        ),
                                                        AutoSizeText(
                                                          "${person['points']}",
                                                          style: TextStyle(
                                                            fontFamily: AppTheme
                                                                .fontName,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 50,
                                                            letterSpacing: 1,
                                                            color: AppTheme
                                                                .darkerText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (repositories.isEmpty) {
                              print('User Doesnt Exist!');
                              return Center(
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  padding: EdgeInsets.all(20.0),
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
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        runSpacing: 20,
                                        spacing: 20,
                                        children: <Widget>[
                                          Icon(
                                            Icons.report_problem,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: AutoSizeText(
                                                "This Is Not A Homeless Beneficiary."
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 1,
                                                  color:
                                                      AppTheme.deactivatedText,
                                                )),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        color: AppTheme.white,
                                        child: MaterialButton(
                                          onPressed: () {},
                                          elevation: 8,
                                          color: AppTheme.dark_grey,
                                          textColor: AppTheme.notWhite,
                                          child: AutoSizeText(
                                            "Rescan",
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: MaterialButton(
                                          onPressed: () {},
                                          elevation: 8,
                                          textColor: Colors.red,
                                          color: AppTheme.notWhite,
                                          child: AutoSizeText(
                                            "Report",
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }

                          return Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(20.0),
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
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: 20,
                                  spacing: 20,
                                  children: <Widget>[
                                    Icon(
                                      Icons.report_problem,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: AutoSizeText(
                                          "This Is Not A Homeless Beneficiary."
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                            color: AppTheme.deactivatedText,
                                          )),
                                    )
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: AppTheme.white,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    elevation: 8,
                                    color: AppTheme.dark_grey,
                                    textColor: AppTheme.notWhite,
                                    child: AutoSizeText(
                                      "Rescan",
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    elevation: 8,
                                    textColor: Colors.red,
                                    color: AppTheme.notWhite,
                                    child: AutoSizeText(
                                      "Report",
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
