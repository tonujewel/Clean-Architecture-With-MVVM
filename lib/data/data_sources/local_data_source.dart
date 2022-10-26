import 'package:clean_architecture_with_mvvm/data/network/error_handler.dart';

import '../responses/response.dart';

const CACHE_RESTAURANT_KEY = 'CACHE_RESTAURANT_KEY';
const CACHE_RESTAURANT_INTERVAL = 60*1000;

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
    CacheItem? cacheItem = cacheMap[CACHE_RESTAURANT_KEY];

    if (cacheItem != null && cacheItem.isValid(CACHE_RESTAURANT_INTERVAL)) {
      return cacheItem.data;
      // return response
    } else {
      // return error that cache is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
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

extension CacheItemExtension on CacheItem {
  bool isValid(int expirationTime) {
    int currentTimeInMili = DateTime.now().millisecondsSinceEpoch;

    bool isCacheValid = currentTimeInMili - expirationTime < cacheTime;

    return isCacheValid;
  }
}
