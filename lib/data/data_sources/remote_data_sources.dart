import 'package:clean_architecture_with_mvvm/data/network/app_api.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/data/responses/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> reginster(RegisterRequest registerRequest);
  Future<BaseResponse> forgotPassword(ForgotRequst forgotRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<BaseResponse> forgotPassword(ForgotRequst forgotRequest) async {
    return await _appServiceClient.forgotPassword(forgotRequest.email);
  }

  @override
  Future<AuthenticationResponse> reginster(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.firstName,
        registerRequest.lastName,
        registerRequest.email,
        registerRequest.password);
  }
}
