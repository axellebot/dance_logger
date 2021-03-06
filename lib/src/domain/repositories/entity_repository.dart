import 'dart:async';

import 'package:dance/domain.dart';

abstract class EntityRepository<T extends BaseEntity> {
  /// Fetch the [T] identified by [id]
  ///
  /// [force] can be used to avoid cache use ([$false] by default)
  ///
  /// Must return an [T]
  FutureOr<T> getById(
    String id, {
    bool force = false,
  });

  /// Delete the [T] identified by [id]
  ///
  /// Don't return anything
  FutureOr<void> deleteById(
    String id,
  );

  /// Fetch [T] list
  ///
  /// [Offset] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [T]
  FutureOr<List<T>> getList({
    required Offset offset, // Pagination

    /// TODO: Add filters
    /// TODO: Add sort
  });

// TODO: Add delete
// TODO: Add create
}
