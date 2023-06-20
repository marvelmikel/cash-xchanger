import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared/shared.dart';

final vendorCashRequestProvider =
    ChangeNotifierProvider<VendorCashRequestProvider>((ref) {
  return VendorCashRequestProvider(ref);
});

class VendorCashRequestProvider extends ChangeNotifier {
  final Ref _ref;
  VendorCashRequestProvider(this._ref);

  GoogleMapController? _mapController;

  // final _vendorApi = getItInstance<VendorsApi>();

  set mapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  Set<Marker> markers = Set(); //markers for google map

  CameraPosition initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));

  OpenDirections? pollies;

  LatLng startLocation = const LatLng(0.0, 0.0);

  LatLng endLocation = const LatLng(0.0, 0.0);

  // Future initRequestData(InitCashPayload initialData) async {
  //   userInformation = initialData;
  //
  //   notifyListeners();
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     //7.495760359654105,8.961157199545097
  //     startLocation = const LatLng(8.961157199545097, 7.495760359654105);
  //     endLocation = const LatLng(8.961983951581816, 7.503484898282577);
  //     notifyListeners();
  //     List<Placemark> p = await placemarkFromCoordinates(
  //         endLocation.latitude, endLocation.longitude);
  //     Placemark place = p[0];
  //     userInformation!.senderLocation =
  //         '${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //     if (_mapController != null) {
  //       _mapController?.animateCamera(CameraUpdate.newCameraPosition(
  //           CameraPosition(target: startLocation, zoom: 14.5, tilt: 50.0)));
  //     }
  //     notifyListeners();
  //   });
  //   initMarkers();
  // }

  initMarkers() async {
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: "userInformation!.senderName!",
        snippet: '${7} ${const Duration(seconds: 0)}',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    if (pollies == null) {
      final directions = await _ref
          .read(directionsRepoProvider)
          .getOpenDirections(origin: startLocation, destination: endLocation);
      if (kDebugMode) {
        print(
            'this is the coordinates  data ${directions!.features!.geometry!.coordinates}');
      }
      pollies = directions;
      debugPrint(
          'arrive in ${Duration(seconds: pollies!.features!.properties!.summary!.duration!.toInt()).inMinutes} mins');
    }

    notifyListeners();
  }

  // Future acceptBooking(
  //     CashRequestModel requestModel, BuildContext context) async {
  //   _vendorApi.acceptBooking(requestModel: requestModel, context: context);
  // }
  //
  // Future declineBooking(TripModel tripModel, BuildContext context) async {}
  //
  // Future startTripBooking(TripModel requestModel) async {}
  // Future cancelTripBooking(TripModel requestModel) async {}
  // Future completeTripBooking(TripModel requestModel) async {}
}
