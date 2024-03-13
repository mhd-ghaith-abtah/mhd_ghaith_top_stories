import 'package:mhd_ghaith_top_stories/core/features/domain/entities/entity.dart';

// ignore_for_file: non_constant_identifier_names
abstract class BaseResponseModel {
  String? status;
  String? copyright;
  String? section;
  String? last_updated;
  int? num_results;

  Map<String, dynamic> toJson() => {};

  Entity toEntity();
}
