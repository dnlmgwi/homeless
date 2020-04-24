import 'package:homeless/packages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homeless/data/graphqlQueries.dart';

class WhereAboutScreen extends StatefulWidget {
  final String id;
  final double lat, lng;
  WhereAboutScreen({Key key, this.id, this.lat, this.lng}) : super(key: key);
  @override
  _WhereAboutScreenState createState() => _WhereAboutScreenState();
}

class _WhereAboutScreenState extends State<WhereAboutScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  var now = DateTime.now();

  Position _currentPosition;
  String _currentAddress;

  var home;

  FocusNode myFocusNode;

  _getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.country}, ${place.locality}, ${place.postalCode}, ${place.locality}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.name}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  initState() {
    _getCurrentLocation();
    super.initState();

    myFocusNode = FocusNode();
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
                onPressed: () => Navigator.popAndPushNamed(context, '/dash'),
                splashColor: AppTheme.nearlyWhite,
                color: AppTheme.nearlyBlack,
              ),
            ],
          );
        });
  }

  _alertError({context, result}) {
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
                onPressed: () => Navigator.popAndPushNamed(context, '/dash'),
                splashColor: AppTheme.nearlyWhite,
                color: AppTheme.nearlyBlack,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: UserRepository.client,
      child: Scaffold(
        backgroundColor: AppTheme.chipBackground,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          titleSpacing: 1.2,
          centerTitle: false,
          backgroundColor: AppTheme.chipBackground,
          title: Text(
            "Where Abouts",
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

                      distanceFromHome() async {
                        double distanceInMeters = await Geolocator()
                            .distanceBetween(
                                _currentPosition == null
                                    ? widget.lat
                                    : _currentPosition.latitude,
                                _currentPosition == null
                                    ? widget.lng
                                    : _currentPosition.longitude,
                                widget.lat,
                                widget.lng);

                        var inKm = distanceInMeters / 1000;

                        return inKm.toStringAsFixed(3);
                      }

                      for (var person in repositories) {
                        distanceFromHome().then((onValue) => home = onValue);
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                        color:
                                                            AppTheme.darkerText,
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
                                                      "${person['gender']}"
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
                                                  "Distance from usual location"
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    letterSpacing: 1,
                                                    color: AppTheme
                                                        .deactivatedText,
                                                  )),
                                              AutoSizeText(
                                                  "${home.toString()} km",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 35,
                                                    letterSpacing: 1,
                                                    color: AppTheme.darkerText,
                                                  )),
                                              Divider(),
                                              SizedBox(
                                                height: 15,
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
                                                  BorderRadius.circular(22.0)),
                                          color: AppTheme.nearlyWhite,
                                          onPressed: () {
                                            // _launchReport();
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
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: MaterialButton(
                                    onPressed: () {
                                      // _launchReport();
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
                                // _launchReport();
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
    );
  }
}
