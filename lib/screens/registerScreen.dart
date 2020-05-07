import 'package:homeless/packages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:homeless/regScreenArguments.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/scanData';

  RegistrationScreen({
    Key key,
  }) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Keys
  static GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  final _member = Member();

  // //Controllers
  // final nameController = TextEditingController();
  // final surnameController = TextEditingController();
  // final ageController = TextEditingController();
  // final alternative_phoneNumberController = TextEditingController();
  // final primary_phoneNumberController = TextEditingController();

  //Variables
  String member_id = '';
  String member_name = '';

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
  }

  void _navDash(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var now = DateTime.now();

    // //TODO: Controller Fields
    // var homeless_name = nameController.text;
    // var surname = surnameController.text;
    // var age = ageController.text;
    // var alternative_phoneNumber = alternative_phoneNumberController.text;
    // var primary_phoneNumber = primary_phoneNumberController.text;

    // //TODO: Form Fields
    // var services_needed = '';
    // var gender = '';
    // var approximateDateStartedHomeless = '';
    // var livingSituation = '';
    // var race = '';
    // var skillLevel = '';
    // DateTime dob;
    // var comorbidities;
    // var language;
    // var residentialMoveInDate = '';
    // bool consent;
    // //TODO: Location Search Address and Find Co-ordinates.
    // var address;
    // var streetNickname;
    // //TODO: Understand The Requirments For These Fields.
    // var comorbidities = '';
    // var ssn = '';
    // var health_Status = '';
    // var disabilityCondition = '';

    return GraphQLProvider(
      client: UserRepository.client,
      child: KeyboardAvoider(
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
          body: Center(
            child: SingleChildScrollView(
              child: Query(
                options: QueryOptions(
                  documentNode: gql(Queries.registrationProcess(
                      homeless_id: args.homeless_id)),
                ),
                builder: (QueryResult result,
                    {VoidCallback refetch, FetchMore fetchMore}) {
                  var repositories = result.data;
                  var memberRepositories = result.data;

                  if (result.loading) {
                    return LoadingNews();
                  }

                  if (result.hasException) {
                    print(
                        "clientException: ${result.exception.clientException}");
                    print("GraphException: ${result.exception.graphqlErrors}");
                  }

                  if (!result.hasException) {
                    for (var member in memberRepositories['MemberCollection']) {
                      if (memberRepositories.isEmpty) {
                        print('Report This Card, This is a ghost');
                      }

                      if (memberRepositories.length > 1 == true) {
                        print('Duplicated Account');
                      }

                      print('Who Is This Card Registered: ${member['name']}');
                      break;
                    }

                    for (var card in repositories['CardsCollection']) {
                      if (repositories.isEmpty) {
                        return LoadingNews();
                      }

                      print('Is This Card Registered: ${card}');
                      if (card['registered'] == true) {
                        //If the card exists in our database, verify that there is a user who was assigned this ID.
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('This Card Is Registered'),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, right: 15.0, left: 15.0),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Text('Try Again'),
                                textColor: AppTheme.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                splashColor: AppTheme.nearlyWhite,
                                color: AppTheme.nearlyBlack,
                              ),
                            )
                          ],
                        );
                      } else if (card['registered'] == false) {
                        return Mutation(
                            options: MutationOptions(
                              documentNode: gql(
                                //TODO: Query Variables
                                Queries.addMember(
                                  member_name: member_name,
                                  member_id: member_id,
                                  registered_address: _currentAddress,
                                  join_Time: DateFormat("HH:mm:ss").format(now),
                                  joinedDate:
                                      DateFormat("yyyy-MM-dd").format(now),
                                  registered_lat: _currentPosition == null
                                      ? -0
                                      : _currentPosition.latitude,
                                  registered_lng: _currentPosition == null
                                      ? 0
                                      : _currentPosition.longitude,
                                  homeless_id: args.homeless_id,
                                  //TODO: Form Text Field Data
                                  homeless_name: _member.homeless_name,
                                  surname: _member.surname,
                                  age: _member.age,
                                  comorbidities: _member.comorbidities,
                                  alternative_phoneNumber:
                                      _member.alternative_phoneNumber,
                                  primary_phoneNumber:
                                      _member.primary_phoneNumber,
                                  //TODO: Form Field Data
                                  dob: _member.dob,
                                  consent: _member.consent,
                                  gender: _member.gender,
                                  race: _member.race,
                                  skillLevel: _member.skillLevel,
                                  livingSituation: _member.livingSituation,
                                  // services_needed: _member.services_needed,
                                  address: _currentAddress,
                                  lat: _currentPosition == null
                                      ? 0
                                      : _currentPosition.latitude,
                                  lng: _currentPosition == null
                                      ? 0
                                      : _currentPosition.longitude,
                                  language: _member.language,
                                  approximateDateStartedHomeless:
                                      _member.approximateDateStartedHomeless,

                                  residentialMoveInDate:
                                      _member.residentialMoveInDate,
                                ),
                              ), // this is the mutation string you just created
                              // you can update the cache based on results
                              update: (Cache cache, QueryResult result) {
                                return cache;
                              },
                              // or do something with the result.data on completion
                              onCompleted: (dynamic resultData) {
                                print("resultData: $resultData");
                                _navDash(context); //TODO: Show Pop Over
                              },
                              onError: (error) {
                                print(error);
                                ShowToast.showToast(
                                    error.clientException.message, context);
                              },
                            ),
                            builder: (
                              RunMutation runFormMutation,
                              QueryResult result,
                            ) {
                              return Padding(
                                padding: EdgeInsets.all(25.0),
                                child: Column(
                                  children: <Widget>[
                                    FormBuilder(
                                      key: _fbKey,
                                      autovalidate: true,
                                      child: Wrap(
                                        runSpacing: 20,
                                        children: <Widget>[
                                          FormBuilderTextField(
                                            attribute: "homeless_name",
                                            decoration: InputDecoration(
                                                labelText: "Name"),
                                            validators: [
                                              FormBuilderValidators.min(2),
                                              FormBuilderValidators.max(70),
                                            ],
                                            maxLines: 1,
                                            onChanged: (value) => setState(() =>
                                                _member.homeless_name = value),
                                            onSaved: (value) => setState(() =>
                                                _member.homeless_name = value),
                                          ),
                                          FormBuilderTextField(
                                            attribute: "surname",
                                            decoration: InputDecoration(
                                                labelText: "Surname"),
                                            maxLines: 1,
                                            validators: [
                                              FormBuilderValidators.min(2),
                                              FormBuilderValidators.max(70),
                                            ],
                                            onChanged: (value) => setState(
                                                () => _member.surname = value),
                                            onSaved: (value) => setState(
                                                () => _member.surname = value),
                                          ),
                                          FormBuilderDateTimePicker(
                                            attribute: "dob",
                                            inputType: InputType.date,
                                            format: DateFormat("yyyy-MM-dd"),
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                                labelText: "Date of Birth"),
                                            onChanged: (value) => setState(
                                                () => _member.dob = value),
                                            onSaved: (value) => setState(
                                                () => _member.dob = value),
                                          ),
                                          FormBuilderTextField(
                                            attribute: "age",
                                            decoration: InputDecoration(
                                                labelText: "Estimate Age"),
                                            keyboardType: TextInputType.number,
                                            validators: [
                                              FormBuilderValidators.max(114),
                                              FormBuilderValidators.numeric(),
                                              FormBuilderValidators.min(18),
                                              FormBuilderValidators.required(),
                                            ],
                                            onChanged: (value) => setState(
                                                () => _member.age = value),
                                            onSaved: (value) => setState(
                                                () => _member.age = value),
                                          ),
                                          FormBuilderSegmentedControl(
                                            decoration: InputDecoration(
                                                labelText: "Select Gender"),
                                            attribute: "gender",
                                            textStyle: TextStyle(
                                              color: AppTheme.nearlyWhite,
                                            ),
                                            pressedColor: AppTheme.darkerText,
                                            selectedColor: AppTheme.darkerText,
                                            unselectedColor:
                                                AppTheme.deactivatedText,
                                            validators: [
                                              FormBuilderValidators.required()
                                            ],
                                            options: [
                                              FormBuilderFieldOption(
                                                  value: "Male"),
                                              FormBuilderFieldOption(
                                                  value: "Female"),
                                              FormBuilderFieldOption(
                                                  value: "Other"),
                                            ],
                                            onChanged: (value) => setState(
                                                () => _member.gender = value),
                                            onSaved: (value) => setState(
                                                () => _member.gender = value),
                                          ),
                                          FormBuilderSegmentedControl(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Preferred language"),
                                              attribute: "preferredLanguage ",
                                              textStyle: TextStyle(
                                                color: AppTheme.nearlyWhite,
                                              ),
                                              pressedColor: AppTheme.darkerText,
                                              selectedColor:
                                                  AppTheme.darkerText,
                                              unselectedColor:
                                                  AppTheme.deactivatedText,
                                              validators: [
                                                FormBuilderValidators.required()
                                              ],
                                              options: [
                                                FormBuilderFieldOption(
                                                    value: "English"),
                                                FormBuilderFieldOption(
                                                    value: "Damara/Nama"),
                                                FormBuilderFieldOption(
                                                    value: "Afrikaans"),
                                                FormBuilderFieldOption(
                                                    value: "Oshiwambo"),
                                                FormBuilderFieldOption(
                                                    value: "Other"),
                                              ],
                                              onChanged: (value) => setState(
                                                  () =>
                                                      _member.language = value),
                                              onSaved: (value) => setState(() =>
                                                  _member.language = value)),
                                          FormBuilderRadio(
                                            decoration: InputDecoration(
                                                labelText: "Select Race"),
                                            attribute: "race",
                                            validators: [
                                              FormBuilderValidators.required()
                                            ],
                                            options: [
                                              FormBuilderFieldOption(
                                                  value: "Colored"),
                                              FormBuilderFieldOption(
                                                  value: "Caucasian"),
                                              FormBuilderFieldOption(
                                                  value: "Hispanic or Latino"),
                                              FormBuilderFieldOption(
                                                  value: "Black"),
                                              FormBuilderFieldOption(
                                                  value: "Baster"),
                                              FormBuilderFieldOption(
                                                  value: "Asian"),
                                              FormBuilderFieldOption(
                                                  value: "Indian"),
                                            ],
                                            onChanged: (value) => setState(
                                                () => _member.race = value),
                                            onSaved: (value) => setState(
                                                () => _member.race = value),
                                          ),
                                          FormBuilderSegmentedControl(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Select Skill Level"),
                                              attribute: "skillLevel",
                                              textStyle: TextStyle(
                                                color: AppTheme.nearlyWhite,
                                              ),
                                              pressedColor: AppTheme.darkerText,
                                              selectedColor:
                                                  AppTheme.darkerText,
                                              unselectedColor:
                                                  AppTheme.deactivatedText,
                                              validators: [
                                                FormBuilderValidators.required()
                                              ],
                                              options: [
                                                FormBuilderFieldOption(
                                                    value: "Unskilled"),
                                                FormBuilderFieldOption(
                                                    value: "Semi-Skilled"),
                                                FormBuilderFieldOption(
                                                    value: "Skilled"),
                                              ],
                                              onChanged: (value) => setState(
                                                    () => _member.skillLevel =
                                                        value,
                                                  ),
                                              onSaved: (value) => setState(() =>
                                                  _member.skillLevel = value)),
                                          FormBuilderTextField(
                                              attribute: "primary_phoneNumber",
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Primary Phone Number"),
                                              keyboardType: TextInputType.phone,
                                              validators: [
                                                FormBuilderValidators.maxLength(
                                                    10),
                                                FormBuilderValidators.numeric(),
                                              ],
                                              onChanged: (value) => setState(
                                                  () => _member
                                                          .primary_phoneNumber =
                                                      value),
                                              onSaved: (value) => setState(() =>
                                                  _member.primary_phoneNumber =
                                                      value)),
                                          FormBuilderTextField(
                                              attribute:
                                                  "alternative_phoneNumber",
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Alternative Phone Number"),
                                              keyboardType: TextInputType.phone,
                                              validators: [
                                                FormBuilderValidators.maxLength(
                                                    10),
                                                FormBuilderValidators.numeric(),
                                              ],
                                              onChanged: (value) => setState(
                                                  () => _member
                                                          .alternative_phoneNumber =
                                                      value),
                                              onSaved: (value) => setState(() =>
                                                  _member.alternative_phoneNumber =
                                                      value)),
                                          FormBuilderRadio(
                                            decoration: InputDecoration(
                                                labelText: "Comorbidities"),
                                            attribute: "comorbidities",
                                            validators: [
                                              FormBuilderValidators.required()
                                            ],
                                            options: [
                                              FormBuilderFieldOption(
                                                  value: "Cancers"),
                                              FormBuilderFieldOption(
                                                  value: "Diabetics Mellitus"),
                                              FormBuilderFieldOption(
                                                  value:
                                                      "Central nervous system diseases"),
                                              FormBuilderFieldOption(
                                                  value:
                                                      "Cardiovascular diseases"),
                                              FormBuilderFieldOption(
                                                  value:
                                                      "Obstructive lung diseases"),
                                              FormBuilderFieldOption(
                                                  value:
                                                      "Musculoskeletal diseases"),
                                            ],
                                            onChanged: (value) => setState(() =>
                                                _member.comorbidities = value),
                                            onSaved: (value) => setState(() =>
                                                _member.comorbidities = value),
                                          ),

                                          // FormBuilderTextField(
                                          //   attribute: "address",
                                          //   decoration: InputDecoration(
                                          //       labelText: "Address"),
                                          //   validators: [
                                          //     FormBuilderValidators.min(2),
                                          //     FormBuilderValidators.max(70),
                                          //   ],
                                          //   onChanged: (value) =>
                                          //       setState(() => address = value),
                                          // ),
                                          FormBuilderRadio(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "What is your living situation"),
                                              attribute: "livingSituation",
                                              validators: [
                                                FormBuilderValidators.required()
                                              ],
                                              options: [
                                                FormBuilderFieldOption(
                                                    value: "Not specified"),
                                                FormBuilderFieldOption(
                                                    value:
                                                        "Living on the street (no shelter)"),
                                                FormBuilderFieldOption(
                                                    value:
                                                        "Living in a shelter"),
                                                FormBuilderFieldOption(
                                                    value:
                                                        "living in substandard housing which has been condemned by the municipality"),
                                                FormBuilderFieldOption(
                                                    value:
                                                        "accommodation has recently been destroyed by fire or natural disaster"),
                                                FormBuilderFieldOption(
                                                    value:
                                                        "Using the emergency shelter system as your primary residence"),
                                                FormBuilderFieldOption(
                                                    value:
                                                        "Living with family or friends on a temporary basis for less than six months"),
                                                FormBuilderFieldOption(
                                                    value:
                                                        "Awaiting release from hospital or other time-limited treatment facility and cannot return to your former place of residence due to the modifications required to the home"),
                                              ],
                                              onChanged: (value) => setState(
                                                  () => _member
                                                      .livingSituation = value),
                                              onSaved: (value) => setState(() =>
                                                  _member.livingSituation =
                                                      value)),

                                          // FormBuilderCheckboxList(
                                          //     decoration: InputDecoration(
                                          //         labelText: "Services Needed"),
                                          //     attribute: "services_needed",
                                          //     options: [
                                          //       FormBuilderFieldOption(
                                          //           value: "Food"),
                                          //       FormBuilderFieldOption(
                                          //           value: "Heath Care"),
                                          //       FormBuilderFieldOption(
                                          //           value: "Accomodation"),
                                          //     ],
                                          //     onChanged: (value) => setState(
                                          //         () =>
                                          //             _member.services_needed =
                                          //                 value),
                                          //     onSaved: (value) => setState(() =>
                                          //         _member.services_needed =
                                          //             value)),
                                          FormBuilderSwitch(
                                              label: Text(ConstDetails.consent(
                                                  memberName:
                                                      "${_member.homeless_name} ${_member.surname}")), //Attaches Member Name to Consent Agreement
                                              attribute: "consent",
                                              initialValue: false,
                                              validators: [
                                                FormBuilderValidators
                                                    .requiredTrue()
                                              ],
                                              onChanged: (value) {
                                                setState(() =>
                                                    _member.consent = value);
                                              },
                                              onSaved: (value) => setState(() =>
                                                  _member.consent = value)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Mutation(
                                            options: MutationOptions(
                                              documentNode: gql(
                                                Queries.registerCard(
                                                  id: card['_id'],
                                                  member_name: member_name,
                                                  member_id: member_id,
                                                  claimed_Time:
                                                      DateFormat("HH:mm:ss")
                                                          .format(now),
                                                  claimed_Date:
                                                      DateFormat("yyyy-MM-dd")
                                                          .format(now),
                                                ),
                                              ), // this is the mutation string you just created
                                              // you can update the cache based on results
                                              update: (Cache cache,
                                                  QueryResult result) {
                                                return cache;
                                              },
                                              // or do something with the result.data on completion
                                              onCompleted:
                                                  (dynamic resultData) {
                                                print(
                                                    "resultData: $resultData");
                                                ShowToast.showToast(
                                                    "Successfull Registration",
                                                    context);
                                                // Navigator
                                                //     .pushReplacementNamed(
                                                //         context, '/dash');
                                              },
                                              onError: (error) {
                                                print(error);
                                                ShowToast.showToast(
                                                    error.clientException
                                                        .toString(),
                                                    context);
                                              },
                                            ),
                                            builder: (
                                              RunMutation runMutation,
                                              QueryResult result,
                                            ) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0,
                                                    right: 15.0,
                                                    left: 15.0),
                                                child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(50.0),
                                                  ),
                                                  child: Text(
                                                    "Submit".toUpperCase(),
                                                  ),
                                                  textColor: AppTheme.white,
                                                  onPressed: () {
                                                    if (_fbKey.currentState
                                                        .saveAndValidate()) {
                                                      print(_fbKey
                                                          .currentState.value);

                                                      runMutation({});
                                                      runFormMutation({});
                                                    }
                                                  },
                                                  splashColor:
                                                      AppTheme.nearlyWhite,
                                                  color: AppTheme.nearlyBlack,
                                                ),
                                              );
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0,
                                              right: 15.0,
                                              left: 15.0),
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      50.0),
                                            ),
                                            child: Text(
                                              "Reset".toUpperCase(),
                                            ),
                                            textColor: AppTheme.white,
                                            onPressed: () {
                                              _fbKey.currentState.reset();
                                            },
                                            splashColor: AppTheme.nearlyWhite,
                                            color: AppTheme.nearlyBlack,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      }
                      break;
                    }
                  }

                  return Column(
                    children: <Widget>[
                      Center(
                        child: Text('This is Not a Valid Card'),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 15.0, left: 15.0),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text('Try Again'),
                            textColor: AppTheme.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            splashColor: AppTheme.nearlyWhite,
                            color: AppTheme.nearlyBlack,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
