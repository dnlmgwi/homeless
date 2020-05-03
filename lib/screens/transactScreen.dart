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
  String member_name = '';
  String _selectedProject;

  Position _currentPosition;
  String _currentAddress;

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
            // "${place.country}, ${place.locality}, ${place.postalCode}, ${place.locality}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.name}";
            "${place.country}, ${place.locality}, ${place.postalCode}, ${place.locality}, ${place.subLocality}, ${place.subAdministrativeArea}";
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
    sharedPreferenceService.getMemberID().then((String memberID) {
      this.member_id = memberID;
    });
    sharedPreferenceService.getName().then((String name) {
      this.member_name = name;
    });

    myFocusNode = FocusNode();
  }

  void _navDash(BuildContext context) {
    Navigator.of(context).pop();
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
                onPressed: () {
                  Navigator.of(context).pop();
                  _navDash(context);
                },
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
                  member_name: member_name,
                  member_id: member_id,
                  project: _selectedProject,
                  address: _currentAddress,
                  scanDate: DateFormat("yyyy-MM-dd").format(now),
                  scanTime: DateTime.now().millisecondsSinceEpoch,
                  //TODO: Find Default Lat, Long
                  lat:
                      _currentPosition == null ? -0 : _currentPosition.latitude,
                  lng:
                      _currentPosition == null ? 0 : _currentPosition.longitude,
                  homeless_id: widget
                      .id)), // this is the mutation string you just created
              // you can update the cache based on results
              update: (Cache cache, QueryResult result) {
                return cache;
              },
              // or do something with the result.data on completion
              onCompleted: (dynamic resultData) {
                _alert(
                    context: context,
                    result:
                        'Transaction Ref: ${resultData['saveCollectionItem']['data']['_id']}');
              },
              onError: (error) {
                print(error.clientException.message);
              },
            ),
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
                                // Container(
                                //   width: 120.0,
                                //   height: 120.0,
                                //   decoration: BoxDecoration(
                                //     color: AppTheme.grey,
                                //     shape: BoxShape.circle,
                                //     image: DecorationImage(
                                //       fit: BoxFit.cover,
                                //       image: NetworkImage(
                                //         "http://www.sketchdm.co.za${widget.image}",
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                          Query(
                                              options: QueryOptions(
                                                documentNode: gql(
                                                  Queries.getProjects(),
                                                ),
                                              ),
                                              builder: (QueryResult result,
                                                  {VoidCallback refetch,
                                                  FetchMore fetchMore}) {
                                                if (result.loading) {
                                                  return Text('Loading...');
                                                }

                                                if (result.hasException) {
                                                  print(result.exception
                                                      .clientException.message);
                                                }

                                                if (!result.hasException) {
                                                  List<String> listedProjects =
                                                      [];
                                                  List<String>
                                                      getListOfProjects() {
                                                    for (var project in result
                                                            .data[
                                                        'ProjectsCollection']) {
                                                      listedProjects
                                                          .add(project['name']);
                                                      print('Project Name:' +
                                                          project['name']);
                                                    }

                                                    return listedProjects;
                                                  }

                                                  return DropdownButton(
                                                    hint: Text(
                                                        'Please select a project'), // Not necessary for Option 1
                                                    value: _selectedProject,
                                                    autofocus: true,
                                                    focusNode: myFocusNode,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _selectedProject =
                                                            newValue;
                                                      });
                                                    },
                                                    items: getListOfProjects()
                                                        .map((String project) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        child: Text(project),
                                                        value: project,
                                                      );
                                                    }).toList(),
                                                  );
                                                }
                                                return Container();
                                              }),
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
                          food && accomodation && healthCare == true ||
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
                                        subtitle: _selectedProject == null
                                            ? FlatButton(
                                                padding: EdgeInsets.all(15.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                child: Text(
                                                  "Please Select Project",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    letterSpacing: 1,
                                                    color: AppTheme.nearlyBlack,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  myFocusNode.requestFocus();
                                                },
                                                splashColor:
                                                    AppTheme.nearlyWhite,
                                                color: AppTheme.notWhite,
                                              )
                                            : FlatButton.icon(
                                                padding: EdgeInsets.all(15.0),
                                                icon: Icon(Icons.payment,
                                                    color: AppTheme.white),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                label: Text(
                                                  "Give Help",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    letterSpacing: 1,
                                                    color: AppTheme.nearlyWhite,
                                                  ),
                                                ),
                                                textColor: AppTheme.white,
                                                onPressed: () =>
                                                    runMutation({}),
                                                splashColor:
                                                    AppTheme.nearlyWhite,
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
