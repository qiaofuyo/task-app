abstract class ITranscriptionEngine {
  /// 启动录音并开始转写，返回实时文字流
  Stream<String> startTranscription();

  /// 停止录音与转写
  Future<void> stopTranscription();
}
