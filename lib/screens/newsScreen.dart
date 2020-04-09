import 'package:homeless/packages.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  //This Method Launches the alert Dialogue for an API Error
  _alert({context, error}) {
    showDialog(
        context: context, //builds a context of its own
        builder: (BuildContext context) {
          print('$error');
          return RichAlertDialog(
            //uses the custom alert dialog imported
            alertTitle: richTitle("Network Error"),
            alertSubtitle: richSubtitle(
                "This feature requires internet access.\n Please turn on mobile data or Wifi"),
            alertType: RichAlertType.ERROR,
            actions: <Widget>[
              RaisedButton(
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/dash');
                }, //closes the dialogue
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.client,
      child: Container(
        color: AppTheme.nearlyWhite,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: AppTheme.chipBackground,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              titleSpacing: 1.2,
              centerTitle: false,
              backgroundColor: AppTheme.dark_grey,
              title: Text(
                "News",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  letterSpacing: 1.2,
                  color: AppTheme.nearlyWhite,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(5.0),
              child: Query(
                options: QueryOptions(
                  documentNode: gql(Queries.getNews()),
                ),
                builder: (QueryResult result,
                    {VoidCallback refetch, FetchMore fetchMore}) {
                  if (result.loading) {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          // LoadingProfile(),
                          Center(
                            child: Text('Loading...'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (result.hasException) {
                    print(result.exception.toString());
                    _alert(
                        context: this.context,
                        error: result.exception.toString());
                  }

                  if (!result.hasException) {
                    final List<dynamic> repositories =
                        result.data['NewsCollection'] as List<dynamic>;

                    if (repositories.isEmpty) {
                      print('No News!');
                      return Center(
                        child: AutoSizeText(
                          "No News",
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            letterSpacing: 1,
                            color: AppTheme.darkerText,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: repositories.length,
                      itemBuilder: (context, index) {
                        dynamic responseData = repositories[index];
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Image.network(
                                  "${responseData['image']['path']}",
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                title: AutoSizeText(
                                  "${repositories[index]['title']}",
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    letterSpacing: 1,
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                                subtitle: AutoSizeText(
                                  "${repositories[index]['source']} - ${timeago.format(DateTime.parse(repositories[index]['posted']))}",
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8,
                                    color: AppTheme.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: SizedBox(
                                  child: AutoSizeText(
                                    "${repositories[index]['description']}",
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: AppTheme.grey,
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
