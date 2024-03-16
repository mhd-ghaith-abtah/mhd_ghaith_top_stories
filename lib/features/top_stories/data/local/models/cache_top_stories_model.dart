import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';

part 'cache_top_stories_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CacheTopStoriesModel {
  @JsonKey(name: "cacheDate")
  final DateTime cacheDate;
  @JsonKey(name: "section")
  final String section;
  @JsonKey(name: "stories")
  final List<TopStoryModel> stories;

  CacheTopStoriesModel({
    required this.cacheDate,
    required this.section,
    required this.stories,
  });

  factory CacheTopStoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CacheTopStoriesModelFromJson(json);

  factory CacheTopStoriesModel.fromString(String data) =>
      CacheTopStoriesModel.fromJson(json.decode(data));

  Map<String, dynamic> toJson() => _$CacheTopStoriesModelToJson(this);

  @override
  String toString() => json.encode(toJson());
}
