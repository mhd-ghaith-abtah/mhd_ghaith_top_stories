// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_stories_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopStoriesResponse _$TopStoriesResponseFromJson(Map<String, dynamic> json) =>
    TopStoriesResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['section'] as String?,
      json['last_updated'] as String?,
      json['num_results'] as int?,
      result: (json['results'] as List<dynamic>?)
          ?.map((e) => TopStoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopStoriesResponseToJson(TopStoriesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'section': instance.section,
      'last_updated': instance.last_updated,
      'num_results': instance.num_results,
      'results': instance.result?.map((e) => e.toJson()).toList(),
    };

TopStoryModel _$TopStoryModelFromJson(Map<String, dynamic> json) =>
    TopStoryModel(
      section: json['section'] as String?,
      subsection: json['subsection'] as String?,
      title: json['title'] as String?,
      abstract: json['abstract'] as String?,
      url: json['url'] as String?,
      byline: json['byline'] as String?,
      itemType: json['item_type'] as String?,
      updatedDate: json['updated_date'] == null
          ? null
          : DateTime.parse(json['updated_date'] as String),
      createdDate: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      publishedDate: json['published_date'] == null
          ? null
          : DateTime.parse(json['published_date'] as String),
      multimedia: (json['multimedia'] as List<dynamic>?)
          ?.map((e) => MultiMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopStoryModelToJson(TopStoryModel instance) =>
    <String, dynamic>{
      'section': instance.section,
      'subsection': instance.subsection,
      'title': instance.title,
      'abstract': instance.abstract,
      'url': instance.url,
      'byline': instance.byline,
      'item_type': instance.itemType,
      'updated_date': instance.updatedDate?.toIso8601String(),
      'created_date': instance.createdDate?.toIso8601String(),
      'published_date': instance.publishedDate?.toIso8601String(),
      'multimedia': instance.multimedia?.map((e) => e.toJson()).toList(),
    };

MultiMedia _$MultiMediaFromJson(Map<String, dynamic> json) => MultiMedia(
      url: json['url'] as String?,
      height: json['height'] as int?,
      width: json['width'] as int?,
      type: json['type'] as String?,
      caption: json['caption'] as String?,
    );

Map<String, dynamic> _$MultiMediaToJson(MultiMedia instance) =>
    <String, dynamic>{
      'url': instance.url,
      'height': instance.height,
      'width': instance.width,
      'type': instance.type,
      'caption': instance.caption,
    };
