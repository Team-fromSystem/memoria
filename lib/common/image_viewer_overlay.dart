import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewerOverlay extends StatelessWidget {
  final OverlayPortalController controller;
  final BuildContext lootContext;
  final String imageURL;
  const ImageViewerOverlay(
      {super.key,
      required this.imageURL,
      required this.controller,
      required this.lootContext});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (lootContext) {
        return Stack(
          children: [
            InteractiveViewer(
                child: Container(
              width: screenWidth,
              height: screenHeight,
              decoration: const BoxDecoration(
                color: Color.fromARGB(100, 0, 0, 0),
              ),
              child: CachedNetworkImage(
                width: screenWidth,
                height: screenHeight,
                imageUrl: imageURL,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
            )),
            IconButton(
                onPressed: () {
                  controller.hide();
                },
                icon: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 60, 0, 0),
                  child: Icon(
                    Icons.close,
                    size: 36,
                    color: Colors.white,
                  ),
                )),
          ],
        );

        // Stack(children: [
        //   GestureDetector(
        //     onTap: () => controller.hide(),
        //     child: Container(
        //       width: screenWidth,
        //       height: screenHeight,
        //       decoration: const BoxDecoration(
        //         color: Color.fromARGB(100, 0, 0, 0),
        //       ),
        //     ),
        //   ),
        //   Column(children: [
        //     //const Padding(padding: EdgeInsets.only(top: 100)),
        //     InteractiveViewer(
        //       clipBehavior: Clip.none,
        //       child: CachedNetworkImage(
        //         width: screenWidth,
        //         height: screenHeight,
        //         imageUrl: imageURL,
        //         progressIndicatorBuilder: (context, url, downloadProgress) =>
        //             CircularProgressIndicator(value: downloadProgress.progress),
        //       ),
        //     )
        //   ])
        // ]);
      },
    );
  }
}
