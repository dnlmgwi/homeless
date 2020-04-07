// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
      version: json['version'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      homePageUrl: json['home_page_url'] as String,
      feedUrl: json['feed_url'] as String,
      userComment: json['user_comment'] as String,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : Items.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'version': instance.version,
      'title': instance.title,
      'description': instance.description,
      'home_page_url': instance.homePageUrl,
      'feed_url': instance.feedUrl,
      'user_comment': instance.userComment,
      'author': instance.author?.toJson(),
      'items': instance.items?.map((e) => e?.toJson())?.toList()
    };
