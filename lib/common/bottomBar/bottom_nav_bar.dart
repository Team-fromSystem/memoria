import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memoria/common/bottomBar/account_overlay.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavBar extends HookWidget {
  final PageController controller;
  const BottomNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final OverlayPortalController overlayPortalController =
        OverlayPortalController();
    var selected = useState(1);

    return Stack(
      children: <Widget>[
        AccountOverlay(
            lootContext: context, controller: overlayPortalController),
        Container(
            height: 84,
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
                // barStyle: BubbleBarStyle.vertical,
                barStyle: BubbleBarStyle.horizontal,
                bubbleFillStyle: BubbleFillStyle.fill,
                // bubbleFillStyle: BubbleFillStyle.outlined,
                opacity: 0.3,
                iconSize: 56,
                //padding: const EdgeInsets.all(20),
              ),
              iconSpace: 18.0,
              elevation: 80,
              //gradient:
              items: [
                BottomBarItem(
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xff555555),
                  ),
                  title: const Text('"UserName"'),
                  backgroundColor: Colors.red,
                  selectedIcon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.red,
                  ),
                ),
                BottomBarItem(
                  icon: const Icon(
                    Icons.tour_sharp,
                    color: Color(0xff555555),
                  ),
                  title: const Text('Safety Divider'),
                  backgroundColor: Colors.orange,
                  selectedIcon: const Icon(
                    Icons.tour_sharp,
                    color: Colors.orange,
                  ),
                ),
                BottomBarItem(
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xff555555),
                  ),
                  title: const Text('Cabin'),
                  backgroundColor: Colors.purple,
                  selectedIcon: const Icon(
                    Icons.search,
                    color: Colors.purple,
                  ),
                ),
              ],
              hasNotch: true,
              currentIndex: selected.value,
              onTap: (index) {
                if (index == 0) {
                  overlayPortalController.show();
                } else {
                  overlayPortalController.hide();
                  controller.jumpToPage(index - 1);
                }
                selected.value = index;
              },
            ))
      ],
    );
  }
}

// class _BubbelBarExampleState extends State<BubbelBarExample> {
//   PageController controller = PageController(initialPage: 0);
//   var selected = 0;

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: PageView(
//         controller: controller,
//         children: const [HomePage(), DetailPage()],
//       ),
//       bottomNavigationBar: Container(
//           height: 84,
//           margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//           padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(52),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color.fromARGB(95, 0, 0, 0),
//                   offset: Offset(0, 2),
//                   blurRadius: 3,
//                   spreadRadius: 0.2,
//                 )
//               ]),
//           child: StylishBottomBar(
//             backgroundColor: const Color.fromARGB(0, 0, 0, 0),
//             borderRadius: BorderRadius.circular(30),
//             option: BubbleBarOptions(
//               // barStyle: BubbleBarStyle.vertical,
//               barStyle: BubbleBarStyle.horizontal,
//               bubbleFillStyle: BubbleFillStyle.fill,
//               // bubbleFillStyle: BubbleFillStyle.outlined,
//               opacity: 0.3,
//               iconSize: 56,
//               //padding: const EdgeInsets.all(20),
//             ),
//             iconSpace: 18.0,
//             elevation: 80,
//             //gradient:
//             items: [
//               BottomBarItem(
//                 icon: const Icon(
//                   Icons.account_circle_outlined,
//                   color: Color(0xff555555),
//                 ),
//                 title: const Text('"UserName"'),
//                 backgroundColor: Colors.red,
//                 selectedIcon: const Icon(
//                   Icons.account_circle_outlined,
//                   color: Colors.red,
//                 ),
//               ),
//               BottomBarItem(
//                 icon: const Icon(
//                   Icons.tour_sharp,
//                   color: Color(0xff555555),
//                 ),
//                 title: const Text('Safety Divider'),
//                 backgroundColor: Colors.orange,
//                 selectedIcon: const Icon(
//                   Icons.tour_sharp,
//                   color: Colors.orange,
//                 ),
//               ),
//               BottomBarItem(
//                 icon: const Icon(
//                   Icons.search,
//                   color: Color(0xff555555),
//                 ),
//                 title: const Text('Cabin'),
//                 backgroundColor: Colors.purple,
//                 selectedIcon: const Icon(
//                   Icons.search,
//                   color: Colors.purple,
//                 ),
//               ),
//             ],
//             hasNotch: true,
//             currentIndex: selected,
//             onTap: (index) {
//               setState(() {
//                 selected = index;
//                 controller.jumpToPage(index);
//               });
//             },
//           )),
//     );
//   }
// }
