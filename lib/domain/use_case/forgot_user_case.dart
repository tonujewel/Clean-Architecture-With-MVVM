import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/domain/model/model.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repository.dart';

class ForgotUseCase extends BaseUseCase<ForgotUseCaseInput, Messages> {
  final Repository _repository;

  ForgotUseCase(this._repository);
  @override
  Future<Either<Failure, Messages>> execute(ForgotUseCaseInput input) async {
    return await _repository.forgotPassword(ForgotRequst(input.email));
  }
}

class ForgotUseCaseInput {
  final String email;

  ForgotUseCaseInput(this.email);
}
