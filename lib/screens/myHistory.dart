import 'package:homeless/packages.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homeless/services/path-provider.dart';
import 'package:homeless/widgets/loadingNews.dart';
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

  PathProvider pathProvider = PathProvider();
  Permission permission;

  String member_id = '';

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    sharedPreferenceService.getMemberID().then((String memberID) {
      setState(() {
        this.member_id = memberID;
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
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.save), onPressed: () {}),
            )
          ],
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
                  row.add(homelessMember["scanTime"]);
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
              return LoadingNews();
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
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Text(
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
                          onPressed: () async {
                            getCsv().catchError((onError) {
                              ShowToast.showToast(onError.toString(), context);
                            }).whenComplete(() =>
                                ShowToast.showToast("Saved File", context));
                          },
                          splashColor: AppTheme.nearlyWhite,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      Container(
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
          },
        ),
      ),
    );
  }
}
