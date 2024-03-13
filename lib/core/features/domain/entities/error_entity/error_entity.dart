import 'package:json_annotation/json_annotation.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/entity.dart';

part 'error_entity.g.dart';

@JsonSerializable()
class ErrorEntity extends Entity {
  @JsonKey(name: "fault")
  final FaultModel? fault;

  ErrorEntity({this.fault});

  factory ErrorEntity.fromJson(Map<String, dynamic> json) =>
      _$ErrorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorEntityToJson(this);

  @override
  List<Object?> get props => [fault];
}

@JsonSerializable()
class FaultModel {
  @JsonKey(name: "faultstring")
  final String? faultString;
  @JsonKey(name: "detail")
  final FaultDetailsModel? faultDetails;

  FaultModel({
    this.faultString,
    this.faultDetails,
  });

  factory FaultModel.fromJson(Map<String, dynamic> json) =>
      _$FaultModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaultModelToJson(this);
}

@JsonSerializable()
class FaultDetailsModel {
  @JsonKey(name: "errorcode")
  final String errorCode;

  FaultDetailsModel({required this.errorCode});

  factory FaultDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$FaultDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaultDetailsModelToJson(this);
}