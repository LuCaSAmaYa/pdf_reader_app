package com.example.pdf_reader_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.pdf_reader_app/pdf"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getInitialPdfPath") {
                val initialPdfPath = getInitialPdfPath()
                if (initialPdfPath != null) {
                    result.success(initialPdfPath)
                } else {
                    result.error("UNAVAILABLE", "Initial PDF path not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getInitialPdfPath(): String? {
        val intent = intent
        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_VIEW == action && type == "application/pdf") {
            val uri = intent.data
            if (uri != null) {
                return uri.toString()
            }
        }
        return null
    }
}
