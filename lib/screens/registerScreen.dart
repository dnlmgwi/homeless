import 'package:homeless/packages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homeless/services/locationServices.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/scanData';
  // final String homeless_id;
  RegistrationScreen({Key key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Keys
  static GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  final _homelessMember = HomelessMemberReg();

  //Variables
  String member_id = '';
  String member_name = '';
  var calculatedAge;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  initState() {
    locationServices.getCurrentLocation();
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
    final ScreenArgsRegistration args =
        ModalRoute.of(context).settings.arguments;
    var now = DateTime.now();

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
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          LoadingProfile(),
                        ],
                      ),
                    );
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

                      print('Is This Card Registered: $card');
                      if (card['registered'] == true) {
                        //If the card exists in our database, verify that there is a user who was assigned this ID.
                        return RegisteredCardWarning();
                      } else if (card['registered'] == false) {
                        return Mutation(
                            options: MutationOptions(
                              documentNode: gql(
                                //TODO: Query Variables
                                Queries.addMember(
                                  member_name: member_name,
                                  member_id: member_id,
                                  registered_address:
                                      locationServices.currentAddress,
                                  join_Time: DateFormat("HH:mm:ss").format(now),
                                  joinedDate:
                                      DateFormat("yyyy-MM-dd").format(now),
                                  registered_lat:
                                      locationServices.currentPosition == null
                                          ? -0
                                          : locationServices
                                              .currentPosition.latitude,
                                  registered_lng:
                                      locationServices.currentPosition == null
                                          ? 0
                                          : locationServices
                                              .currentPosition.longitude,
                                  homeless_id: args.homeless_id,
                                  //TODO: Form Text Field Data
                                  homeless_name: _homelessMember.homeless_name,
                                  surname: _homelessMember.surname,
                                  age: _homelessMember.age,
                                  comorbidities: _homelessMember.comorbidities,
                                  alternative_phoneNumber:
                                      _homelessMember.alternative_phoneNumber,
                                  primary_phoneNumber:
                                      _homelessMember.primary_phoneNumber,
                                  //TODO: Form Field Data
                                  dateOfBirth: _homelessMember.dateOfBirth,
                                  consent: _homelessMember.consent,
                                  gender: _homelessMember.gender,
                                  race: _homelessMember.race,
                                  skillLevel: _homelessMember.skillLevel,
                                  livingSituation:
                                      _homelessMember.livingSituation,
                                  // services_needed: _member.services_needed,
                                  address: _homelessMember.address,
                                  lat: _homelessMember.lat,
                                  lng: _homelessMember.lng,
                                  language: _homelessMember.language,
                                  approximateDateStartedHomeless:
                                      _homelessMember
                                          .approximateDateStartedHomeless,

                                  residentialMoveInDate:
                                      _homelessMember.residentialMoveInDate,
                                ),
                              ), // this is the mutation string you just created
                              // you can update the cache based on results
                              update: (Cache cache, QueryResult result) {
                                return cache;
                              },
                              // or do something with the result.data on completion
                              onCompleted: (dynamic resultData) {
                                print("resultData: $resultData");
                                _navDash(context);
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
                                          //GENERAL
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
                                                _homelessMember.homeless_name =
                                                    value),
                                            onSaved: (value) => setState(() =>
                                                _homelessMember.homeless_name =
                                                    value),
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
                                            onChanged: (value) => setState(() =>
                                                _homelessMember.surname =
                                                    value),
                                            onSaved: (value) => setState(() =>
                                                _homelessMember.surname =
                                                    value),
                                          ),
                                          FormBuilderDateTimePicker(
                                            attribute: "dob",
                                            inputType: InputType.date,
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                                labelText: "Date of Birth"),
                                            onChanged: (value) => setState(() {
                                              _homelessMember.dateOfBirth =
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(value);
                                              calculatedAge = calc.calculateAge(
                                                  birthDate: DateTime.parse(
                                                      value.toString()));
                                            }),
                                            onSaved: (value) => setState(() {
                                              _homelessMember.dateOfBirth =
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(value);
                                              calculatedAge = calc.calculateAge(
                                                  birthDate: DateTime.parse(
                                                      value.toString()));
                                            }),
                                          ),
                                          Text(
                                              "Calculated Age: ${calculatedAge ??= ''}"),
                                          FormBuilderTextField(
                                            attribute: "age",
                                            decoration: InputDecoration(
                                                labelText: "Estimate Age"),
                                            keyboardType: TextInputType.number,
                                            validators: [
                                              FormBuilderValidators.max(114),
                                              FormBuilderValidators.numeric(),
                                              FormBuilderValidators.min(18),
                                            ],
                                            onChanged: (value) => setState(() =>
                                                _homelessMember.age = value),
                                            onSaved: (value) => setState(() =>
                                                _homelessMember.age = value),
                                          ),
                                          //WHere Abouts
                                          MapBoxPlaceSearchWidget(
                                            apiKey: mapToken,
                                            searchHint: 'Usual Address',
                                            limit: 5,
                                            country: 'NA',
                                            onSelected: (place) {
                                              _homelessMember.address =
                                                  place.placeName;
                                              locationServices
                                                  .getLatLngFromAddress(
                                                address:
                                                    _homelessMember.address,
                                              )
                                                  .then((Placemark onValue) {
                                                _homelessMember.lat =
                                                    onValue.position.latitude;
                                                _homelessMember.lng =
                                                    onValue.position.longitude;
                                              });
                                            },
                                            context: context,
                                          ),
                                          // FormBuilderTextField(
                                          //   attribute: "address",
                                          //   decoration: InputDecoration(
                                          //       labelText: "Usual Address"),
                                          //   validators: [
                                          //     FormBuilderValidators.min(2),
                                          //     FormBuilderValidators.max(70),
                                          //   ],
                                          //   onChanged: (value) {
                                          //     setState(() =>
                                          //         _member.address = value);
                                          //   },
                                          // ),
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
                                            onChanged: (value) => setState(() =>
                                                _homelessMember.gender = value),
                                            onSaved: (value) => setState(() =>
                                                _homelessMember.gender = value),
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
                                                  () => _homelessMember
                                                      .language = value),
                                              onSaved: (value) => setState(() =>
                                                  _homelessMember.language =
                                                      value)),

                                          FormBuilderRadio(
                                            decoration: InputDecoration(
                                                labelText: "Select Ethnicity"),
                                            attribute: "ethnicity",
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
                                            onChanged: (value) => setState(() =>
                                                _homelessMember.race = value),
                                            onSaved: (value) => setState(() =>
                                                _homelessMember.race = value),
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
                                                    () => _homelessMember
                                                        .skillLevel = value,
                                                  ),
                                              onSaved: (value) => setState(() =>
                                                  _homelessMember.skillLevel =
                                                      value)),
                                          FormBuilderSegmentedControl(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Select Level of Education"),
                                              attribute: "levelOfEducation",
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
                                                    () => _homelessMember
                                                        .skillLevel = value,
                                                  ),
                                              onSaved: (value) => setState(() =>
                                                  _homelessMember.skillLevel =
                                                      value)),
                                          FormBuilderTextField(
                                              attribute: "primary_phoneNumber",
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Primary Phone Number"),
                                              keyboardType: TextInputType.phone,
                                              validators: [
                                                FormBuilderValidators.maxLength(
                                                    10),
                                                FormBuilderValidators.minLength(
                                                    10),
                                                FormBuilderValidators.numeric(),
                                              ],
                                              onChanged: (value) => setState(
                                                  () => _homelessMember
                                                          .primary_phoneNumber =
                                                      value),
                                              onSaved: (value) => setState(() =>
                                                  _homelessMember
                                                          .primary_phoneNumber =
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
                                                FormBuilderValidators.minLength(
                                                    10),
                                                FormBuilderValidators.numeric(),
                                              ],
                                              onChanged: (value) => setState(
                                                  () => _homelessMember
                                                          .alternative_phoneNumber =
                                                      value),
                                              onSaved: (value) => setState(() =>
                                                  _homelessMember
                                                          .alternative_phoneNumber =
                                                      value)),
                                          FormBuilderCheckboxList(
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
                                                  value:
                                                      "Cardiovascular diseases"),
                                              FormBuilderFieldOption(
                                                  value:
                                                      "Central nervous system diseases"),
                                              FormBuilderFieldOption(
                                                  value: "Diabetics Mellitus"),
                                              FormBuilderFieldOption(
                                                  value:
                                                      "Obstructive lung diseases"),
                                              FormBuilderFieldOption(
                                                  value:
                                                      "Musculoskeletal diseases"),
                                            ],
                                            onChanged: (value) => setState(() {
                                              for (var com in value) {
                                                _homelessMember.comorbidities
                                                    .add(com);
                                              }
                                            }),
                                            onSaved: (value) => setState(() {
                                              for (var com in value) {
                                                _homelessMember.comorbidities
                                                    .add(com);
                                              }
                                            }),
                                          ),

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
                                                  () => _homelessMember
                                                      .livingSituation = value),
                                              onSaved: (value) => setState(() =>
                                                  _homelessMember
                                                          .livingSituation =
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
                                              label: Text(ConstantDetails.consent(
                                                  memberName:
                                                      "${_homelessMember.homeless_name} ${_homelessMember.surname}")), //Attaches Member Name to Consent Agreement
                                              attribute: "consent",
                                              initialValue: false,
                                              validators: [
                                                FormBuilderValidators
                                                    .requiredTrue()
                                              ],
                                              onChanged: (value) {
                                                setState(() => _homelessMember
                                                    .consent = value);
                                              },
                                              onSaved: (value) => setState(() =>
                                                  _homelessMember.consent =
                                                      value)),
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
                                                    "Successful Registration",
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
                  return InvalidCardWarning();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
