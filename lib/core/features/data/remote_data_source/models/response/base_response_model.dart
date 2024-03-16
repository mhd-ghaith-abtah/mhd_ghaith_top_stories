// ignore_for_file: non_constant_identifier_names
import 'package:equatable/equatable.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/entity.dart';

abstract class BaseResponseModel extends Equatable{
  final String? status;
  final String? copyright;
  final String? section;
  final String? last_updated;
  final int? num_results;

  const BaseResponseModel(this.status, this.copyright, this.section, this.last_updated, this.num_results);

  Map<String, dynamic> toJson() => {};

  Entity toEntity();
}
