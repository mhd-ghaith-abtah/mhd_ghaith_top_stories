// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_top_stories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CacheTopStoriesModel _$CacheTopStoriesModelFromJson(
        Map<String, dynamic> json) =>
    CacheTopStoriesModel(
      cacheDate: DateTime.parse(json['cacheDate'] as String),
      section: json['section'] as String,
      stories: (json['stories'] as List<dynamic>)
          .map((e) => TopStoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CacheTopStoriesModelToJson(
        CacheTopStoriesModel instance) =>
    <String, dynamic>{
      'cacheDate': instance.cacheDate.toIso8601String(),
      'section': instance.section,
      'stories': instance.stories.map((e) => e.toJson()).toList(),
    };
