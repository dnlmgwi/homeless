import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class Config {
  static HttpLink _httpLink = HttpLink(
    uri: 'http://www.sketchdm.co.za/cockpit/api/graphql/query',
  );

  static AuthLink _authLink = AuthLink(
    getToken: () async => 'Bearer 63be767e15f85bbf0d9882487ef712',
  );

  static Link _link = _authLink.concat(_httpLink);

  static GraphQLClient client = GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );
}
