import 'package:flutter/material.dart';
import 'package:homeless/packages.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:homeless/screens/transactionHistoryScreen.dart';
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

  _launchReport({
    String id,
    String name,
    String surname,
  }) async {
    FlutterOpenWhatsapp.sendSingleMessage(
        "+27722326766", "App is failing to scan");
  }

  Future play() async {
    int soundId = await rootBundle
        .load("assets/sounds/insight.m4r")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
    Vibrate.vibrate();

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

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.client,
      child: Container(
        color: AppTheme.nearlyWhite,
        child: Scaffold(
          backgroundColor: AppTheme.chipBackground,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            titleSpacing: 1.2,
            centerTitle: false,
            backgroundColor: AppTheme.chipBackground,
            actions: <Widget>[],
            title: AutoSizeText(
              "User Profile",
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
                      }

                      if (!result.hasException) {
                        // play();
                        final List<dynamic> repositories =
                            result.data['MemberCollection'] as List<dynamic>;

                        for (var person in repositories) {
                          return SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(20.0),
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
                                    children: <Widget>[
                                      Container(
                                        width: 120.0,
                                        height: 120.0,
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
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                                    AutoSizeText(
                                                        "${person['name']} ${person['surname']}, ${person['age']}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              AppTheme.fontName,
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                Row(
                                                  children: <Widget>[
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
                                                    Spacer(),
                                                    AutoSizeText(
                                                        "Joined: ${person['joinedDate']}"
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
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                AutoSizeText(
                                                  "${person['location']["address"]}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    letterSpacing: 0.5,
                                                    color: AppTheme
                                                        .deactivatedText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Divider(),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    InkWell(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        margin: EdgeInsets.all(
                                                            10.0),
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppTheme
                                                              .darkerText,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8.0)),
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                                color: AppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
//                                         offset: Offset(1.1, 1.1),
                                                                blurRadius:
                                                                    10.0),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .exchangeAlt,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text('Transact',
                                                                style: TextStyle(
                                                                    color: AppTheme
                                                                        .nearlyWhite))
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          TransactScreen(
                                                                            image:
                                                                                person['picture']['path'],
                                                                            name:
                                                                                person['name'],
                                                                            surname:
                                                                                person['surname'],
                                                                            id: person['_id'],
                                                                          ))),
                                                    ),
                                                    InkWell(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        margin:
                                                            EdgeInsets.all(5.0),
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppTheme
                                                              .nearlyWhite,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8.0)),
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                                color: AppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
//                                         offset: Offset(1.1, 1.1),
                                                                blurRadius:
                                                                    10.0),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .briefcaseMedical,
                                                                  color: AppTheme
                                                                      .darkerText),
                                                            ),
                                                            Text(
                                                              'Medicals',
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .darkerText),
                                                            )
                                                          ],
                                                        ),
                                                      ),
//                                                      onTap: () => Navigator.push(
//                                                          context,
//                                                          MaterialPageRoute(
//                                                              builder: (context) =>
//                                                                  TransactScreen())),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    InkWell(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        margin: EdgeInsets.all(
                                                            10.0),
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppTheme
                                                              .darkerText,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8.0)),
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                                color: AppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
//                                         offset: Offset(1.1, 1.1),
                                                                blurRadius:
                                                                    10.0),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .fileInvoice,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                                'Transaction History',
                                                                style: TextStyle(
                                                                    color: AppTheme
                                                                        .nearlyWhite))
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          TransactionHistoryScreen(
                                                                            id: person['_id'],
                                                                          ))),
                                                    ),
//                                                     InkWell(
//                                                       child: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width /
//                                                             3,
//                                                         margin:
//                                                             EdgeInsets.all(5.0),
//                                                         padding: EdgeInsets.all(
//                                                             10.0),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: AppTheme
//                                                               .nearlyWhite,
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           8.0)),
//                                                           boxShadow: <
//                                                               BoxShadow>[
//                                                             BoxShadow(
//                                                                 color: AppTheme
//                                                                     .grey
//                                                                     .withOpacity(
//                                                                         0.2),
// //                                         offset: Offset(1.1, 1.1),
//                                                                 blurRadius:
//                                                                     10.0),
//                                                           ],
//                                                         ),
//                                                         child: Column(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           children: <Widget>[
//                                                             Padding(
//                                                               padding:
//                                                                   EdgeInsets
//                                                                       .all(5.0),
//                                                               child: FaIcon(
//                                                                   FontAwesomeIcons
//                                                                       .eye,
//                                                                   color: AppTheme
//                                                                       .darkerText),
//                                                             ),
//                                                             Text(
//                                                               'Last Seen',
//                                                               style: TextStyle(
//                                                                   color: AppTheme
//                                                                       .darkerText),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
// //                                                      onTap: () => Navigator.push(
// //                                                          context,
// //                                                          MaterialPageRoute(
// //                                                              builder: (context) =>
// //                                                                  TransactScreen())),
//                                                     ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          RaisedButton.icon(
                                            clipBehavior: Clip.antiAlias,
                                            icon: FaIcon(
                                                FontAwesomeIcons
                                                    .exclamationTriangle,
                                                color: Colors.red),
                                            label: Text(
                                              'Report User',
                                              style: TextStyle(
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        22.0)),
                                            color: AppTheme.nearlyWhite,
                                            onPressed: () {
                                              _launchReport();
                                              Navigator.popAndPushNamed(
                                                  context, '/dash');
                                            },
                                          ),
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
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    color: AppTheme.white,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.popAndPushNamed(
                                            context, '/dash');
                                      },
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
                                        MediaQuery.of(context).size.width / 2,
                                    child: MaterialButton(
                                      onPressed: () {
                                        _launchReport();
                                        Navigator.popAndPushNamed(
                                            context, '/dash');
                                      },
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
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
                                onPressed: () {
                                  Navigator.popAndPushNamed(context, '/dash');
                                  _launchReport();
                                },
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
    );
  }
}
