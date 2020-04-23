import 'package:graphql/client.dart';
import 'package:homeless/packages.dart';
import 'package:homeless/services/sharePreferenceService.dart';
import 'package:homeless/models/apiKey.dart';

//Global instantiation
final ApiKey apiModel = ApiKey();

class Config {
  static final HttpLink _httpLink = HttpLink(
    uri:
        'http://www.sketchdm.co.za/cockpit/api/graphql/query?token=$serverToken',
  );

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: _httpLink,
    ),
  );
}
