/// Exception thrown when request fails
class RequestException implements Exception {}

/// Exception thrown when backend return errors
class ServerException implements Exception {}

/// Exception thrown when error occurs on client side
class InternalException implements Exception {}

/// Exception thrown when query fails
class DatabaseException implements Exception {}

/// Exception thrown when No Element found
class NotFoundException implements Exception {
  const NotFoundException(this.message);

  final String? message;
}

class ConflictException implements Exception {
  const ConflictException(this.message);

  final String? message;
}

/// Exception thrown when request returns invalid
class ResultException implements Exception {
  const ResultException(this.message);

  final String message;
}

/// Exception thrown when No Client Found
class UnauthorizedException implements Exception {}

/// Exception thrown when No Internet Connection
class NoInternetException implements Exception {}
