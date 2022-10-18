import 'package:clean_architecture_with_mvvm/app/constant.dart';
import 'package:clean_architecture_with_mvvm/data/responses/response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  @POST("authentication/forget-password")
  Future<BaseResponse> forgotPassword(@Field("email") String email);

// TODO : CHANGE URL
  @POST("register")
  Future<AuthenticationResponse> register(
    @Field("first_name") String firstName,
    @Field("last_name") String lastName,
    @Field("email") String email,
    @Field("password") String password,
  );
}
