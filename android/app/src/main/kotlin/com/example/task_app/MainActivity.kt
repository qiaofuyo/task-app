package com.example.task_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import org.vosk.Model
import org.vosk.Recognizer
import org.vosk.android.RecognitionListener
import org.vosk.android.SpeechService

class MainActivity: FlutterActivity(), RecognitionListener {
  private var speechService: SpeechService? = null
  private var recognizer: Recognizer? = null
  private var eventSink: EventChannel.EventSink? = null

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    // Flutter → Android 方法通道
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "task_app/transcription_method")
      .setMethodCallHandler { call, result ->
        when (call.method) {
          "start" -> {
            // 加载 model：release 后位于 assets/flutter_assets/model
            val modelPath = filesDir.absolutePath + "/flutter_assets/model"
            val model = Model(modelPath)
            recognizer = Recognizer(model, 16000.0f)

            // 正确实例化 SpeechService 并启动监听
            speechService = SpeechService(recognizer, 16000.0f)
            speechService?.startListening(this)

            result.success(null)
          }
          "stop" -> {
            speechService?.stop()
            recognizer?.close()
            result.success(null)
          }
          else -> result.notImplemented()
        }
      }

    // Android → Flutter 事件通道
    EventChannel(flutterEngine.dartExecutor.binaryMessenger, "task_app/transcription_event")
      .setStreamHandler(object: EventChannel.StreamHandler {
        override fun onListen(args: Any?, events: EventChannel.EventSink?) {
          eventSink = events
        }
        override fun onCancel(args: Any?) {
          eventSink = null
        }
      })
  }

  // RecognitionListener 回调
  override fun onPartialResult(hypothesis: String) {
    eventSink?.success(hypothesis)
  }
  override fun onResult(hypothesis: String) {
    eventSink?.success(hypothesis)
  }
  override fun onFinalResult(hypothesis: String) {
    eventSink?.success(hypothesis)
  }
  override fun onError(exception: Exception) {
    eventSink?.error("RECOG_ERROR", exception.message, null)
  }
  override fun onTimeout() {
    eventSink?.endOfStream()
  }
}
