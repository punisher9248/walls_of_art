import 'package:freezed_annotation/freezed_annotation.dart';
import 'converters.dart';

part 'pagination.freezed.dart';
part 'pagination.g.dart';

@freezed
class Pagination with _$Pagination {
  const Pagination._();

  const factory Pagination({
    @StringToIntConverter() required int page,
    @StringToIntConverter() required int limit,
    @StringToIntConverter() required int total,
    @StringToIntConverter() required int totalPages,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  bool get hasNextPage => page < totalPages;
  bool get hasPreviousPage => page > 1;
  int get nextPage => page + 1;
  int get previousPage => page - 1;
}
