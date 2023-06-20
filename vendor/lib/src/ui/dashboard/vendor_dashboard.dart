import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared/shared.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor/src/ui/dashboard/vendor_dashboard_vm.dart';
import 'package:vendor/src/ui/dashboard/vendor_nav_bar.dart';

import 'switch_button_widget.dart';

//ValueNotifier<LatLng> vendorLatLng = ValueNotifier(LatLng());

class VendorDashboard extends ConsumerStatefulWidget {
  const VendorDashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends ConsumerState<VendorDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigation = ref.watch(navProvider);
    final controller = ref.watch(vendorDashboardVM);
    final profile = ref.watch(profileViewModelProviderV1);

    return Scaffold(
      key: controller.scaffoldKey,
      drawer: const VendorNavigationDrawer(),
      body: SingleChildScrollView(
        key: const Key('md5Asdf#24kt'),
        child: Consumer(
            key: Key("Sajs"),
            builder: (context, ref, child) {
              //     final onlineStatusProv = ref.watch(vendorDashProvider);
              // onlineStatusProv.getVendorVisibilityStatus();

              return Column(
                key: const Key("abshs"),
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: MenuBar(
                      scafoldKey: controller.scaffoldKey,
                      key: const Key("Mwslsat"),
                      isWhiteBg: true,
                      leadingMsg: 'Let’s get you started today!',
                      nameLabel: profile.currentUser.fullName!.split(" ").first,
                    ),
                  ),

                  Container(
                    key: const Key("Sahshhs"),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: !controller.positive
                            ? Colors.red
                            : const Color(0xff29F5A6),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            controller.positive
                                ? "SWIPE TO GO OFFLINE"
                                : 'SWIPE TO GO ONLINE',
                            style: GlobalTextStyles.blueMediumText(
                                context: context, fontSize: 17)),
                        AnimatedToggleSwitch<bool>.dual(
                          key: const Key("Loader"),
                          current: controller.positive,
                          first: false,
                          second: true,
                          innerColor: !controller.positive
                              ? Colors.red.withOpacity(0.3)
                              : const Color(0xff29F5A6).withOpacity(0.3),
                          dif: 50.0,
                          //  borderColorBuilder: () => !positive ?  Colors.red : Color(0xff29F5A6),
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 55,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: controller.toggleVendorState,
                          colorBuilder: (b) => Colors.white,
                          iconBuilder: (value) => value
                              ? const Icon(
                                  Icons.arrow_back,
                                  color: Color(0xffB3B3B3),
                                )
                              : const Icon(Icons.arrow_forward,
                                  color: Color(0xffB3B3B3)),
                          textBuilder: (value) => value
                              ? const Center(
                                  key: Key("sjsjjs"),
                                  child: Text(
                                    'Online',
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : const Center(
                                  key: Key("shhh"),
                                  child: Text(
                                    'Offline',
                                    style: TextStyle(color: Colors.white),
                                  )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

                  InkWell(
                    onTap: () {
                      // getItInstance<NavigationServiceImpl>()
                      //     .navigateTo(Routes.vendorRequestScreen);
                    },
                    child: ShadowContainer(
                        color: Colors.black,
                        borderColor: Colors.black,
                        key: const Key("Shas"),
                        height: 22.5,
                        verticalPadding: 4.h,
                        horizontalPadding: 5.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                twoText(label: 'Total orders', value: '0'),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    twoText(
                                        label: 'Successful',
                                        value: '0',
                                        hasPercent: true),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    twoText(
                                        label: 'Unsuccessful',
                                        value: '0',
                                        hasPercent: true),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/bronze.svg',
                                  height: 10.h,
                                ),
                                const Text(
                                  "Green",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),

                  ShadowContainer(
                      verticalPadding: 2.h,
                      horizontalPadding: 5.w,
                      key: const Key('__RIKEY3__'),
                      height: 2.9.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          controller.isEditing
                              ? Text(
                                  'What amount are you working with?',
                                  style: GlobalTextStyles.regularMediumW(
                                      context: context, fontSize: 16),
                                )
                              : Text(
                                  'Current Budget : Daily',
                                  style: GlobalTextStyles.regularMediumW(
                                      context: context, fontSize: 16),
                                ),
                          SizedBox(
                            height: 1.h,
                          ),
                          !controller.isEditing
                              ? Text(
                                  'NGN ${controller.amountFormatter.format(profile.currentUser.avaliableCash.toString())}',
                                  style: GlobalTextStyles.blueMediumText(
                                      context: context, fontSize: 20),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: !controller.isEditing ? 2.h : 0,
                          ),
                          controller.isEditing
                              ? EditTextField(
                                  textController: controller.cashController,
                                  padding: 5,
                                  fillingColor: Colors.transparent,
                                  onChange: (v) {},
                                )
                              : Text(
                                  "Amount Dispensed : NGN ${controller.amountFormatter.format(profile.currentUser.totalDepensedCashed.toString())}",
                                  style: const TextStyle(color: Colors.red),
                                ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GlobalButton(
                            background: GlobalColors.primaryGreen,
                            isDisabled: false,
                            foreground: GlobalColors.washedWhite,
                            title: controller.isEditing ? "Save" : 'Edit',
                            onPressed: () => controller.toggleEditing(context),
                          ),
                        ],
                      )),
                  // const VendorTabBar(),
                  SizedBox(
                    height: 2.h,
                  ),

                  //   const TransactionWidget()
                ],
              );
            }),
      ),
    );
  }

  Column twoText(
          {required String label,
          required String value,
          bool hasPercent = false}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: GlobalColors.globalWhite),
          ),
          SizedBox(
            height: 1.h,
          ),
          !hasPercent
              ? Text(value,
                  style: GlobalTextStyles.boldText(
                      color: GlobalColors.globalWhite,
                      context: context,
                      fontSize: 18))
              : Row(
                  children: [
                    Text(value,
                        style: GlobalTextStyles.boldText(
                            color: GlobalColors.globalWhite,
                            context: context,
                            fontSize: 18)),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      '%',
                      style: TextStyle(color: GlobalColors.globalWhite),
                    ),
                  ],
                )
        ],
      );
}

class VendorTabBar extends StatelessWidget {
  const VendorTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: GlobalSizes.globalHeight(context, 0.12),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              borderRadius: BorderRadius.circular(10),
              child: Icon(
                Icons.menu,
                size: 30,
                color: GlobalColors.primaryGreen,
              ),
            ),
            const SizedBox(
              width: 90,
              key: Key('__RIKEY1__'),
            ),
            const SwitchButtonWidget(
              key: Key("sjsss"),
            )
          ],
        ),
      ),
    );
  }
}
