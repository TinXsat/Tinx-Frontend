import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
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

  Future<bool> _loadData() async {
    print('Refreshing data...');
    final sp = await SharedPreferences.getInstance();
    url = sp.getString(KEYS.API_URL) ?? url;
    print('Server url: $url');

    var cli = http.Client();
    http.Response res;
    res = await cli.get(url + '/satellite');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      sat.isConnected = jsonDecode(res.body)['connected'];
    }

    res = await cli.get(url + '/satellite/battery');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      sat.batteryPercentage = jsonDecode(res.body)['percentage'];
    }

    res = await cli.get(url + '/satellite/cpu/temperature');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      sat.cpuTemperature = jsonDecode(res.body)['celcius'];
    }

    res = await cli.get(url + '/satellite/lora/signal');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      sat.loraSignalRssi = jsonDecode(res.body)['rssi'];
    }

    res = await cli.get(url + '/satellite/location');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      var json = jsonDecode(res.body);
      if (json['latitude'] != null && json['longitude'] != null)
        sat.locationLatLng = LatLng(
          json['latitude'].toDouble(),
          json['longitude'].toDouble(),
        );
      else
        sat.locationLatLng = null;
      sat.locationHeight = json['height'];
    }
    return true;
  }

  NeatPeriodicTaskScheduler scheduler;

  Future<void> _refresh() async {
    bool success = false;
    try {
      success = await _loadData()
          .timeout(Duration(seconds: 3), onTimeout: () => false);
    } catch (e, s) {
      print('Error when connecting to server:');
      print(e);
      print(s);
      success = false;
    }
    print('Refreshing data ${success ? 'successful' : 'failed'}');
    serverIsConnected = success;
    notifyListeners();
  }

  SatelliteProvider() {
    scheduler = NeatPeriodicTaskScheduler(
      name: 'server-ping',
      interval: Duration(milliseconds: 500),
      timeout: Duration(seconds: 10),
      task: _refresh,
      minCycle: Duration(milliseconds: 50),
    );

    scheduler.start();
  }
}
