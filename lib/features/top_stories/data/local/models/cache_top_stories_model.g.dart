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
      stories:
          TopStoriesResponse.fromJson(json['stories'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CacheTopStoriesModelToJson(
        CacheTopStoriesModel instance) =>
    <String, dynamic>{
      'cacheDate': instance.cacheDate.toIso8601String(),
      'section': instance.section,
      'stories': instance.stories.toJson(),
    };