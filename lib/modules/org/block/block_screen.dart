import 'package:flutter/material.dart';
import 'package:untitled1/modules/select/select_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class BlockScreen extends StatelessWidget {
  const BlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF964F44);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: primaryColor.withOpacity(0.1),
              child: const Icon(Icons.block, size: 40, color: primaryColor),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'You have been blocked',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Access to your account has been restricted by the admin.',
              style: TextStyle(fontSize: 15.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            const Text(
              'If you think this is a mistake, please contact support.',
              style: TextStyle(fontSize: 14.0, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                CacheHelper.removeData(key: 'orgId').then((value) {
                  navigateAndFinish(context, const SelectScreen());
                });
              },
              child: const Text('Logout', style: TextStyle(fontSize: 16.0)),
            ),
          ],
        ),
      ),
    );
  }
}
