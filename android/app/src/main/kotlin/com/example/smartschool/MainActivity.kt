package com.houssamaziez.Learncosmeticacademy

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // منع أخذ سكرين شوت أو تسجيل الشاشة
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE
        )
    }
}
// package com.houssamaziez.Learncosmeticacademy

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity()
