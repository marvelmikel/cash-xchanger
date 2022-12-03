import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/multi_value_listenable.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../book_cash_screen.dart';
import 'enroute_widget.dart';
import 'request_widget.dart';

class RequestCashScreen extends StatefulWidget {
  const RequestCashScreen({Key? key, required this.location}) : super(key: key);

  final List<dynamic> location;

  @override
  State<RequestCashScreen> createState() => _RequestCashScreenState();
}

class _RequestCashScreenState extends State<RequestCashScreen> {
  @override
  Widget build(BuildContext context) {
    var initialCameraPosition = CameraPosition(
      zoom: 17,
      target: LatLng(widget.location[0], widget.location[1]),
    );

    Marker? _origin, _destination;

    void addMarker(LatLng pos) {
      if (_origin == null || (_origin != null && _destination != null)) {
        setState(() {
          _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos,
          );
          _destination = null;
        });
      } else {
        setState(() {
          _origin = Marker(
              markerId: const MarkerId('destination'),
              infoWindow: const InfoWindow(title: 'Destination'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position: pos);
          _destination = null;
        });
      }
    }

    return MultiValueListenableBuilder(
        valueListenables: [switchCards, reveal],
        builder: (context, values, child) {
          var changeCards = values[0];
          var showMap = values[1];
          debugPrint(changeCards);
          return InkWell(
            onDoubleTap: () => addMarker(const LatLng(-1, 0)),
            child: Scaffold(
              backgroundColor: GlobalColors.globalWhite,
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: initialCameraPosition,
                      markers: {
                        if (_origin != null) _origin!,
                        if (_destination != null) _destination!,
                      }),
                  changeCards ? const RequestWidget() : const EnRouteWidget(),
                  Hero(
                    tag: 'reveal',
                    child: GestureDetector(
                      onTap: () => reveal.value = false,
                      child: Visibility(
                        visible: showMap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: GlobalColors.primaryBlue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Reveal transaction',
                                  style: GlobalTextStyles.regularMediumWhite(
                                      fontSize: 16)),
                              SvgPicture.asset(
                                'assets/images/money_bag_icon_no_background.svg',
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
