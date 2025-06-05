import 'dart:async';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../../domain/services/i_transcription_engine.dart';

const _methodChannel = MethodChannel('task_app/transcription_method');
const _eventChannel = EventChannel('task_app/transcription_event');

@LazySingleton(as: ITranscriptionEngine)
class VoskTranscriptionEngine implements ITranscriptionEngine {
  Stream<String>? _stream;

  @override
  Stream<String> startTranscription() {
    _stream = _eventChannel.receiveBroadcastStream().map((event) => event as String);
    _methodChannel.invokeMethod('start');
    return _stream!;
  }

  @override
  Future<void> stopTranscription() {
    return _methodChannel.invokeMethod('stop');
  }
}
