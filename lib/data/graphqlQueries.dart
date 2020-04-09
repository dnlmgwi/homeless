class Queries {
  static String verifyUser() {
    return r'''query checkMember($_id: String!) {
    MemberCollection(_id: $_id)
    {
      name
      surname
      age
      joined
      points
      _id
      _created
      rating
      about
      picture {
        path
      }
      location {
      address
      }
    }
    }''';
  }

  static String getNews() {
    return r'''query loadNews {
      NewsCollection
      {
        image {
          path
          meta
          }
        title
        source
        author
        description
        content
        posted
      }
  }''';
  }

  // void resultsPrint({String id}) async {
  //   final QueryOptions options =
  //       QueryOptions(documentNode: gql(Queries.verifyUser()), variables: {
  //     '_id': '$id',
  //   });

  //   final QueryResult result = await Config.client.query(options);

  //   if (result.loading) {
  //     print('Loading...');
  //   }

  //   if (result.hasException) {
  //     print(result.exception.toString());
  //   }

  //   if (!result.hasException) {
  //     final List<dynamic> repositories =
  //         result.data['MemberCollection'] as List<dynamic>;

  //     showUser() {
  //       for (var person in repositories) {
  //         person['name'] = name;
  //         person['surname'] = points;
  //         person['points'] = points;
  //         print('Name: $name');
  //         print('Surname: $surname');
  //         print('Points: $points');
  //       }
  //     }

  //     repositories.isEmpty ? print('User Doesnt Exist!') : showUser();
  //   }
  // }
}
