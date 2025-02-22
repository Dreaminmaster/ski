import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_settings.dart';
import '../services/storage_service.dart';
import '../constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late UserSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = Provider.of<StorageService>(context, listen: false).getUserSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        children: [
          _buildSwitchTile(
            '音效',
            '滑雪和操作音效',
            _settings.soundEnabled,
            (value) => setState(() {
              _settings = UserSettings(
                soundEnabled: value,
                musicEnabled: _settings.musicEnabled,
                graphicsQuality: _settings.graphicsQuality,
              );
              _saveSettings();
            }),
          ),
          _buildSwitchTile(
            '背景音乐',
            '滑雪背景音乐',
            _settings.musicEnabled,
            (value) => setState(() {
              _settings = UserSettings(
                soundEnabled: _settings.soundEnabled,
                musicEnabled: value,
                graphicsQuality: _settings.graphicsQuality,
              );
              _saveSettings();
            }),
          ),
          _buildQualitySelector(),
          const Divider(),
          _buildAboutTile(),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildQualitySelector() {
    return ListTile(
      title: const Text('画面质量'),
      subtitle: const Text('调整画面效果'),
      trailing: DropdownButton<int>(
        value: _settings.graphicsQuality,
        items: const [
          DropdownMenuItem(value: 1, child: Text('低')),
          DropdownMenuItem(value: 2, child: Text('中')),
          DropdownMenuItem(value: 3, child: Text('高')),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _settings = UserSettings(
                soundEnabled: _settings.soundEnabled,
                musicEnabled: _settings.musicEnabled,
                graphicsQuality: value,
              );
              _saveSettings();
            });
          }
        },
      ),
    );
  }

  Widget _buildAboutTile() {
    return ListTile(
      title: const Text('关于'),
      subtitle: const Text('滑雪番茄钟 v1.0.0'),
      onTap: () => showAboutDialog(
        context: context,
        applicationName: '滑雪番茄钟',
        applicationVersion: '1.0.0',
        applicationIcon: Image.asset(
          'assets/images/app_icon.png',
          width: 50,
          height: 50,
        ),
        children: const [
          Text('一款结合滑雪元素的番茄钟应用'),
        ],
      ),
    );
  }

  Future<void> _saveSettings() async {
    await Provider.of<StorageService>(context, listen: false)
        .saveUserSettings(_settings);
  }
}