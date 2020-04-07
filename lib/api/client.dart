import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class Config {
  static final String token = '63be767e15f85bbf0d9882487ef712';

  static final HttpLink _httpLink = HttpLink(
    uri: 'http://www.sketchdm.co.za/cockpit/api/graphql/query?token=$token',
  );

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: _httpLink,
    ),
  );
}
