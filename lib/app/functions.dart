import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "unknown";
  String identifier = "unknown";
  String version = "unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // android info
      var build = await deviceInfoPlugin.androidInfo;
      name = "${build.brand} ${build.model}";
      identifier = "${build.id}";
      version = "${build.version.codename}";
    }

    if (Platform.isIOS) {
      // ios info
      var build = await deviceInfoPlugin.iosInfo;
      name = "${build.name} ${build.model}";
      identifier = "${build.identifierForVendor}";
      version = "${build.systemVersion}";
    }
  } on PlatformException {
    // return default data
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}
