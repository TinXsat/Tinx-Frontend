import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinx_frontend/shared_prefs.dart';

class _Satellite {
  bool isConnected = false;
  int batteryPercentage;
  double cpuTemperature;
  int loraSignalRssi;
  LatLng locationLatLng;
  double locationHeight;
}

class SatelliteProvider with ChangeNotifier {
  String url = DEFAULT.API_URL;
  final sat = _Satellite();
  bool serverIsConnected = false;

  Future<bool> refreshData() async {
    final sp = await SharedPreferences.getInstance();
    url = sp.getString(KEYS.API_URL) ?? url;
    http.Response res;

    res = await http.get(url + '/satellite');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      sat.isConnected = jsonDecode(res.body)['connected'];
    }

    res = await http.get(url + '/satellite/battery');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      sat.batteryPercentage = jsonDecode(res.body)['percentage'];
    }

    res = await http.get(url + '/satellite/cpu/temperature');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      sat.cpuTemperature = jsonDecode(res.body)['celcius'];
    }

    res = await http.get(url + '/satellite/lora/signal');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      sat.loraSignalRssi = jsonDecode(res.body)['rssi'];
    }

    res = await http.get(url + '/satellite/location');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      var json = jsonDecode(res.body);
      sat.locationLatLng = LatLng(json['latitude'], json['longitude']);
      sat.locationHeight = json['height'];
    }
    notifyListeners();

    return true;
  }
}
