// ignore_for_file: non_constant_identifier_names
abstract class BaseResponseModel {
  String? status;
  String? copyright;
  String? section;
  String? last_updated;
  int? num_results;

  Map<String, dynamic> toJson() => {};
}
