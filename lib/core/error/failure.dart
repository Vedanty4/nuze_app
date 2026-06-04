abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class OfflineFailure extends Failure {
  const OfflineFailure() : super("No Internet Connectioin");
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class ConstraintFailure extends Failure {
  const ConstraintFailure(super.message);
}
