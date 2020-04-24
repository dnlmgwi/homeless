import 'package:homeless/packages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    Key key,
  }) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController servicesController = TextEditingController();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
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

  List<String> _project = ['Fight Coronavirus', 'MOHSS: Namibia'];
  String _selectedProject;

  Position _currentPosition;
  String _currentAddress;

  FocusNode myFocusNode;

  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    super.dispose();
    nameController.dispose();
    surnameController.dispose();
  }

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

  _alertError({context, result}) {
    showDialog(
        context: context, //builds a context of its own
        builder: (BuildContext context) {
          return RichAlertDialog(
            //uses the custom alert dialog imported
            alertTitle: richTitle("Failed"),
            alertSubtitle: richSubtitle("$result"),
            alertType: RichAlertType.ERROR,
            actions: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Text("Try Again",
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
            "Registration",
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
              documentNode: gql(Queries.addMember(
                approximateDateStartedHomeless:
                    DateFormat("yyyy-MM-dd").format(now),
                dob: DateFormat("yyyy-MM-dd").format(now),
                ethnicity: DateFormat("yyyy-MM-dd").format(now),
                gender: DateFormat("yyyy-MM-dd").format(now),
                location: DateFormat("yyyy-MM-dd").format(now),
                name: DateFormat("yyyy-MM-dd").format(now),
                phoneNumber: DateFormat("yyyy-MM-dd").format(now),
                race: DateFormat("yyyy-MM-dd").format(now),
                residentialMoveInDate: DateFormat("yyyy-MM-dd").format(now),
                services_needed: DateFormat("yyyy-MM-dd").format(now),
                surname: DateFormat("yyyy-MM-dd").format(now),
                consent: DateFormat("yyyy-MM-dd").format(now),
                joinedDate: DateFormat("yyyy-MM-dd").format(now),
              )), // this is the mutation string you just created
              // you can update the cache based on results
              update: (Cache cache, QueryResult result) {
                return cache;
              },
              // or do something with the result.data on completion
              onCompleted: (dynamic resultData) {
                resultData != null
                    ? _alert(
                        context: context,
                        result:
                            'Transaction Ref: ${resultData['saveCollectionItem']['data']['_id']}')
                    : _alertError(
                        context: context,
                      );
              },
              onError: (error) {
                print(error);
                _alertError(
                  context: context,
                  result: error.clientException.message,
                );
              },
            ),
            builder: (
              RunMutation runMutation,
              QueryResult result,
            ) {
              return SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _fbKey,
                      initialValue: {
                        'date': DateTime.now(),
                        'accept_terms': false,
                      },
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            decoration: InputDecoration(labelText: "Card ID"),
                            attribute: "id",
                            autovalidate: true,
                            controller: idController,
                            enabled: false,
                            showCursor: true,
                          ),
                          FormBuilderTextField(
                            decoration:
                                InputDecoration(labelText: "Member Name"),
                            attribute: "name",
                            autovalidate: true,
                            controller: nameController,
                            showCursor: true,
                          ),
                          FormBuilderTextField(
                            decoration:
                                InputDecoration(labelText: "Member Surname"),
                            attribute: "surname",
                            autovalidate: true,
                            controller: surnameController,
                            showCursor: true,
                          ),
                          FormBuilderDropdown(
                            attribute: "gender",
                            decoration: InputDecoration(labelText: "Gender"),
                            // initialValue: 'Male',
                            hint: Text('Select Gender'),
                            validators: [FormBuilderValidators.required()],
                            items: ['Female', 'Male', 'Nonconforming']
                                .map((gender) => DropdownMenuItem(
                                    value: gender, child: Text("$gender")))
                                .toList(),
                          ),
                          FormBuilderDropdown(
                            attribute: "race",
                            decoration: InputDecoration(labelText: "Race"),
                            // initialValue: 'Male',
                            hint: Text('Select Race'),
                            validators: [FormBuilderValidators.required()],
                            items: [
                              'Black',
                              'White',
                              'Coloured',
                              'Baster',
                            ]
                                .map((race) => DropdownMenuItem(
                                    value: race, child: Text("$race")))
                                .toList(),
                          ),
                          Divider(),
                          FormBuilderDateTimePicker(
                            attribute: "dob",
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            decoration:
                                InputDecoration(labelText: "Date of birth"),
                          ),
                          FormBuilderDropdown(
                            attribute: "location",
                            decoration:
                                InputDecoration(labelText: "Usual Location"),
                            // initialValue: 'Male',
                            hint: Text('Select Location'),
                            validators: [FormBuilderValidators.required()],
                            items: [
                              'Katutura',
                            ]
                                .map((gender) => DropdownMenuItem(
                                    value: gender, child: Text("$gender")))
                                .toList(),
                          ),
                          FormBuilderTextField(
                            decoration:
                                InputDecoration(labelText: "Phone Number"),
                            attribute: "phoneNumber",
                            validators: [FormBuilderValidators.max(10)],
                            controller: nameController,
                            keyboardType: TextInputType.number,
                            showCursor: true,
                          ),
                          FormBuilderDateTimePicker(
                            attribute: "joinedDate",
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            decoration:
                                InputDecoration(labelText: "Date joined"),
                          ),
                          FormBuilderDateTimePicker(
                            attribute: "approximateDateStartedHomeless",
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            decoration: InputDecoration(
                                labelText: "Date Started Homelessness"),
                          ),
                          FormBuilderTextField(
                            decoration:
                                InputDecoration(labelText: "Services Needed"),
                            attribute: "services_needed",
                            autovalidate: true,
                            controller: servicesController,
                            showCursor: true,
                          ),
                          FormBuilderCheckbox(
                            attribute: 'accept_terms',
                            label: Text(
                                "I have read and agree to the terms and conditions"),
                            validators: [
                              FormBuilderValidators.requiredTrue(
                                errorText:
                                    "You must accept terms and conditions to continue",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        MaterialButton(
                          child: Text("Submit"),
                          onPressed: () {
                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value);
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("Reset"),
                          onPressed: () {
                            _fbKey.currentState.reset();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ));
            }),
      ),
    );
  }
}
