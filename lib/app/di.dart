import 'package:clean_architecture_with_mvvm/app/app_prefs.dart';
import 'package:clean_architecture_with_mvvm/data/data_sources/remote_data_sources.dart';
import 'package:clean_architecture_with_mvvm/data/network/app_api.dart';
import 'package:clean_architecture_with_mvvm/data/network/dio_factory.dart';
import 'package:clean_architecture_with_mvvm/data/network/network_info.dart';
import 'package:clean_architecture_with_mvvm/data/repository/repository_impl.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/forgot_user_case.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/login_use_case.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/register_use_case.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/restaurant_usecase.dart';
import 'package:clean_architecture_with_mvvm/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/login/login_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/register/register_view_model.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data_sources/local_data_source.dart';
import '../domain/use_case/restaurant_detail_use_case.dart';
import '../presentation/main/home/home_view_model.dart';
import '../presentation/store_details/store_details_view_model.dart';

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

  // local data source
  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementer());

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(),instance()));
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
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

// forgot module
initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}
 
// home modlue
initHomeModule() {
  if (!GetIt.I.isRegistered<RestaurantUseCase>()) {
    instance.registerFactory<RestaurantUseCase>(
        () => RestaurantUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

// Restaurant details
initRestaurantDetailsModule() {
  if (!GetIt.I.isRegistered<RestaurantDetailUseCase>()) {
    instance.registerFactory<RestaurantDetailUseCase>(
        () => RestaurantDetailUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(() => StoreDetailsViewModel(instance()));
  }
}

resetModules() {
  instance.reset(dispose: false);
  initAppModule();
  initHomeModule();
  initLoginModule();
  initRegisterModule();
  initForgotModule();
  initRestaurantDetailsModule();
}

