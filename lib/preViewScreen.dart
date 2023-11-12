import 'package:flutter/material.dart';
import 'package:flutter_application_1/preview.dart';

class PreViewScreen extends StatelessWidget {
  const PreViewScreen({super.key});

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
                            child: Preview(),
                            fit: BoxFit.contain
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            // child: SvgPicture.asset("assets/svg/1.svg"),
                            child: Image.asset(
                              "assets/img1.jpg",
                              fit: BoxFit.scaleDown,
                            ),
                            onTap: () {},
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
                          InkWell(
                            // child: SvgPicture.asset("assets/svg/1.svg"),
                            child: Image.asset(
                              "assets/img1.jpg",
                              fit: BoxFit.scaleDown,
                            ),

                            onTap: () {},
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            // child: SvgPicture.asset("assets/svg/1.svg"),
                            child: Image.asset(
                              "assets/img1.jpg",
                              fit: BoxFit.scaleDown,
                            ),

                            onTap: () {},
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