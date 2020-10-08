package com.example.onlyfilms

import androidx.annotation.NonNull;
import com.facebook.FacebookSdk
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

import android.os.Build
import android.view.ViewTreeObserver
import android.view.WindowManager
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        FacebookSdk.sdkInitialize(getApplicationContext());
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}