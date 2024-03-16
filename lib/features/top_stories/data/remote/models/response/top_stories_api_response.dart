// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/response/base_response_model.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/entities/top_stories_entity.dart';

part 'top_stories_api_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TopStoriesResponse extends BaseResponseModel {
  @JsonKey(name: "results")
  final List<TopStoryModel>? result;

  const TopStoriesResponse(
    super.status,
    super.copyright,
    super.section,
    super.last_updated,
    super.num_results, {
    required this.result,
  });

  factory TopStoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$TopStoriesResponseFromJson(json);

  factory TopStoriesResponse.fromString(String data) =>
      TopStoriesResponse.fromJson(json.decode(data));

  @override
  Map<String, dynamic> toJson() => _$TopStoriesResponseToJson(this);

  @override
  String toString() => json.encode(toJson());

  @override
  TopStoriesEntity toEntity() => TopStoriesEntity(result: result);

  @override
  List<Object?> get props => [result];
}

@JsonSerializable(explicitToJson: true)
class TopStoryModel extends Equatable {
  @JsonKey(name: "section")
  final String? section;
  @JsonKey(name: "subsection")
  final String? subsection;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "abstract")
  final String? abstract;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "byline")
  final String? byline;
  @JsonKey(name: "item_type")
  final String? itemType;
  @JsonKey(name: "updated_date")
  final DateTime? updatedDate;
  @JsonKey(name: "created_date")
  final DateTime? createdDate;
  @JsonKey(name: "published_date")
  final DateTime? publishedDate;
  @JsonKey(name: "multimedia")
  final List<MultiMedia>? multimedia;

  const TopStoryModel({
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
    this.multimedia,
  });

  factory TopStoryModel.fromJson(Map<String, dynamic> json) =>
      _$TopStoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopStoryModelToJson(this);

  @override
  List<Object?> get props => [
        section,
        subsection,
        title,
        abstract,
        url,
        byline,
        itemType,
        updatedDate,
        createdDate,
        publishedDate,
        multimedia,
      ];
}

@JsonSerializable()
class MultiMedia extends Equatable {
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "width")
  final int? width;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "caption")
  final String? caption;

  const MultiMedia({
    this.url,
    this.height,
    this.width,
    this.type,
    this.caption,
  });

  factory MultiMedia.fromJson(Map<String, dynamic> json) =>
      _$MultiMediaFromJson(json);

  Map<String, dynamic> toJson() => _$MultiMediaToJson(this);

  @override
  List<Object?> get props => [url, height, width, type, caption];
}
