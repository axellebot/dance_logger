class AppError extends Error {}

class NotImplementedYetError extends AppError {
  final String? message;

  NotImplementedYetError([this.message]);

  @override
  String toString() => message != null
      ? 'NotImplementedYetError: $message'
      : 'NotImplementedYetError';
}

class NotSupportedError extends AppError {
  final String? message;

  NotSupportedError({this.message});

  @override
  String toString() =>
      message != null ? 'Not supported : $message' : 'Not supported';
}

class DataNotCreatedError extends AppError {
  final String? name;

  DataNotCreatedError(this.name);

  @override
  String toString() => '$name not created';
}

class DataNotFoundError extends AppError {
  final String? name;

  DataNotFoundError(this.name);

  @override
  String toString() => '$name not found';
}

class DataNotUpdatedError extends AppError {
  final String? name;

  DataNotUpdatedError(this.name);

  @override
  String toString() => '$name not updated';
}

class DataNotDeletedError extends AppError {
  final String? name;

  DataNotDeletedError(this.name);

  @override
  String toString() => '$name not deleted';
}
