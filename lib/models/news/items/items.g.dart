// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      image: json['image'] as String,
      contentHtml: json['content_html'] as String,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
      datePublished: json['date_published'] as String,
      dateModified: json['date_modified'] as String);
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'summary': instance.summary,
      'image': instance.image,
      'content_html': instance.contentHtml,
      'author': instance.author?.toJson(),
      'tags': instance.tags,
      'date_published': instance.datePublished,
      'date_modified': instance.dateModified
    };
