import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatelessWidget {
  final GeoPoint geoPoint;
  final double areaRadius;
  const GoogleMapPage(
      {super.key, required this.geoPoint, required this.areaRadius});
  @override
  Widget build(BuildContext context) {
    final LatLng eventLatLng = LatLng(geoPoint.latitude, geoPoint.longitude);
    // マップの表示制御用
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    late GoogleMapController mapController;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("詳細マップ"),
          titleTextStyle: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(252, 235, 234, 238),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
          ),
          toolbarHeight: 70,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          margin: const EdgeInsets.fromLTRB(0, 83, 0, 0),
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(geoPoint.latitude, geoPoint.longitude),
                    zoom: 15),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                indoorViewEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('marker_1'),
                    position: eventLatLng,
                  ),
                },
                circles: {
                  Circle(
                    circleId: const CircleId('circle_1'),
                    center: eventLatLng,
                    radius: areaRadius,
                    fillColor: const Color.fromARGB(255, 136, 212, 185)
                        .withOpacity(0.3),
                    strokeWidth: 1,
                  ),
                },
              ),
            ],
          ),
        ));
  }
}
