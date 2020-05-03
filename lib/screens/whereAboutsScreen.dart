import 'package:homeless/packages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:latlong/latlong.dart';

class WhereAboutScreen extends StatefulWidget {
  final String homeless_id;
  final double lat, lng;
  WhereAboutScreen({Key key, this.homeless_id, this.lat, this.lng})
      : super(key: key);
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
            child: Query(
                options: QueryOptions(
                  documentNode:
                      gql(Queries.getMarkers(homeless_id: widget.homeless_id)),
                ),
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

                    var memberCollection = result.data;
                    var transactionCollection = result.data;

                    for (var person in memberCollection['MemberCollection']) {
                      distanceFromHome().then((onValue) => home = onValue);
                      List<Marker> listMarkers = [
                        Marker(
                            width: 45.0,
                            height: 45.0,
                            point: LatLng(
                              person['location']['lat'],
                              person['location']['lng'],
                            ),
                            builder: (context) => Container(
                                  child: IconButton(
                                    icon: FaIcon(FontAwesomeIcons.userAlt),
                                    color: AppTheme.dark_grey,
                                    iconSize: 25.0,
                                    onPressed: () {
                                      print('Marker tapped');
                                    },
                                  ),
                                )),
                        Marker(
                            width: 45.0,
                            height: 45.0,
                            point: LatLng(
                              _currentPosition == null
                                  ? widget.lat
                                  : _currentPosition.latitude,
                              _currentPosition == null
                                  ? widget.lng
                                  : _currentPosition.longitude,
                            ),
                            builder: (context) => Container(
                                  child: IconButton(
                                    icon: FaIcon(FontAwesomeIcons.streetView),
                                    color: AppTheme.darkText,
                                    iconSize: 25.0,
                                    onPressed: () {
                                      print('Marker tapped');
                                    },
                                  ),
                                )),
                      ];

                      for (var mark
                          in transactionCollection['TransactionsCollection']) {
                        listMarkers.add(
                          Marker(
                            width: 45.0,
                            height: 45.0,
                            point: LatLng(
                              mark['location']['lat'],
                              mark['location']['lng'],
                            ),
                            builder: (context) => Container(
                              child: IconButton(
                                icon: FaIcon(FontAwesomeIcons.thumbtack),
                                color: AppTheme.darkText,
                                iconSize: 25.0,
                                onPressed: () {
                                  print(TimeAgo.getTimeAgo(
                                      int.parse(mark['scanTime'])));
                                },
                              ),
                            ),
                          ),
                        );
                      }

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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
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
                                                "${person['name']} ${person['surname']}",
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 25,
                                                  letterSpacing: 1,
                                                  color: AppTheme.darkerText,
                                                )),

                                            //Name & Age
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          child: AutoSizeText(
                                            "${person['location']['address']}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              color: AppTheme.deactivatedText,
                                            ),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        AutoSizeText(
                                            "Distance from usual location"
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              letterSpacing: 1,
                                              color: AppTheme.deactivatedText,
                                            )),
                                        Row(
                                          children: <Widget>[
                                            FaIcon(
                                              FontAwesomeIcons.streetView,
                                              color: AppTheme.deactivatedText,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            AutoSizeText(
                                                "${home.toString()} km",
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 35,
                                                  letterSpacing: 1,
                                                  color: AppTheme.darkerText,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AutoSizeText(
                                            "Most Recent Scan".toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              letterSpacing: 1,
                                              color: AppTheme.deactivatedText,
                                            )),
                                        Row(
                                          children: <Widget>[
                                            FaIcon(FontAwesomeIcons.clock,
                                                color:
                                                    AppTheme.deactivatedText),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            AutoSizeText(
                                                "${TimeAgo.getTimeAgo(int.parse(transactionCollection['TransactionsCollection'][0]['scanTime']))}",
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 35,
                                                  letterSpacing: 1,
                                                  color: AppTheme.darkerText,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  RaisedButton.icon(
                                    clipBehavior: Clip.antiAlias,
                                    icon: FaIcon(
                                        FontAwesomeIcons.exclamationTriangle,
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
                                      Navigator.pop(context, '/dash');
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 500,
                              child: FlutterMap(
                                options: MapOptions(
                                  center: LatLng(
                                    _currentPosition == null
                                        ? widget.lat
                                        : _currentPosition.latitude,
                                    _currentPosition == null
                                        ? widget.lng
                                        : _currentPosition.longitude,
                                  ),
                                  zoom: 13.0,
                                ),
                                layers: [
                                  TileLayerOptions(
                                    urlTemplate:
                                        "https://api.mapbox.com/styles/v1/sketchdm/ck9qg25gx052v1inok1euy0i6/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                                    additionalOptions: {
                                      'accessToken': '$mapToken',
                                      'id': 'mapbox.mapbox-streets-v7',
                                    },
                                  ),
                                  MarkerLayerOptions(
                                    markers: listMarkers,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }

                    if (memberCollection.isEmpty) {
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
                                    Navigator.popAndPushNamed(context, '/dash');
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
                                    Navigator.popAndPushNamed(context, '/dash');
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
                              child: AutoSizeText("Unauthorised".toUpperCase(),
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
    );
  }
}
