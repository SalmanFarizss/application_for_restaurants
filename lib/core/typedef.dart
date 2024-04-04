import 'package:fpdart/fpdart.dart';


class Failure{
  final String failure;
  Failure({required this.failure});
}

typedef FutureEither<T> =Future< Either<Failure,T>>;
typedef FutureVoid = Future<Either<Failure,void>>;
