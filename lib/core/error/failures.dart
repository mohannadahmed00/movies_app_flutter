import 'package:equatable/equatable.dart';

class Failures extends Equatable {
  final String message;

  const Failures(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}

class ServerFailures extends Failures {
  const ServerFailures(super.message);
}

class CachedFailures extends Failures {
  const CachedFailures(super.message);
}
