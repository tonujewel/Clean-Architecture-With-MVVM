import 'package:clean_architecture_with_mvvm/app/app_prefs.dart';
import 'package:clean_architecture_with_mvvm/data/data_sources/remote_data_sources.dart';
import 'package:clean_architecture_with_mvvm/data/network/app_api.dart';
import 'package:clean_architecture_with_mvvm/data/network/dio_factory.dart';
import 'package:clean_architecture_with_mvvm/data/network/network_info.dart';
import 'package:clean_architecture_with_mvvm/data/repository/repository_implementer.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/forgot_user_case.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/login_use_case.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/register_use_case.dart';
import 'package:clean_architecture_with_mvvm/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/login/login_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/register/register_view_model.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharePreferences = await SharedPreferences.getInstance();

  // shared preference instance
  instance.registerLazySingleton<SharedPreferences>(() => sharePreferences);

  // App Preferences instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // Network info instance

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(DataConnectionChecker()));

  // Dio facroty instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // App service client instance
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

// login module
initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

// forgot module
initForgotModule() {
  if (!GetIt.I.isRegistered<ForgotUseCase>()) {
    instance.registerFactory<ForgotUseCase>(() => ForgotUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}

// forgot module
initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
  }
}
