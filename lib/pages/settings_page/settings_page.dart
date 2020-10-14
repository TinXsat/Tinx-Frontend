import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';
import 'package:tinx_frontend/shared_prefs.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: 'Settings',
      children: [
        TextFieldModalSettingsTile(
          title: 'API server URL',
          settingKey: KEYS.API_URL,
          defaultValue: DEFAULT.API_URL,
          icon: Icon(Mdi.serverNetwork),
        ),
      ],
    );
  }
}
