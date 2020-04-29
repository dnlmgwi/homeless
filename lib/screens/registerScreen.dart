import 'package:homeless/packages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class RegisterationScreen extends StatefulWidget {
  final String homeless_id;

  RegisterationScreen({
    Key key,
    this.homeless_id,
  }) : super(key: key);
  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  //Keys
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  //Controllers
  final nameController = TextEditingController();
  final surnameController = TextEditingController();

  var now = DateTime.now();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
  }

  void _navDash({BuildContext context, String id}) {
    Navigator.popAndPushNamed(context, '/dash');
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
                  _navDash(
                      context: context,
                      id: result['saveCollectionItem']['data']['_id']);
                },
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
                onPressed: () => Navigator.pop(context),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Query(
                options: QueryOptions(
                  documentNode: gql(Queries.registrationProcess(
                      homeless_id: widget.homeless_id)),
                ),
                builder: (QueryResult result,
                    {VoidCallback refetch, FetchMore fetchMore}) {
                  if (result.loading) {
                    Text('Loading...');
                  }

                  if (result.hasException) {
                    print(
                        "clientException: ${result.exception.clientException}");
                    print("GraphException: ${result.exception.graphqlErrors}");
                    return Container(
                      child: Text('Error'),
                    );
                  }

                  for (var card in result.data['CardsCollection']) {
                    print('Is This Card Registered: ${card['registered']}');
                    if (card['registered'] == true) {
                      //If the card exists in our database, verify that there is a user who was assigned this ID.
                      return Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                                'Is This Card Registered ${card['registered'].toString()}'),
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
                    } else if (card['registered'] == false) {
                      return Mutation(
                          options: MutationOptions(
                            documentNode: gql(
                              Queries.addMember(
                                homeless_id: widget.homeless_id,
                                joinedDate:
                                    DateFormat("yyyy-MM-dd").format(now),
                                name: nameController.text,
                                surname: surnameController.text,
                              ),
                            ), // this is the mutation string you just created
                            // you can update the cache based on results
                            update: (Cache cache, QueryResult result) {
                              return cache;
                            },
                            // or do something with the result.data on completion
                            onCompleted: (dynamic resultData) {
                              print("resultData: $resultData");
                              // ShowToast.showToast("has been added", context); //TODO: Show Pop Over
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
                              padding: EdgeInsets.all(24.0),
                              child: Column(
                                children: <Widget>[
                                  FormBuilder(
                                    key: _fbKey,
                                    initialValue: {
                                      'date':
                                          DateFormat("yyyy-MM-dd").format(now),
                                      'accept_terms': false,
                                    },
                                    autovalidate: true,
                                    child: KeyboardAvoider(
                                      child: Column(
                                        children: <Widget>[
                                          FormBuilderTextField(
                                            decoration: InputDecoration(
                                                labelText: "Member Name"),
                                            attribute: "name",
                                            autovalidate: true,
                                            controller: nameController,
                                            showCursor: true,
                                          ),
                                          FormBuilderTextField(
                                            decoration: InputDecoration(
                                                labelText: "Member Surname"),
                                            attribute: "surname",
                                            autovalidate: true,
                                            controller: surnameController,
                                            showCursor: true,
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Mutation(
                                          options: MutationOptions(
                                            documentNode: gql(
                                              Queries.registerCard(
                                                  id: card['_id']),
                                            ), // this is the mutation string you just created
                                            // you can update the cache based on results
                                            update: (Cache cache,
                                                QueryResult result) {
                                              return cache;
                                            },
                                            // or do something with the result.data on completion
                                            onCompleted: (dynamic resultData) {
                                              print("resultData: $resultData");
                                              ShowToast.showToast(
                                                  "has been Registered",
                                                  context);
                                              Navigator.pushReplacementNamed(
                                                  context, '/dash');
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
                                                      new BorderRadius.circular(
                                                          50.0),
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
                                                    print("Press");
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
                                            top: 20.0, right: 15.0, left: 15.0),
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(50.0),
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
                    } else {
                      for (var member in result.data['MemberCollection']) {
                        print(
                            'Is This Card Registered: ${member['registered']}');
                        if (member['registered'] == true) {
                          //If the card exists in our database, verify that there is a user who was assigned this ID.
                          return Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                    'This Card Is Registered ${member['registered']}'),
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
                        } else {}
                      }
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
            ],
          )),
    );
  }
}
