import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memoria/common/bottomBar/selected_index.dart';
import 'package:memoria/pages/register_page.dart';

class AccountOverlay extends ConsumerWidget {
  final OverlayPortalController controller;
  final BuildContext lootContext;
  const AccountOverlay(
      {super.key, required this.controller, required this.lootContext});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    double photoHeight = (screenWidth * 2.5 / 7) * 9 / 16;

    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (lootContext) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                controller.hide();
                final selectedIndexNotifier =
                    ref.read(selectedIndexNotifierProvider.notifier);
                selectedIndexNotifier.undoIndex();
              },
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
                height: screenHeight / 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Container(
                        width: screenWidth * 5 / 7,
                        height: photoHeight,
                        padding: const EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 147, 217, 110),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FittedBox(
                              child: Expanded(child: Text("welcom to")),
                            ),
                            FittedBox(
                              child: Expanded(
                                  child: Text(
                                "memoria",
                                style: TextStyle(fontSize: 40),
                              )),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, photoHeight - 40, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    // child: Text(
                                    //   style: TextStyle(fontSize: 36),
                                    //   "UserName",
                                    // ),
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
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const RegisterPage()),
                                    // );
                                  },
                                  icon: const Icon(Icons.settings),
                                ),
                              )
                            ],
                          ),
                          const Text(
                            "Info - 使い方",
                            style: TextStyle(fontSize: 22),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          const Text(
                            "1. 気になるイベントをトップページから探して、バナーをタップしてみよう",
                            style: TextStyle(fontSize: 14),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 4)),
                          const Text(
                            "2. イベント情報からデータをダウンロードして、マップから開催エリアに行ってみよう",
                            style: TextStyle(fontSize: 14),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 4)),
                          const Text(
                            "3. 入場ボタンをタップしてARを起動、写真撮影を楽しもう！",
                            style: TextStyle(fontSize: 14),
                          ),
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
