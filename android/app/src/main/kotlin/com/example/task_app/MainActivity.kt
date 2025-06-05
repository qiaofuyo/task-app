import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import org.vosk.Model
import org.vosk.Recognizer
import org.vosk.android.RecordingStream

package com.example.task_app

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
  private val METHOD_CHANNEL = "task_app/transcription_method"
  private val EVENT_CHANNEL = "task_app/transcription_event"
  private var recognizer: Recognizer? = null
  private var stream: RecordingStream? = null
  private var eventSink: EventChannel.EventSink? = null

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    // MethodChannel：启动/停止转写
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
      .setMethodCallHandler { call, result ->
        when (call.method) {
          "start" -> {
            // 初始化 Vosk 模型与识别器
            val assetManager = this.assets
            val model = Model(assetManager, "model")
            recognizer = Recognizer(model, 16000.0f)

            // 创建并启动录音流
            stream = RecordingStream.Builder()
              .setSampleRate(16000)
              .build()
            stream?.start { data, _ ->
              // 接收音频数据，输出完整结果或部分结果
              if (recognizer?.acceptWaveForm(data, data.size) == true) {
                val text = recognizer?.result ?: ""
                eventSink?.success(text)
              } else {
                val partial = recognizer?.partialResult ?: ""
                eventSink?.success(partial)
              }
            }
            result.success(null)
          }
          "stop" -> {
            stream?.stop()
            recognizer?.close()
            result.success(null)
          }
          else -> result.notImplemented()
        }
      }

    // EventChannel：推送实时文字流
    EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL)
      .setStreamHandler(object: EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
          eventSink = events
        }
        override fun onCancel(arguments: Any?) {
          eventSink = null
        }
      })
  }
}

