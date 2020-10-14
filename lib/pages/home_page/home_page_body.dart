import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:tinx_frontend/providers/satellite_provider.dart';

Widget NiceRectangle({Widget child, Color color, bool glow = true}) =>
    Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: glow ? [BoxShadow(color: color, blurRadius: 8)] : null,
      ),
      child: child,
    );

Widget FuckingDot({Color color, double size = 8, bool glow = true}) =>
    Container(
      padding: EdgeInsets.all(size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: glow
            ? [BoxShadow(color: color, blurRadius: 8, spreadRadius: 2)]
            : null,
      ),
    );

Widget SatelliteLocationMap(
        {@required LatLng point, MapController mapController}) =>
    AspectRatio(
      aspectRatio: 1.0,
      child: FlutterMap(
        mapController: mapController ?? MapController(),
        options: MapOptions(
          center: point,
          maxZoom: 18.49,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: point,
                builder: (_) => Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    var sat = Provider.of<SatelliteProvider>(context);
    final theme = Theme.of(context);
    final mapController = MapController();

    Widget _valueDataPair(String valueName, String value) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(valueName), Text(value)],
        );

    final _spaceBetweenStuff = 10.0;
    final List<Widget> _tiles = [
      NiceRectangle(
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Server connected', style: theme.textTheme.headline5),
                FuckingDot(
                    color: sat.serverIsConnected ? Colors.green : Colors.red)
              ],
            ),
            SizedBox(height: _spaceBetweenStuff),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Satellite connected', style: theme.textTheme.headline5),
                FuckingDot(
                    color: sat.sat.isConnected ?? false
                        ? Colors.green
                        : Colors.red)
              ],
            ),
          ],
        ),
      ),
      NiceRectangle(
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Text('Satellite status ', style: theme.textTheme.headline4),
            SizedBox(height: _spaceBetweenStuff),
            _valueDataPair('Battery ', '${sat.sat.batteryPercentage} %'),
            SizedBox(height: _spaceBetweenStuff),
            _valueDataPair('CPU Temperature ', '${sat.sat.cpuTemperature} °C'),
            SizedBox(height: _spaceBetweenStuff),
            _valueDataPair(
                'LoRa signal RSSI ', '${sat.sat.loraSignalRssi} dBm'),
          ],
        ),
      ),
      NiceRectangle(
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Text(
              'Satellite location',
              style: theme.textTheme.headline4,
            ),
            SizedBox(height: _spaceBetweenStuff),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // TODO: Make this activate some Intent to opening maps app
              children: [
                Text('Lat/Lng'),
                sat.sat.locationLatLng == null
                    ? Text('Not available')
                    : SelectableText(
                  '${sat.sat.locationLatLng.latitude}\n'
                      '${sat.sat.locationLatLng.longitude}',
                )
              ],
            ),
            _valueDataPair('Height', '${sat.sat.locationHeight} m'),
            SizedBox(height: _spaceBetweenStuff),
            // TODO: Add listener to update the map when location changes
            if (sat.sat.locationLatLng != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SatelliteLocationMap(
                  point: sat.sat.locationLatLng,
                  mapController: mapController,
                ),
              ),
          ],
        ),
      ),
    ];

    return Container(
      padding: EdgeInsets.all(16),
      child: StaggeredGridView.count(
        crossAxisCount:
        (MediaQuery.of(context).size.width / 450).round().clamp(1, 30),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: _tiles,
        staggeredTiles: _tiles.map((e) => StaggeredTile.fit(1)).toList(),
      ),
    );
  }
}
