// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sqflite/sqflite.dart' as _i779;
import 'package:task_app/application/usecases/transcribe_and_create_task_usecase.dart'
    as _i149;
import 'package:task_app/core/di/database_module.dart' as _i574;
import 'package:task_app/data/repositories/local_task_repository.dart' as _i779;
import 'package:task_app/domain/services/i_task_repository.dart' as _i67;
import 'package:task_app/domain/services/i_transcription_engine.dart' as _i662;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final databaseModule = _$DatabaseModule();
    await gh.factoryAsync<_i779.Database>(
      () => databaseModule.database,
      instanceName: 'AppDatabase',
      preResolve: true,
    );
    gh.lazySingleton<_i67.ITaskRepository>(() => _i779.LocalTaskRepository(
        gh<_i779.Database>(instanceName: 'AppDatabase')));
    gh.factory<_i149.TranscribeAndCreateTaskUseCase>(
        () => _i149.TranscribeAndCreateTaskUseCase(
              gh<_i662.ITranscriptionEngine>(),
              gh<_i67.ITaskRepository>(),
            ));
    return this;
  }
}

class _$DatabaseModule extends _i574.DatabaseModule {}
