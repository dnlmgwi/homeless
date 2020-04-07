class Person {
  Person(this._id, this.name, this.lastName, this.points);

  final String _id;
  final String name;
  final String lastName;
  final String points;

  getId() => this._id;

  getName() => this.name;

  getLastName() => this.lastName;

  getPoints() => this.points;
}
