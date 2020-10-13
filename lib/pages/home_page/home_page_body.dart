import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // PLACEHOLDER VALUES
    // Replace these with stuff from Provider or something
    var _serverConnected = true;
    var _satelliteConnected = false;
    var _satelliteBatteryPercent = 65;
    var _satelliteCpuTemp = 40;
    var _satelliteLoRaRssi = -90;
    var _satelliteLat = 49.88345;
    var _satelliteLng = 19.49253;

    Widget _valueDataPair(String valueName, String value) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(valueName), Text(value)],
        );

    final List<Widget> _tiles = [
      NiceRectangle(
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Server connected', style: theme.textTheme.headline5),
                FuckingDot(color: _serverConnected ? Colors.green : Colors.red)
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Satellite connected', style: theme.textTheme.headline5),
                FuckingDot(
                    color: _satelliteConnected ? Colors.green : Colors.red)
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
            _valueDataPair('Battery ', '$_satelliteBatteryPercent %'),
            _valueDataPair('CPU Temperature ', '$_satelliteCpuTemp °C'),
            _valueDataPair('LoRa signal RSSI ', '$_satelliteLoRaRssi dBm'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // TODO: Make this activate some Intent to opening maps app
              children: [
                Text('Lat/Lng'),
                SelectableText('$_satelliteLat\n$_satelliteLng')
              ],
            ),
          ],
        ),
      )
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
