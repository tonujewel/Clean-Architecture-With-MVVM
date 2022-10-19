import 'package:clean_architecture_with_mvvm/app/functions.dart';
import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/domain/model/model.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.register(RegisterRequest(
      input.firstName,
      input.lastName,
      input.email,
      input.password,
      deviceInfo.identifier,
    ));
  }
}

class RegisterUseCaseInput {
  String firstName;
  String lastName;
  String email;
  String password;
  String imei;
  RegisterUseCaseInput(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.imei,
  );
}
