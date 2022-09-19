import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/data/responses/response.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase
    extends BaseUseCase<LoginUseCaseInput, AuthenticationResponse> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, AuthenticationResponse>> execute(
      LoginUseCaseInput input) {
    _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  final String email;
  final String password;

  LoginUseCaseInput(this.email, this.password);
}
