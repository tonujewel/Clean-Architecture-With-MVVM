import '../responses/response.dart';

const CACHE_RESTAURANT_KEY = 'CACHE_RESTAURANT_KEY';

abstract class LocalDataSource {
  Future<RestaurantDataResponse> getRestaurantData();
  Future<void> saveRestaurantDataToCache(
      RestaurantDataResponse restaurantDataResponse);
}

class LocalDataSourceImplementer implements LocalDataSource {
  // run time cache
  Map<String, CacheItem> cacheMap = Map();
  @override
  Future<RestaurantDataResponse> getRestaurantData() {
    // TODO: implement getRestaurantData
    throw UnimplementedError();
  }

  @override
  Future<void> saveRestaurantDataToCache(
      RestaurantDataResponse restaurantDataResponse) async {
    cacheMap[CACHE_RESTAURANT_KEY] = CacheItem(restaurantDataResponse);
  }
}

class CacheItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CacheItem(this.data);
}
