import 'package:homeless/packages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:intl/intl.dart';

class TransactScreen extends StatefulWidget {
  final String image, name, surname, id;
  TransactScreen({
    Key key,
    this.image,
    this.name,
    this.surname,
    this.id,
  }) : super(key: key);
  @override
  _TransactScreenState createState() => _TransactScreenState();
}

class _TransactScreenState extends State<TransactScreen> {
  //TODO: Benefits
  static bool healthCare = false;
  void _healthCareChanged(bool value) => setState(() => healthCare = value);
  static bool food = false;
  void _foodChanged(bool value) => setState(() => food = value);
  static bool accomodation = false;
  void _accomodationChanged(bool value) => setState(() => accomodation = value);

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  var now = DateTime.now();

  String member_id = '';

  List<String> _organisations = ['Fight Coronavirus'];
  String _selectedOrganisation;

  Position _currentPosition;
  String _currentAddress;

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
            "${place.locality}, ${place.postalCode}, ${place.country}, ${place.subLocality}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  initState() {
    _getCurrentLocation();
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
      client: Config.client,
      child: Scaffold(
        backgroundColor: AppTheme.chipBackground,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          titleSpacing: 1.2,
          centerTitle: false,
          backgroundColor: AppTheme.chipBackground,
          title: Text(
            "Transaction",
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
        body: Mutation(
            options: MutationOptions(
                documentNode: gql(Queries.addTransaction(
                    accommodation: accomodation,
                    food: food,
                    healthcare: healthCare,
                    member_id: _selectedOrganisation,
                    address: _currentAddress,
                    scanDate: DateFormat("yyyy-MM-dd").format(now),
                    scanTime: DateFormat("HH:mm:ss").format(now),
                    //TODO: Find Default Lat, Long
                    lat: _currentPosition == null
                        ? -0
                        : _currentPosition.latitude,
                    lng: _currentPosition == null
                        ? 0
                        : _currentPosition.longitude,
                    homeless_id: widget
                        .id)), // this is the mutation string you just created
                // you can update the cache based on results
                update: (Cache cache, QueryResult result) {
                  return cache;
                },
                // or do something with the result.data on completion
                onCompleted: (dynamic resultData) {
                  print(resultData);
                  _alert(
                      context: context,
                      result:
                          'Transaction Ref: ${resultData['saveCollectionItem']['data']['_id']}');
                },
                onError: (error) {
                  print(error);
                  _alertError(
                    context: context,
                    result: '$error',
                  );
                }),
            builder: (
              RunMutation runMutation,
              QueryResult result,
            ) {
              return ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // ListTile(
                          //     title: Text(
                          //       'Use The Slider to set the Amount',
                          //       style: TextStyle(
                          //         fontFamily: AppTheme.fontName,
                          //         fontWeight: FontWeight.normal,
                          //         fontSize: 14.5,
                          //         letterSpacing: 0.5,
                          //         color: AppTheme.grey,
                          //       ),
                          //     ),
                          //     leading: Icon(Icons.info_outline)),
                          Container(
                            margin: EdgeInsets.all(10.0),
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
                                        "http://www.sketchdm.co.za${widget.image}",
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
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
                                                  "${widget.name} ${widget.surname}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 25,
                                                    letterSpacing: 1,
                                                    color: AppTheme.darkerText,
                                                  )),
                                              //Name & Age
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Divider(),
                                          AutoSizeText("Projects".toUpperCase(),
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                letterSpacing: 1,
                                                color: AppTheme.deactivatedText,
                                              )),
                                          DropdownButton(
                                            hint: Text(
                                                'Please choose a location'), // Not necessary for Option 1
                                            value: _selectedOrganisation,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedOrganisation =
                                                    newValue;
                                              });
                                            },
                                            items:
                                                _organisations.map((location) {
                                              return DropdownMenuItem(
                                                child: Text(location),
                                                value: location,
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          AutoSizeText(
                                              "Claim benefits".toUpperCase(),
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                letterSpacing: 1,
                                                color: AppTheme.deactivatedText,
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              CheckboxListTile(
                                                value: healthCare,
                                                onChanged: _healthCareChanged,
                                                activeColor: AppTheme.darkText,
                                                title: Text(
                                                  "Health Care",
                                                  style: TextStyle(
                                                    color: AppTheme.darkText,
                                                    fontFamily: "2",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                              CheckboxListTile(
                                                value: food,
                                                onChanged: _foodChanged,
                                                activeColor: AppTheme.darkText,
                                                title: Text(
                                                  "Food",
                                                  style: TextStyle(
                                                    color: AppTheme.darkText,
                                                    fontFamily: "2",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                              CheckboxListTile(
                                                value: accomodation,
                                                onChanged: _accomodationChanged,
                                                activeColor: AppTheme.darkText,
                                                title: Text(
                                                  "Accomodation",
                                                  style: TextStyle(
                                                    color: AppTheme.darkText,
                                                    fontFamily: "2",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                              // AutoSizeText(
                                              //     "Location".toUpperCase(),
                                              //     style: TextStyle(
                                              //       fontFamily:
                                              //           AppTheme.fontName,
                                              //       fontWeight: FontWeight.w700,
                                              //       fontSize: 15,
                                              //       letterSpacing: 1,
                                              //       color: AppTheme
                                              //           .deactivatedText,
                                              //     )),
                                              //    AutoSizeText(
                                              //       currentLocation == null
                                              //           ? "Loading..."
                                              //           : "Lat: ${currentLocation.latitude} Long: ${currentLocation.longitude}\n Date: ${DateFormat("yyyy-MM-dd").format(now)} \n Time: ${DateFormat("H:m:s").format(now)}",
                                              //       style: TextStyle(
                                              //         fontFamily:
                                              //             AppTheme.fontName,
                                              //         fontWeight: FontWeight.w700,
                                              //         fontSize: 15,
                                              //         letterSpacing: 1,
                                              //         color: AppTheme
                                              //             .deactivatedText,
                                              //       )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          food &&
                                      accomodation &&
                                      healthCare &&
                                      _selectedOrganisation == null ||
                                  food ||
                                  accomodation ||
                                  healthCare == true
                              ? Container(
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
                                    children: <Widget>[
                                      ListTile(
                                        title: Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 19.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              AutoSizeText(
                                                  "Confirm Transaction: "
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
                                            ],
                                          ),
                                        ),
                                        subtitle: FlatButton.icon(
                                          padding: EdgeInsets.all(15.0),
                                          icon: Icon(Icons.payment,
                                              color: AppTheme.white),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          label: Text("Give Help",
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                letterSpacing: 1,
                                                color: AppTheme.nearlyWhite,
                                              )),
                                          textColor: AppTheme.white,
                                          onPressed: () => runMutation({}),
                                          splashColor: AppTheme.nearlyWhite,
                                          color: AppTheme.nearlyBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ))
                ],
              );
            }),
      ),
    );
  }
}
