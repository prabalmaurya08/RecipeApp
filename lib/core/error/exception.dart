// core/error/exceptions.dart

// Exceptions (Used in the Data Layer)
import 'package:equatable/equatable.dart';

class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'An unexpected server error occurred.']);

  @override
  String toString() {
    return 'ServerException: $message';
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'A network error occurred.']);

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'A cache error occurred.']);

  @override
  String toString() {
    return 'CacheException: $message';
  }
}

class InvalidInputException implements Exception {
  final String message;

  InvalidInputException([this.message = 'Invalid input provided.']);

  @override
  String toString() {
    return 'InvalidInputException: $message';
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException([this.message = 'Authentication failed.']);

  @override
  String toString() {
    return 'AuthenticationException: $message';
  }
}

class PermissionException implements Exception {
  final String message;

  PermissionException([this.message = 'Permission denied.']);

  @override
  String toString() {
    return 'PermissionException: $message';
  }
}

class GeneralException implements Exception {
  final String message;

  GeneralException([this.message = 'An unexpected error occurred.']);

  @override
  String toString() {
    return 'GeneralException: $message';
  }
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException([this.message = 'A database error occurred.']);

  @override
  String toString() {
    return 'DatabaseException: $message';
  }
}

// core/error/failures.dart

// Failures (Used in the Domain Layer)

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(String message) : super(message);
}

class GeneralFailure extends Failure {
  const GeneralFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

// Add more custom failure classes as needed for your application.
