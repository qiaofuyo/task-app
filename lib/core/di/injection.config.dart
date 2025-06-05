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
import 'package:task_app/application/usecases/transcribe_and_create_task_usecase.dart'
    as _i149;
import 'package:task_app/domain/services/i_task_repository.dart' as _i67;
import 'package:task_app/domain/services/i_transcription_engine.dart' as _i662;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i149.TranscribeAndCreateTaskUseCase>(
        () => _i149.TranscribeAndCreateTaskUseCase(
              gh<_i662.ITranscriptionEngine>(),
              gh<_i67.ITaskRepository>(),
            ));
    return this;
  }
}
