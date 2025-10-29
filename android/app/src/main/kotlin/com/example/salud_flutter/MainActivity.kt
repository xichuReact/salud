package com.example.salud_flutter

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "recordatorios_ejercicio_v2"
            val channelName = "Recordatorios de Ejercicio"
            val channelDescription = "Notificaciones para recordar hacer ejercicio"
            val importance = NotificationManager.IMPORTANCE_MAX
            
            val channel = NotificationChannel(channelId, channelName, importance).apply {
                description = channelDescription
                enableVibration(true)
                vibrationPattern = longArrayOf(0, 1000, 500, 1000)
                enableLights(true)
                lightColor = android.graphics.Color.RED
                setShowBadge(true)
                setBypassDnd(true)
                lockscreenVisibility = android.app.Notification.VISIBILITY_PUBLIC
            }
            
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager?.createNotificationChannel(channel)

            // Mantener compatibilidad: crear el canal anterior si no existiera, pero no usarlo
            val legacyId = "recordatorios_ejercicio"
            if (notificationManager?.getNotificationChannel(legacyId) == null) {
                val legacy = NotificationChannel(legacyId, channelName, NotificationManager.IMPORTANCE_HIGH).apply {
                    description = channelDescription
                    enableVibration(true)
                    enableLights(true)
                }
                notificationManager?.createNotificationChannel(legacy)
            }
            
            android.util.Log.d("MainActivity", "Notification channel created: $channelId")
        }
    }
}
