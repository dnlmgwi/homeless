import 'package:homeless/packages.dart';
part 'news.g.dart';

@JsonSerializable(explicitToJson: true)
class News {

  String version, title, description;

  @JsonKey(name: 'home_page_url')
  String homePageUrl;

  @JsonKey(name: 'feed_url')
  String feedUrl;

  @JsonKey(name: 'user_comment')
  String userComment;

  Author author;

  List<Items> items;

  News({
    this.version,
    this.title,
    this.description,
    this.homePageUrl,
    this.feedUrl,
    this.userComment,
    this.author,
    this.items,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
