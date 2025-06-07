# task_app

A new Flutter project.

## 文件说明

lib/main.dart - 应用入口。
analysis_options.yaml - 此文件决定了 Flutter 在分析代码时的严格程度。
pubspec.yaml - 文件指定与您的应用相关的基本信息，例如其当前版本、依赖项以及其随附的资源。

## 命令

清理项目构建缓存和临时文件：
flutter clean

获取并安装 pubspec.yaml 中声明的所有 Dart/Flutter 依赖包：
flutter pub get

使用 build_runner 工具生成代码（如 json 序列化、依赖注入等），并自动删除有冲突的旧文件：
自动化生成代码文件，常用于使用如 json_serializable、injectable 等库。
flutter pub run build_runner build --delete-conflicting-outputs

通过 adb 工具将指定的 APK 文件安装到已连接的 Android 设备或模拟器上：
手动安装 APK 到设备，适用于调试或测试。
adb install build\app\outputs\flutter-apk\app-debug.apk

将最近一次构建生成的 APK 或 App Bundle 安装到已连接的设备上：
快速部署应用到设备，无需手动输入 adb 命令。
flutter install

## 构建

发布模式： 
flutter build apk（胖 APK）
flutter build apk --split-per-abi
flutter build apk --release --split-per-abi --shrink --target-platform android-arm64,android-x86_64

性能分析模式： 
flutter build apk --profile --split-per-abi --shrink --target-platform android-arm64,android-x86_64

调试模式： 
flutter build apk --debug
flutter build apk --debug --target-platform android-arm64,android-x86
flutter build apk --debug --target-platform android-arm,android-arm64,android-x86
flutter run（包含当前连接设备所需的架构支持）

## 资源

-[实验室：写你的第一个Flutter应用程序]（https://docs.flutter.dev/get-started/codelab）
-[食谱：有用的颤振样本]（https://docs.flutter.dev/cookbook）

有关开始进行Flutter开发的帮助，请查看 [在线文档](https://docs.flutter.dev/)，提供教程，示例，移动开发指南，以及完整的API参考。