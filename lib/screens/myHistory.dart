import 'package:homeless/packages.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homeless/services/path-provider.dart';
import 'package:intl/intl.dart';

class MyHistoryScreen extends StatefulWidget {
  final String id;

  MyHistoryScreen({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _MyHistoryScreenState createState() => _MyHistoryScreenState();
}

class _MyHistoryScreenState extends State<MyHistoryScreen> {
  _launchReport({String ref, String date}) async {
    FlutterOpenWhatsapp.sendSingleMessage("+27722326766",
        "Homeless App Reporting a transaction: \nRef: $ref, \nDate: $date");
  }

  _launchAuthReport({String name, String email}) async {
    FlutterOpenWhatsapp.sendSingleMessage("+27722326766",
        "Homeless App Reporting account authorization: \nMember Name: $name, \nMember Email: $email");
  }

  PathProvider pathProvider = PathProvider();
  Permission permission;

  String member_id = '';
  String member_email = '';
  String member_name = '';

  ///TODO: Epoch to Normal Time Converstion
  // ${DateFormat("HH:mm:ss").format(DateTime.fromMicrosecondsSinceEpoch(int.parse(transactions[index]["scanTime"])))}

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    sharedPreferenceService.getMemberEmail().then((String memberEmail) {
      setState(() {
        this.member_email = memberEmail;
      });
    });

    sharedPreferenceService.getMemberID().then((String memberID) {
      setState(() {
        this.member_id = memberID;
      });
    });

    sharedPreferenceService.getName().then((String memberName) {
      setState(() {
        this.member_name = memberName;
      });
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
            "myHistory",
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
        body: Query(
          options: QueryOptions(
            documentNode: gql(
              Queries.getMyHistory(member_id: member_id),
            ),
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            FetchMoreOptions options = FetchMoreOptions(
              updateQuery: (previousResultData, fetchMoreResultData) {
                // this function will be called so as to combine both the original and fetchMore results
                // it allows you to combine them as you would like
                final List<dynamic> repos = [
                  ...previousResultData['collection'] as List<dynamic>,
                  ...fetchMoreResultData['collection'] as List<dynamic>
                ];

                // to avoid a lot of work, lets just update the list of repos in returned
                // data with new data, this also ensures we have the endCursor already set
                // correctly
                fetchMoreResultData['collection'] = repos;

                return fetchMoreResultData;
              },
            );

            getCsv() async {
              List<List<dynamic>> rows = List<List<dynamic>>();
              await Permission.storage.request();
              rows.add([
                "member_name",
                "scanDate",
                "scanTime",
                "project",
                "address",
                "healthcare",
                "food",
                "accommodation"
              ]);

              if (result.data['collection'] != null) {
                for (var homelessMember in result.data['collection']) {
                  List<dynamic> row = List<dynamic>();
                  row.add(homelessMember["member_name"]);
                  row.add(homelessMember["scanDate"]);
                  row.add(DateFormat("HH:mm:ss").format(
                      DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(homelessMember["scanTime"]))));
                  row.add(homelessMember["project"]);
                  row.add(homelessMember["location"]["address"]);
                  row.add(homelessMember["healthcare"]);
                  row.add(homelessMember["food"]);
                  row.add(homelessMember["accommodation"]);
                  rows.add(row);
                }

                if (await Permission.storage.request().isGranted) {
                  // Either the permission was already granted before or the user just granted it.
                  File file = await pathProvider.localFile;

                  String csv = const ListToCsvConverter().convert(rows);
                  file.writeAsString(csv);
                }
              }
            }

            if (result.loading) {
              return LoadingHistory();
            }

            if (result.hasException) {
              print(result.exception.toString());
            }

            if (!result.hasException) {
              final List<dynamic> transactions =
                  result.data['collection'] as List<dynamic>;

              if (transactions.isEmpty) {
                print('No Transaction!');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: AutoSizeText(
                      "No Transactions",
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: AppTheme.grey,
                      ),
                    )),
                  ],
                );
              } else
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton.icon(
                              icon: FaIcon(
                                FontAwesomeIcons.spinner,
                                size: 18,
                              ),
                              padding: EdgeInsets.all(5.0),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(50.0),
                              // ),
                              label: Text(
                                "Load All".toUpperCase(),
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 9,
                                  letterSpacing: 1,
                                  color: AppTheme.nearlyWhite,
                                ),
                              ),
                              textColor: AppTheme.white,
                              onPressed: () async => fetchMore(options),
                              splashColor: AppTheme.nearlyWhite,
                              color: AppTheme.nearlyBlack,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton.icon(
                              padding: EdgeInsets.all(5.0),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(50.0),
                              // ),
                              icon: FaIcon(
                                FontAwesomeIcons.fileCsv,
                                size: 18,
                              ),
                              label: Text(
                                "Export CSV".toUpperCase(),
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 9,
                                  letterSpacing: 1,
                                  color: AppTheme.nearlyWhite,
                                ),
                              ),
                              textColor: AppTheme.white,
                              onPressed: () async => getCsv()
                                  .catchError((onError) => ShowToast.showToast(
                                      onError.toString(), context))
                                  .whenComplete(() => ShowToast.showToast(
                                      "Saved File", context)),
                              splashColor: AppTheme.nearlyWhite,
                              color: AppTheme.nearlyBlack,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
//              separatorBuilder: (BuildContext context, int index) => Divider(),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(4.0),
                              padding: EdgeInsets.all(20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: InkWell(
                                // onTap: () {
                                //   Navigator.push(
                                //     this.context,
                                //     MaterialPageRoute(
                                //       builder: (context) => NewsArticleScreen(
                                //         content: repositories[index]['content'],
                                //         title: repositories[index]['title'],
                                //         image: responseData['image']['path'],
                                //         posted: repositories[index]['posted'],
                                //         source: repositories[index]['source'],
                                //         meta: responseData['image']['meta']['title'],
                                //       ),
                                //     ),
                                //   );
                                // },
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 1,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.circular(15.0),
                                    //   child: Image.network(
                                    //     "${responseData['image']['path']}",
                                    //     width: 100,
                                    //     fit: BoxFit.cover,
                                    //     height: 100,
                                    //   ),
                                    // ),

                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              AutoSizeText(
                                                "${transactions[index]['scanDate']} • ${TimeAgo.getTimeAgo(int.parse(transactions[index]['scanTime']))}",
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: AppTheme.grey,
                                                ),
                                              ),
                                              Spacer(),
                                              RaisedButton(
                                                clipBehavior: Clip.antiAlias,
                                                child: Text(
                                                  'Report',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22.0)),
                                                color: AppTheme.nearlyWhite,
                                                onPressed: () => _launchReport(
                                                    ref: transactions[index]
                                                        ['_id'],
                                                    date: transactions[index]
                                                        ['scanDate']),
                                              ),
                                            ],
                                          ),
                                          AutoSizeText(
                                            "Transaction Ref: ${transactions[index]['_id']}",
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: AppTheme.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: AutoSizeText(
                      "Unauthorised",
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: AppTheme.grey,
                      ),
                    )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: MaterialButton(
                    onPressed: () {
                      _launchAuthReport(email: member_email, name: member_name);
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
            );
          },
        ),
      ),
    );
  }
}
