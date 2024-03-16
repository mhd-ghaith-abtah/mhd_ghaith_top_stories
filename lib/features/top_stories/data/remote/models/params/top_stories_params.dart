import 'package:json_annotation/json_annotation.dart';
import 'package:mhd_ghaith_top_stories/app/app_configurations/app_configurations.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';
import 'package:mhd_ghaith_top_stories/core/utils/extensions.dart';

part 'top_stories_params.g.dart';

class TopStoriesParams extends ParamsModel<TopStoriesParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.GET;

  @override
  String? get url => '/${body?.section!.getAPIFormattedString()}.json';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const TopStoriesParams({super.body})
      : super(baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [body];
}

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
class TopStoriesParamsBody extends BaseBodyModel {
  @JsonKey(name: "api-key")
  final String apiKey;
  final Section? section;

  TopStoriesParamsBody({
    required this.apiKey,
    this.section,
  });

  factory TopStoriesParamsBody.fromJson(Map<String, dynamic> json) =>
      _$TopStoriesParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TopStoriesParamsBodyToJson(this);

  @override
  List<Object?> get props => [apiKey, section];
}
