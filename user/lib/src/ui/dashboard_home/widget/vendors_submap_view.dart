import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:user/src/data/user_api_calls.dart';

import 'near_by_vendors_vm.dart';

class MapSubView extends ConsumerStatefulWidget {
  const MapSubView({Key? key}) : super(key: key);

  @override
  ConsumerState<MapSubView> createState() => _MapSubViewState();
}

class _MapSubViewState extends ConsumerState<MapSubView> {
  @override
  Widget build(BuildContext context) {
    final locationData = ref.watch(nearByVendorStream);
    final newData = ref.watch(nearByVendorVM);
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Vendors Around You',
                style: GlobalTextStyles.regularMediumW(
                    context: context, fontSize: 14)),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 25.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: locationData.when(
                  data: (data) {
                    print("this the data UI ${data}");
                    return loadedMap(newData, Set<Marker>.of(data));
                  },
                  error: (error, stackTrace) => emptyMap(newData),
                  loading: () => emptyMap(newData)),
            ),
          ],
        ),
      ),
    );
    //  );
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
