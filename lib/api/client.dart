import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class Config {
  static const String token = 'account-7031140f0eff6bcd608a1b966f00e9';

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
