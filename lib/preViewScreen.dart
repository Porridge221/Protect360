import 'package:flutter/material.dart';
import 'package:flutter_application_1/preview.dart';

class PreViewScreen extends StatelessWidget {
  double offsetX = 0;
  double offsetY = 0;
  double zoom = 1;

  PreViewScreen({super.key, required this.offsetX, required this.offsetY, required this.zoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            child: Preview(phoneType: 'Iphone 11 Pro', offsetX: offsetX, offsetY: offsetY, zoom: zoom),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          FittedBox(
                            child: Preview(phoneType: 'Galaxy_M52', offsetX: offsetX, offsetY: offsetY, zoom: zoom),
                            fit: BoxFit.contain
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Preview(phoneType: 'Huawei_P50_Pro', offsetX: offsetX, offsetY: offsetY, zoom: zoom),
                            fit: BoxFit.contain
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          FittedBox(
                            child: Preview(phoneType: 'iPhone_14_Pro_Max', offsetX: offsetX, offsetY: offsetY, zoom: zoom),
                            fit: BoxFit.contain
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}