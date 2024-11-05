import 'package:flutter/material.dart';
import 'package:memoria/pages/register_page.dart';

class AccountOverlay extends StatelessWidget {
  final OverlayPortalController controller;
  final BuildContext lootContext;
  const AccountOverlay(
      {super.key, required this.controller, required this.lootContext});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    double photoHeight = (screenWidth * 5 / 7) * 9 / 16;

    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (lootContext) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => controller.hide(),
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight / 8,
              left: screenWidth / 20,
              child: Container(
                width: screenWidth * 5 / 7,
                height: screenHeight / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth * 5 / 7,
                      height: photoHeight,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 147, 217, 110),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, photoHeight - 40, 0, 0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Row(
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 40,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(8, 22, 0, 0),
                                    child: Text(
                                      style: TextStyle(fontSize: 16),
                                      "UserName",
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: IconButton(
                                  iconSize: 50,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()),
                                    );
                                  },
                                  icon: const Icon(Icons.settings),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
