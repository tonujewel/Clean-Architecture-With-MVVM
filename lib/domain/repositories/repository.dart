import 'package:clean_architecture_with_mvvm/domain/model/model.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';

abstract class Repository {
 Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
 Future<Either<Failure,Messages>> forgotPassword(ForgotRequst forgotRequst);
 Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);
}
