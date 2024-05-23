abstract class UseCaseFuture<Type, Params> {
  Future<Type> call({Params? params});
}

abstract class UseCaseFutureSafe<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCase<Type, Params> {
  Type call({Params? params});
}
