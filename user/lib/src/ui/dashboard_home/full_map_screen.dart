import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared/shared.dart';
import 'package:user/src/data/user_api_calls.dart';
import 'package:user/src/ui/dashboard_home/widget/near_by_vendors_vm.dart';

class FullMapScreen extends ConsumerStatefulWidget {
  const FullMapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends ConsumerState<FullMapScreen> {
  @override
  Widget build(BuildContext context) {
    final navigation = ref.watch(navProvider);
    final locationData = ref.watch(nearByVendorStream);
    final newData = ref.watch(nearByVendorVM);
    return Container(
      color: GlobalColors.washedWhite,
      child: Stack(
        children: [
          locationData.when(
              data: (data) {
                if (kDebugMode) {
                  print("this the data UI ${data}");
                }
                return loadedMap(newData, Set<Marker>.of(data));
              },
              error: (error, stackTrace) => emptyMap(newData),
              loading: () => emptyMap(newData)),
          Positioned(
              top: 8.h,
              left: 5.w,
              child: MenuFiller(
                bgColor: GlobalColors.ashWhite,
                icon: Icons.arrow_back_ios_new,
                onClick: () => navigation.pop(),
              )),
        ],
      ),
    );
  }

  Widget emptyMap(NearByVendorsVM locationData) => GoogleMap(
        initialCameraPosition: locationData.kGooglePlex,
        myLocationButtonEnabled: false,
      );
  Widget loadedMap(NearByVendorsVM locationData, Set<Marker> markers) =>
      GoogleMap(
        initialCameraPosition: locationData.kGooglePlex,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        mapToolbarEnabled: false,
        markers: Set<Marker>.from(markers),
        onMapCreated: (GoogleMapController controller) =>
            locationData.mapController = controller,
      );
}
