import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
// 下面这个文件会由 build_runner 自动生成
import 'injection.config.dart';

/// 全局单例 GetIt 实例
final GetIt getIt = GetIt.instance;

/// 运行此方法即可注册所有标注了 @injectable 的类型
@InjectableInit()
Future<void> configureDependencies() => getIt.init();
