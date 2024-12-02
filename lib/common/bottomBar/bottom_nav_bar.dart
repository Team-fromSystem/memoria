import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memoria/common/bottomBar/account_overlay.dart';
import 'package:memoria/common/bottomBar/selected_index.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavBar extends HookConsumerWidget {
  final PageController controller;
  const BottomNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OverlayPortalController overlayPortalController =
        OverlayPortalController();
    //final selected = useState(1);
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    final selectedIndex = ref.watch(selectedIndexNotifierProvider);
    return Stack(
      children: <Widget>[
        AccountOverlay(
            lootContext: context, controller: overlayPortalController),
        Container(
            height: screenHeight / 11,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(52),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(95, 0, 0, 0),
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    spreadRadius: 0.2,
                  )
                ]),
            child: StylishBottomBar(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.circular(30),
              option: BubbleBarOptions(
                barStyle: BubbleBarStyle.horizontal,
                bubbleFillStyle: BubbleFillStyle.fill,
                opacity: 0.3,
                iconSize: 56,
              ),
              iconSpace: 18.0,
              elevation: 80,
              items: [
                BottomBarItem(
                  icon: const Icon(
                    Icons.info_outline,
                    color: Color(0xff555555),
                  ),
                  title: const Flexible(
                      child: FittedBox(
                    child: Text("ABOUT"),
                  )),
                  backgroundColor: Colors.green,
                  selectedIcon: const Icon(
                    Icons.info_sharp,
                    color: Colors.green,
                  ),
                ),
                BottomBarItem(
                  icon: const Icon(
                    CupertinoIcons.ticket,
                    color: Color(0xff555555),
                  ),
                  title: const Text("トップ\nページ"),
                  backgroundColor: Colors.orange,
                  selectedIcon: const Icon(
                    CupertinoIcons.tickets_fill,
                    color: Colors.orange,
                  ),
                ),
                BottomBarItem(
                  icon: const Icon(
                    Icons.movie_edit,
                    color: Color(0xff555555),
                  ),
                  title: const Text("イベント\n作成"),
                  backgroundColor: Colors.purple,
                  selectedIcon: const Icon(
                    Icons.edit_document,
                    color: Colors.purple,
                  ),
                ),
              ],
              hasNotch: true,
              currentIndex: selectedIndex[0],
              onTap: (index) {
                if (index == 0) {
                  overlayPortalController.show();
                } else {
                  overlayPortalController.hide();
                  controller.jumpToPage(index - 1);
                }
                final selectedIndexNotifier =
                    ref.read(selectedIndexNotifierProvider.notifier);
                selectedIndexNotifier.updateIndexTo(index);
              },
            ))
      ],
    );
  }
}
