import 'package:flutter/material.dart';
import 'package:flutter_application_1/preview.dart';

class PreViewScreen extends StatelessWidget {
  const PreViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Preview(phoneType: 'Iphone 11 Pro'),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          FittedBox(
                            child: Preview(phoneType: 'Galaxy_M52'),
                            fit: BoxFit.contain
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Preview(phoneType: 'Huawei_P50_Pro'),
                            fit: BoxFit.contain
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          FittedBox(
                            child: Preview(phoneType: 'iPhone_14_Pro_Max'),
                            fit: BoxFit.contain
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}