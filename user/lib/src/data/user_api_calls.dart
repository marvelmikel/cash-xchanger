import 'dart:async';
import 'dart:ui' as ui;

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:network/network.dart';
import 'package:shared/shared.dart';
import 'package:user/user.dart';

import 'model/nearest_vendors_model.dart';

class UserApiCalls {
  final _mapMarkerSC = StreamController<List<Marker>>();
  // Markers for Getting Live Vendor Locations
  Stream<List<Marker>> get _mapMarkerSink => _mapMarkerSC.stream;

  Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;
  final List<Marker> _markers = <Marker>[];

  // Getting Transaction Charges for User
  Future<TransactionCharges> getCharges({required String cost}) async {
    TransactionCharges charges = TransactionCharges();

    final response = await GraphqlService().postMutation(
        UserMutations.getTransactionCharges, {"amount": double.parse(cost)});
    response.fold((l) => alert(description: l.first.message), (r) {
      try {
        charges = Response.fromJson(r).userCollection!.fees!;
      } catch (e, str) {
        if (kDebugMode) {
          print(e);
          print(str);
        }
      }
    });

    return charges;
  }

  //Creating the Marker Icons

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);

    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<CardAuthorization> initCardAdding(
      {required String amount, required bool isDefault}) async {
    CardAuthorization authLink = CardAuthorization();

    final response = await GraphqlService().postMutation(
        UserMutations.addDebitCard,
        {"amount": double.parse(amount), "isDefault": isDefault});
    response.fold((l) => alert(description: l.first.message), (r) {
      try {

        print("this is the value $r");
        authLink = Response.fromJson(r).cardCollection!.cardAuth!;
      } catch (e, str) {
        if (kDebugMode) {
          print(" boo err $e");
          print("boo stk$str");
        }
      }
    });

    return authLink;
  }

  Stream<List<Marker>> getNearestVendors() async* {
    final result =
        GraphqlService().subscriptions(UserSubscription.getVendorsNearMe);
    result.listen((event) async {
      if (kDebugMode) {
        print("this the data ${event.data}");
      }
      final val = event.data;
      final vendorData = NearByVendors.fromJson(val!);

      if (vendorData.nearestVendors!.isNotEmpty) {
        for (var element in vendorData.nearestVendors!) {
          final venor = Marker(
            //add distination location marker
            markerId: MarkerId(element.vendor!.id!),
            position: LatLng(element.location![1],
                element.location![0]), //position of marker
            infoWindow: InfoWindow(
              //popup info
              title: element.vendor!.fullName!,
              snippet: '1km',
            ),
            icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(
                GlobalAssets.userIcon, 100)), //Icon for Marker
          );
          _markers.add(venor);
          _mapMarkerSC.add(_markers);
        }
      } else {
        _markers.clear();
        _mapMarkerSC.add(_markers);
      }
    });

    yield* _mapMarkerSink;
  }
}

final userApiProvider = Provider((ref) => UserApiCalls());

final nearByVendorStream = StreamProvider<List<Marker>>((ref) async* {
  final response = ref.watch(userApiProvider).getNearestVendors();
  yield* response;
});
