class Offset {
  // TODO: Migrate to Cursor pagination (https://medium.com/swlh/how-to-implement-cursor-pagination-like-a-pro-513140b65f32)

  /// [offset] indicate the offset of the search
  final int offset;

  /// [limit] indicate the elements limits of a result
  final int limit;

  const Offset({
    this.offset = 0,
    this.limit = -1,
  });

  Offset copyWith({
    int? offset,
    int? limit,
  }) {
    return Offset(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }

  @override
  String toString() => '$runtimeType{ '
      'offset: $offset, '
      'limit: $limit'
      ' }';
}

class Sort {
  final String? sortBy;
  final bool sortReversed;

  const Sort({
    this.sortBy,
    this.sortReversed = false,
  });

  Sort copyWith({
    String? sortBy,
    bool? sortReversed,
  }) {
    return Sort(
      sortBy: sortBy ?? this.sortBy,
      sortReversed: sortReversed ?? this.sortReversed,
    );
  }

  @override
  String toString() => '$runtimeType{ '
      'sortBy: $sortBy, '
      'sortReversed: $sortReversed'
      ' }';
}
