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

  //Controllers
  final nameController = TextEditingController();
  final surnameController = TextEditingController();

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
    nameController.dispose();
    surnameController.dispose();
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
    var homeless_name;
    var services_needed = [];
    var gender = '';
    var approximateDateStartedHomeless = '';
    var ethnicity = '';
    var address = '';
    var age = '';
    var dob;
    var location = '';
    var phoneNumber = '';
    var residentialMoveInDate = '';
    var surname = '';
    bool consent = false;

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
                                  //TODO: Form Field Data
                                  homeless_name: homeless_name ??=
                                      args.homeless_id.split('-')[0],
                                  surname: surname,
                                  consent: consent,
                                  gender: gender,
                                  services_needed: services_needed,
                                  dob: dob,
                                  address: _currentAddress,
                                  lat: _currentPosition == null
                                      ? 0
                                      : _currentPosition.latitude,
                                  lng: _currentPosition == null
                                      ? 0
                                      : _currentPosition.longitude,
                                  age: age,
                                  approximateDateStartedHomeless:
                                      approximateDateStartedHomeless,
                                  ethnicity: ethnicity,

                                  phoneNumber: phoneNumber,
                                  residentialMoveInDate: residentialMoveInDate,
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
                                    error.clientException.toString(), context);
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
                                      initialValue: {
                                        // 'date': DateFormat("yyyy-MM-dd").format(now),
                                        'consent': false,
                                        'phoneNumber':
                                            "0000000000" //TODO: Shelter Number
                                      },
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
                                            onChanged: (value) =>
                                                homeless_name = value,
                                          ),
                                          FormBuilderTextField(
                                            attribute: "surname",
                                            decoration: InputDecoration(
                                                labelText: "surname"),
                                            validators: [
                                              FormBuilderValidators.min(2),
                                              FormBuilderValidators.max(70),
                                            ],
                                            onChanged: (value) =>
                                                setState(() => surname = value),
                                          ),
                                          FormBuilderDropdown(
                                            attribute: "gender",
                                            decoration: InputDecoration(
                                                labelText: "Gender"),
                                            // initialValue: 'Male',
                                            hint: Text('Select Gender'),
                                            validators: [
                                              FormBuilderValidators.required()
                                            ],
                                            items: [
                                              'Male',
                                              'Female',
                                              'Nonconforming'
                                            ]
                                                .map((gender) =>
                                                    DropdownMenuItem(
                                                        value: gender,
                                                        child: Text("$gender")))
                                                .toList(),
                                            onChanged: (value) =>
                                                setState(() => gender = value),
                                          ), //TODO: Gender
                                          FormBuilderDateTimePicker(
                                            attribute: "dob",
                                            inputType: InputType.date,
                                            format: DateFormat("yyyy-MM-dd"),
                                            decoration: InputDecoration(
                                                labelText: "Date of Birth"),
                                            onChanged: (value) =>
                                                setState(() => dob = value),
                                          ),
                                          FormBuilderTextField(
                                            attribute: "age",
                                            decoration: InputDecoration(
                                                labelText: "Age"),
                                            validators: [
                                              FormBuilderValidators.max(114),
                                              FormBuilderValidators.numeric()
                                            ],
                                            onChanged: (value) =>
                                                setState(() => age = value),
                                          ),

                                          FormBuilderTextField(
                                              attribute: "phoneNumber",
                                              decoration: InputDecoration(
                                                  labelText: "Phone Number"),
                                              validators: [
                                                FormBuilderValidators.maxLength(
                                                    10),
                                                FormBuilderValidators.minLength(
                                                    10),
                                                FormBuilderValidators.numeric()
                                              ],
                                              onChanged: (value) => setState(
                                                  () => phoneNumber = value)),
                                          FormBuilderTextField(
                                            attribute: "address",
                                            decoration: InputDecoration(
                                                labelText: "Address"),
                                            validators: [
                                              FormBuilderValidators.min(2),
                                              FormBuilderValidators.max(70),
                                            ],
                                            onChanged: (value) =>
                                                setState(() => address = value),
                                          ),

                                          FormBuilderCheckboxList(
                                            decoration: InputDecoration(
                                                labelText: "Services Needed"),
                                            attribute: "services_needed",
                                            options: [
                                              FormBuilderFieldOption(
                                                  value: "Food"),
                                              FormBuilderFieldOption(
                                                  value: "Heath Care"),
                                              FormBuilderFieldOption(
                                                  value: "Accomodation"),
                                            ],
                                            onChanged: (value) => setState(
                                                () => services_needed = value),
                                          ),
                                          FormBuilderSwitch(
                                            label: Text(
                                                'I Accept the tems and conditions'),
                                            attribute: "consent",
                                            initialValue: false,
                                            validators: [
                                              FormBuilderValidators.required()
                                            ],
                                            onChanged: (value) =>
                                                setState(() => consent = value),
                                          ),
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
                                                    "Successfull Registered",
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
