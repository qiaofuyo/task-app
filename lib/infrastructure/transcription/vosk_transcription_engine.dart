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
    // 1. 接收 Android 发来的字符串流
    _stream = _eventChannel.receiveBroadcastStream().map((event) => event as String);
    // 2. 通知 Android 层启动 Vosk 录音与识别
    _methodChannel.invokeMethod('start');
    return _stream!;
  }

  @override
  Future<void> stopTranscription() {
    // 通知 Android 停止
    return _methodChannel.invokeMethod('stop');
  }
}
