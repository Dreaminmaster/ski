import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/ski_map_widget.dart';
import '../widgets/function_button.dart';
import '../services/storage_service.dart';
import '../constants/app_colors.dart';
import 'ski_settings_screen.dart';
import 'settings_screen.dart';
import 'analytics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  String _selectedLocation = '初级道';
  
  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // 上半部分：滑雪场地图
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    SkiMapWidget(
                      onLocationSelected: (location) {
                        setState(() {
                          _selectedLocation = location;
                        });
                      },
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: _buildStartButton(),
                      ),
                    ),
                  ],
                ),
              ),
              // 下半部分：功能按钮
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FunctionButton(
                        title: '滑雪记录',
                        icon: Icons.history,
                        onPressed: _showRecords,
                      ),
                      FunctionButton(
                        title: '设置',
                        icon: Icons.settings,
                        onPressed: _showSettings,
                      ),
                      FunctionButton(
                        title: '趋势分析',
                        icon: Icons.trending_up,
                        onPressed: _showAnalytics,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 滑动面板
          _buildSlidingPanel(),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return ElevatedButton(
      onPressed: _startSkiing,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        '开始滑雪',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSlidingPanel() {
    return SlideTransition(
      position: _slideAnimation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              _buildPanelHandle(),
              Expanded(
                child: _buildPanelContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanelHandle() {
    return GestureDetector(
      onTap: _togglePanel,
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildPanelContent() {
    return FutureBuilder(
      future: Provider.of<StorageService>(context).getRecords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('暂无滑雪记录'));
        }

        final records = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            return Card(
              child: ListTile(
                leading: Icon(
                  record.equipmentType == 'snowboard' 
                      ? Icons.snowboarding 
                      : Icons.skiing,
                  color: AppColors.primary,
                ),
                title: Text('${record.durationMinutes} 分钟'),
                subtitle: Text(
                  '${record.timestamp.year}-${record.timestamp.month}-${record.timestamp.day}',
                ),
                trailing: Text(record.equipmentType == 'snowboard' ? '单板' : '双板'),
              ),
            );
          },
        );
      },
    );
  }

  void _startSkiing() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SkiSettingsScreen(),
      ),
    );
  }

  void _showRecords() {
    if (_slideController.isCompleted) {
      _slideController.reverse();
    } else {
      _slideController.forward();
    }
  }

  void _showSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _showAnalytics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AnalyticsScreen(),
      ),
    );
  }

  void _togglePanel() {
    if (_slideController.isCompleted) {
      _slideController.reverse();
    } else {
      _slideController.forward();
    }
  }
}