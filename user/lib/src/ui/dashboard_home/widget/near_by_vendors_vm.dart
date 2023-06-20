import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:network/network.dart';
import 'package:user/src/data/model/nearest_vendors_model.dart';

final nearByVendorVM = ChangeNotifierProvider((ref) => NearByVendorsVM(ref));

class NearByVendorsVM extends ChangeNotifier {
  final Ref ref;

  NearByVendorsVM(this.ref);

  GoogleMapController? _mapController;

  final _mapMarkerSC = StreamController<List<Marker>>();

  Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;

  final List<Marker> _markers = <Marker>[];

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(8.961157, 7.495760359654105),
    zoom: 14.5,
  );
  set mapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }


  setUserLocation(LatLng latLng) {
    if (_mapController != null) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 14.5, tilt: 50.0)));
      notifyListeners();
    }
  }


}
