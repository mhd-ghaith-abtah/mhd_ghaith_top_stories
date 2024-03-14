import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/response/base_response_model.dart';

part 'top_stories_api_response.g.dart';

@JsonSerializable()
class TopStoriesResponse extends BaseResponseModel {
  @JsonKey(name: "results")
  List<TopStoryModel>? result;

  TopStoriesResponse({required this.result});

  factory TopStoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$TopStoriesResponseFromJson(json);

  factory TopStoriesResponse.fromString(String data) =>
      TopStoriesResponse.fromJson(json.decode(data));

  @override
  Map<String, dynamic> toJson() => _$TopStoriesResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}

@JsonSerializable()
class TopStoryModel {
  @JsonKey(name: "section")
  String? section;
  @JsonKey(name: "subsection")
  String? subsection;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "abstract")
  String? abstract;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "byline")
  String? byline;
  @JsonKey(name: "item_type")
  String? itemType;
  @JsonKey(name: "updated_date")
  DateTime? updatedDate;
  @JsonKey(name: "created_date")
  DateTime? createdDate;
  @JsonKey(name: "published_date")
  DateTime? publishedDate;
  @JsonKey(name: "multimedia")
  List<MultiMedia>? multimedia;

  TopStoryModel({
    this.section,
    this.subsection,
    this.title,
    this.abstract,
    this.url,
    this.byline,
    this.itemType,
    this.updatedDate,
    this.createdDate,
    this.publishedDate,
  });

  factory TopStoryModel.fromJson(Map<String, dynamic> json) =>
      _$TopStoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopStoryModelToJson(this);
}

@JsonSerializable()
class MultiMedia {
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "height")
  int? height;
  @JsonKey(name: "width")
  int? width;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "caption")
  String? caption;

  MultiMedia({
    this.url,
    this.height,
    this.width,
    this.type,
    this.caption,
  });

  factory MultiMedia.fromJson(Map<String, dynamic> json) =>
      _$MultiMediaFromJson(json);

  Map<String, dynamic> toJson() => _$MultiMediaToJson(this);
}
