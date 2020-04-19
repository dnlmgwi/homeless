import 'package:homeless/packages.dart';
import 'package:homeless/data/graphqlQueries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homeless/widgets/loadingNews.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
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
          backgroundColor: AppTheme.chipBackground,
          title: Text(
            "Stats",
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
            documentNode: gql(Queries.addTransaction()),
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.loading) {
              print('loading...');
            }

            if (result.hasException) {
              print(result.exception.toString());
            }

            if (!result.hasException) {
              final List<dynamic> repositories =
                  result.data['StatsCollection'] as List<dynamic>;

              if (repositories.isEmpty) {
                print('No News!');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "No Stats",
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
            }

            return LoadingNews();
          },
        ),
      ),
    );
  }
}
