# ski
ski是一款创新地将滑雪元素与番茄钟时间管理相结合的应用程序。用户通过设定滑雪时间，模拟滑雪过程，在专注完成任务的同时，享受滑雪的乐趣，旨在提高用户的时间管理效率和使用趣味性。

二、功能架构

1. 主页面：上半部分为滑雪场地图及开始按钮，下半部分为滑雪记录、设置、趋势分析三个功能入口。

2. 滑雪设定页面：设定滑雪时间（番茄钟时间）。

3. 滑雪装备选择页面：选择单板或双板滑雪装备。

4. 滑雪准备提示页面：依次显示“佩戴护具”“正在空降着陆”“开始滑行”提示。

5. 滑雪模拟页面：第一人称视角滑雪模拟，包含各种场景元素、声音效果和滑雪操作。

6. 滑雪结束页面：展示滑雪结束动画，显示滑雪时间，提供返回主页面操作。

三、详细功能说明

1. 主页面

• 滑雪场地图：展示不同滑雪场地点，用户可点击选择。

• 开始滑雪按钮：位于地图中间下方，点击后进入滑雪设定页面。

• 滑雪记录：点击后上移占满屏幕2/3，展示用户的滑雪历史记录，包括滑雪时间、使用装备等信息。

• 设置：点击后上移占满屏幕2/3，提供音效开关、画面质量调整、账户设置等功能。

• 趋势分析：点击后上移占满屏幕2/3，分析用户的时间使用情况、滑雪效率等学习情况数据。

2. 滑雪设定页面

• 时间设定：类似闹钟设定，用户可自由设定滑雪时间（番茄钟时间），时间范围为10分钟至120分钟。

3. 滑雪装备选择页面

• 单板选择：点击后进入单板滑雪模拟，单板滑雪具备换向（正常、随机换向）和跳跃功能。

• 双板选择：点击后进入双板滑雪模拟，双板滑雪仅具备跳跃功能。

4. 滑雪准备提示页面

• 依次显示“佩戴护具”“正在空降着陆”“开始滑行”三组词：以动画形式依次跳出，提示用户滑雪准备过程。

5. 滑雪模拟页面

• 第一人称视角：用户视角为第一人称，仅显示一半滑雪板，道路在中间，两边为随机出现的雪、枯木、石头等场景元素。

• 路面变动：路面随机左右轻微变动，增加滑雪真实感。

• 声音效果：遇到石头、树木等物体时，播放对应声音；正常滑雪时，循环播放滑雪声音；遇到障碍物或斜坡跳跃时，播放对应声音。

• 滑雪操作：单板滑雪可进行换向和跳跃操作，有对应声音和动画效果；双板滑雪可进行跳跃操作，有对应声音和动画效果。滑雪过程中，滑雪板会时不时轻微左右摇晃。

• 时间显示和暂停：左上角显示倒计时时间，提供暂停按钮，暂停时可选择继续滑雪或结束滑雪。

6. 滑雪结束页面

• 结束动画：滑雪板慢慢滑到滑雪小木屋的动画，与滑雪模拟页面无缝衔接。

• 时间显示：右上角时间慢慢移到中间放大显示，其他画面变暗。

• 返回主页面：点击屏幕上的“完成滑雪”按钮，返回主页面。

四、特殊说明

1. 音效和动画：所有音效和动画需与滑雪场景和操作紧密结合，增强用户体验。

2. 数据存储：滑雪记录和趋势分析数据需进行本地存储，并支持云端同步。

3. 兼容性：确保App在不同品牌和型号的手机上正常运行，画面和功能显示正常。


我来指导你如何运行这个 Flutter 项目：

1. 首先，创建一个新的 Flutter 项目：
```bash
flutter create ski_pomodoro
cd ski_pomodoro
```

2. 替换 `pubspec.yaml` 文件内容：
```yaml
name: ski_pomodoro
description: 滑雪番茄钟应用程序

publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  shared_preferences: ^2.2.0
  just_audio: ^0.9.34
  fl_chart: ^0.63.0
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
  
  assets:
    - assets/audio/
    - assets/images/
```

3. 创建必要的资源目录：
```bash
mkdir -p assets/audio assets/images
```

4. 准备必要的图片资源，放入 `assets/images/` 目录：
- ski_map.png（滑雪场地图）
- snowboard.png（单板图标）
- ski.png（双板图标）
- app_icon.png（应用图标）

5. 准备音频资源，放入 `assets/audio/` 目录：
- ski.mp3（滑雪声音）
- jump.mp3（跳跃声音）
- collision.mp3（碰撞声音）

6. 按照之前提供的代码结构创建相应的目录和文件：
```bash
mkdir -p lib/constants lib/models lib/screens lib/services lib/utils lib/widgets
```

7. 将所有代码文件放入对应目录：
```
lib/
├── constants/
│   ├── app_colors.dart
│   └── app_constants.dart
├── models/
│   ├── ski_record.dart
│   └── user_settings.dart
├── screens/
│   ├── home_screen.dart
│   ├── ski_settings_screen.dart
│   ├── ski_equipment_screen.dart
│   ├── ski_preparation_screen.dart
│   ├── ski_simulation_screen.dart
│   ├── ski_completion_screen.dart
│   ├── settings_screen.dart
│   └── analytics_screen.dart
├── services/
│   ├── storage_service.dart
│   └── audio_service.dart
├── widgets/
│   ├── ski_map_widget.dart
│   ├── function_button.dart
│   └── ski_animation_widget.dart
├── utils/
│   └── helpers.dart
└── main.dart
```

8. 安装依赖：
```bash
flutter pub get
```

9. 运行项目：
```bash
flutter run
```

如果你使用 VS Code 或 Android Studio：
1. 打开项目文件夹
2. 确保已连接模拟器或实机
3. 按 F5（VS Code）或点击运行按钮（Android Studio）

常见问题解决：

1. 如果遇到资源文件找不到的错误：
- 确保 `pubspec.yaml` 中的资源路径正确
- 运行 `flutter clean` 然后 `flutter pub get`

2. 如果遇到依赖版本冲突：
- 尝试运行 `flutter pub upgrade`
- 检查 `pubspec.yaml` 中的依赖版本

3. 如果遇到编译错误：
- 检查 Dart SDK 版本是否符合要求
- 确保所有代码文件都正确放置

4. 如果需要调试：
- 使用 `print` 语句或 debugger
- 查看 Flutter DevTools

5. 如果需要热重载：
- 保存文件或按 r 键
- 如果热重载失败，尝试热重启（按 R 键）

要测试应用：
1. 先创建一个滑雪记录
2. 测试各个功能按钮
3. 检查动画效果
4. 验证数据存储

要运行 Flutter 项目，你需要：
安装 Flutter SDK
安装对应平台的开发工具：
iOS: Xcode
Android: Android Studio
运行 flutter run
Flutter 会自动根据你的目标平台（iOS/Android）生成对应的原生代码。这就是为什么说 Flutter 是跨平台的，但又不能直接用于小程序开发。