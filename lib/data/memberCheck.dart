class QueryMember {
  String getUser({String d}) {
    return """query MemberCollection {
  MemberCollection(_id: $id) {
    name
    surname
    surname
    points
  }
}""";
  }
}
