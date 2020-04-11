import 'package:homeless/packages.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homeless/widgets/NewsArticle.dart';
import 'package:homeless/widgets/loadingNews.dart';
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
        body: Query(
          options: QueryOptions(
            documentNode: gql(Queries.getNews()),
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.loading) {
              return LoadingNews();
            }

            if (result.hasException) {
              print(result.exception.toString());
              _alert(context: this.context, error: result.exception.toString());
            }

            if (!result.hasException) {
              final List<dynamic> repositories =
                  result.data['NewsCollection'] as List<dynamic>;

              if (repositories.isEmpty) {
                print('No News!');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "No News",
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w400,
                        fontSize: 8,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
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
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          this.context,
                          MaterialPageRoute(
                            builder: (context) => NewsArticleScreen(
                              content: repositories[index]['content'],
                              title: repositories[index]['title'],
                              image: responseData['image']['path'],
                              posted: repositories[index]['posted'],
                              source: repositories[index]['source'],
                              meta: responseData['image']['meta']['title'],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              "${responseData['image']['path']}",
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              height: 150,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          AutoSizeText(
                            "${repositories[index]['title']}",
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 1,
                              color: AppTheme.darkerText,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          AutoSizeText(
                            "${repositories[index]['source']} • ${timeago.format(DateTime.parse(repositories[index]['posted']))}",
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w400,
                              fontSize: 9,
                              color: AppTheme.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: AutoSizeText(
                              "${repositories[index]['description']}",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: AppTheme.grey,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return LoadingNews();
          },
        ),
      ),
    );
  }
}
