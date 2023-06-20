import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cash_xchanger/database/models/cash_request/cash_request.dart';
// import 'package:cash_xchanger/helpers/text_styles.dart';
// import 'package:cash_xchanger/ui/vendor/cash_requst/cash_request_viewmodel.dart';
// import 'package:cash_xchanger/ui/vendor/widgets/count_down_widget.dart';
// import 'package:cash_xchanger/utils/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared/shared.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor/src/ui/cash_requst/cash_request_viewmodel.dart';
import 'package:vendor/src/ui/widgets/count_down_widget.dart';

class VendorCashRequestScreen extends ConsumerStatefulWidget {
  const VendorCashRequestScreen({
    Key? key,
    //required this.cashPayload
  }) : super(key: key);
  // final InitCashPayload cashPayload;

  @override
  ConsumerState<VendorCashRequestScreen> createState() =>
      _VendorCashRequestScreen();
}

class _VendorCashRequestScreen extends ConsumerState<VendorCashRequestScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //  ref.read(vendorCashRequestProvider).initRequestData(userInformation!);
  }

  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    final requestContoller = ref.watch(vendorCashRequestProvider);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          mapToolbarEnabled: false,
          initialCameraPosition: requestContoller.initialLocation,
          markers: Set<Marker>.from(requestContoller.markers),
          polylines: {
            if (requestContoller.pollies != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: GlobalColors.primaryGreen,
                width: 5,
                points: requestContoller
                    .pollies!.features!.geometry!.coordinates!
                    .map((point) => LatLng(point[1], point[0]))
                    .toList(),
              )
          },
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) =>
              requestContoller.mapController = controller,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
            //  onTap: () => requestContoller.initRequestData(userInformation!),
              child: AvatarGlow(
                glowColor: GlobalColors.primaryGreen,
                endRadius: 120,
                duration: const Duration(milliseconds: 1000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: SvgPicture.asset('assets/images/money_bag_icon.svg',
                    height: 6.h),
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20),
              margin: EdgeInsets.symmetric(horizontal: 2.h),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: GlobalColors.globalWhite),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Hey, requestContoller.userInformation!.senderName needs cash from you!',
                      style: GlobalTextStyles.regularMediumH(fontSize: 10.sp)),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.h),
              margin:
                  EdgeInsets.only(bottom: 4.h, top: 2.h, left: 2.w, right: 2.w),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: GlobalColors.globalWhite),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundColor: GlobalColors.primaryGreen,
                              child: ClipOval(
                                //TODO: CHANGE TO THE REAL VALUE WHEN DONE FOR IMAGE REQUST WIDGET
                                child: SizedBox(
                                  height: 5.h,
                                  width: 5.w,
                                  child: CachedNetworkImage(
                                    imageUrl: '',
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              )),
                          SizedBox(width: 5.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "requestContoller.userInformation!.senderName!",
                                style: GlobalTextStyles.regularMediumH(
                                    fontSize: 10.sp),
                              ),
                              Text(
                                'CashX User',
                                style: GlobalTextStyles.regularGreenText(
                                    context: context,
                                    fontSize: 10.sp,
                                    alpha: 255),
                              ),
                            ],
                          )
                        ],
                      ),
                      // ValueListenableBuilder(
                      //   valueListenable: bookingData,
                      //   builder: (context, BookingData data, child) => Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           const Text('Cash request'),
                      //           Text(
                      //             'N${formatFiguresSeparator(double.parse(requestContoller.userInformation!.amount ?? "200000"))}',
                      //             style: GlobalTextStyles.greenMediumText(
                      //                 context: context),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  const Text('Meetup destination'),
                  Text(
                     " requestContoller.userInformation!.senderLocation" ??
                          "Not Specified",
                      style: GlobalTextStyles.regularMediumH(fontSize: 11.sp)),
                  const Divider(),
                  const Text('Time to accept'),
                  CountDown(),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SmallButton(
                        color: const Color(0xffF5F5F5),
                        text: 'Decline',
                      //  onTap: () => requestContoller.declineBooking(TripModel(transactionId: requestContoller.userInformation!.transactionId.toString()), context),
                      ),
                      SmallButton(
                        color: GlobalColors.primaryGreen,
                        text: 'Accept',
                        textColor: Colors.white,
                       // onTap: () => requestContoller.acceptBooking(CashRequestModel(
                       //   lat: 37.4219991,
                       //   long: -122.0840011,
                       //   address: "Jabi, Lake",
                       //   transactionID:  requestContoller.userInformation!.transactionId.toString(),
                       //
                       // ),
                       //  context),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                 // md5Asdf#24kt
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
