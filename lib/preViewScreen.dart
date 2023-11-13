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
                            child: Preview(),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          FittedBox(
                            child: Preview(),
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
                            child: Preview(),
                            fit: BoxFit.contain
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          FittedBox(
                            child: Preview(),
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