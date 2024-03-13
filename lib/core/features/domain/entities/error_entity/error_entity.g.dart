// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorEntity _$ErrorEntityFromJson(Map<String, dynamic> json) => ErrorEntity(
      fault: json['fault'] == null
          ? null
          : FaultModel.fromJson(json['fault'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ErrorEntityToJson(ErrorEntity instance) =>
    <String, dynamic>{
      'fault': instance.fault,
    };

FaultModel _$FaultModelFromJson(Map<String, dynamic> json) => FaultModel(
      faultString: json['faultstring'] as String?,
      faultDetails: json['detail'] == null
          ? null
          : FaultDetailsModel.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FaultModelToJson(FaultModel instance) =>
    <String, dynamic>{
      'faultstring': instance.faultString,
      'detail': instance.faultDetails,
    };

FaultDetailsModel _$FaultDetailsModelFromJson(Map<String, dynamic> json) =>
    FaultDetailsModel(
      errorCode: json['errorcode'] as String,
    );

Map<String, dynamic> _$FaultDetailsModelToJson(FaultDetailsModel instance) =>
    <String, dynamic>{
      'errorcode': instance.errorCode,
    };
