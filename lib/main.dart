import 'package:bus_booking/core/routes/app_pages.dart';
import 'package:bus_booking/core/routes/app_routes.dart';
import 'package:bus_booking/core/theme/app_theme.dart';
import 'package:bus_booking/firebase_options.dart';
import 'package:bus_booking/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Plugin local notifications - khai báo global
final FlutterLocalNotificationsPlugin localNotifications =
    FlutterLocalNotificationsPlugin();

// Background handler - PHẢI đặt top-level (ngoài class)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('BG message: ${message.messageId}');
}

// Setup local notifications
Future<void> _setupLocalNotifications() async {
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings();

  await localNotifications.initialize(
    const InitializationSettings(android: androidSettings, iOS: iosSettings),
    onDidReceiveNotificationResponse: _onNotificationTapped,
  );

  // Tạo channel cho Android
  const channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  await localNotifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

// Khi user tap notification
void _onNotificationTapped(NotificationResponse response) {
  print('Notification tapped: ${response.payload}');
  // Navigate đến màn hình cụ thể dựa vào payload
  if (response.payload != null && response.payload!.isNotEmpty) {
    Get.toNamed(response.payload!);
  }
}

// Show notification (cho foreground)
Future<void> _showNotification(RemoteMessage message) async {
  final notification = message.notification;
  if (notification == null) return;

  await localNotifications.show(
    notification.hashCode,
    notification.title ?? 'No title',
    notification.body ?? 'No body',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    ),
    payload: message.data['route'], // Truyền route để navigate khi tap
  );
}

// Xử lý message khi tap notification (background/terminated)
void _handleMessage(RemoteMessage message) {
  print('Message data: ${message.data}');

  // Navigate dựa vào data
  final route = message.data['route'];
  if (route != null) {
    // Delay một chút để app khởi động xong
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.toNamed(route);
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup local notifications
  await _setupLocalNotifications();

  // Background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Request permission
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Get token
  final token = await FirebaseMessaging.instance.getToken();
  print('=====================');
  print('FCM Token: $token');
  print('=====================');

  // === XỬ LÝ 3 TRẠNG THÁI ===

  // 1. TERMINATED: App bị kill, user tap notification mở app
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print('App opened from TERMINATED via notification');
    _handleMessage(initialMessage);
  }

  // 2. BACKGROUND: App chạy nền, user tap notification
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('App opened from BACKGROUND via notification');
    _handleMessage(message);
  });

  // 3. FOREGROUND: App đang mở
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message received');
    _showNotification(message);
  });

  // Initialize Hive
  await Hive.initFlutter();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.main,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
