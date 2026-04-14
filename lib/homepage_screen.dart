import 'package:flutter/material.dart';
import 'services/fcm_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FCMService _fcmService = FCMService();
  String statusText = 'Waiting for a cloud message';
  String imagePath = 'assets/images/default.png';

  @override
  void initState() {
    super.initState();
    _fcmService.initialize(onData: (message) {
      setState(() {
        statusText = message.notification?.title ?? 'Payload received';
        imagePath = 'assets/images/${message.data['asset'] ?? 'default'}.png';
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // IMAGE
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Image.asset(
                      imagePath,
                      key: ValueKey(imagePath),
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 100);
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TEXT
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      statusText,
                      key: ValueKey(statusText),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}