import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GlobalShimmerLoader extends StatelessWidget {
  GlobalShimmerLoader({
    Key? key,
  }) : super(key: key);

  final double sizeTwo = 1.5.h;
  final double sizeThree = 2.h;
  final double sizeFive = 3.h;
  final double sizeTen = 5.h;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeThree),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sizeTen),
              const FadeShimmer(
                height: 5,
                width: double.infinity,
                highlightColor: Color(0xffF9F9FB),
                baseColor: Color(0xffE6E8EB),
              ),
              SizedBox(height: sizeTwo),
              const FadeShimmer(
                height: 5,
                millisecondsDelay: 40,
                width: double.infinity,
                highlightColor: Color(0xffF9F9FB),
                baseColor: Color(0xffE6E8EB),
              ),
              SizedBox(height: sizeTwo),
              const FadeShimmer(
                height: 5,
                millisecondsDelay: 40,
                width: double.infinity,
                highlightColor: Color(0xffF9F9FB),
                baseColor: Color(0xffE6E8EB),
              ),
              Column(
                children: [
                  SizedBox(height: sizeFive),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FadeShimmer(
                        height: 60,
                        width: 60,
                        highlightColor: Color(0xffF9F9FB),
                        baseColor: Color(0xffE6E8EB),
                      ),
                      SizedBox(width: sizeTwo),
                      Expanded(
                        child: Column(
                          children: [
                            const FadeShimmer(
                              height: 5,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: sizeFive),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FadeShimmer(
                        height: 60,
                        width: 60,
                        highlightColor: Color(0xffF9F9FB),
                        baseColor: Color(0xffE6E8EB),
                      ),
                      SizedBox(width: sizeTwo),
                      Expanded(
                        child: Column(
                          children: [
                            const FadeShimmer(
                              height: 5,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: sizeFive),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FadeShimmer(
                        height: 60,
                        width: 60,
                        highlightColor: Color(0xffF9F9FB),
                        baseColor: Color(0xffE6E8EB),
                      ),
                      SizedBox(width: sizeTwo),
                      Expanded(
                        child: Column(
                          children: [
                            const FadeShimmer(
                              height: 5,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            SizedBox(height: sizeTwo),
                            const FadeShimmer(
                              height: 5,
                              millisecondsDelay: 40,
                              width: double.infinity,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: sizeFive),
              const FadeShimmer(
                height: 150,
                millisecondsDelay: 40,
                width: double.infinity,
                highlightColor: Color(0xffF9F9FB),
                baseColor: Color(0xffE6E8EB),
              ),
              SizedBox(height: sizeFive),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeShimmer(
                    height: 60,
                    width: 60,
                    highlightColor: Color(0xffF9F9FB),
                    baseColor: Color(0xffE6E8EB),
                  ),
                  SizedBox(width: sizeTwo),
                  Expanded(
                    child: Column(
                      children: [
                        const FadeShimmer(
                          height: 5,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: sizeFive),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeShimmer(
                    height: 60,
                    width: 60,
                    highlightColor: Color(0xffF9F9FB),
                    baseColor: Color(0xffE6E8EB),
                  ),
                  SizedBox(width: sizeTwo),
                  Expanded(
                    child: Column(
                      children: [
                        const FadeShimmer(
                          height: 5,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: sizeFive),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeShimmer(
                    height: 60,
                    width: 60,
                    highlightColor: Color(0xffF9F9FB),
                    baseColor: Color(0xffE6E8EB),
                  ),
                  SizedBox(width: sizeTwo),
                  Expanded(
                    child: Column(
                      children: [
                        const FadeShimmer(
                          height: 5,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: sizeFive),
              const FadeShimmer(
                height: 150,
                millisecondsDelay: 40,
                width: double.infinity,
                highlightColor: Color(0xffF9F9FB),
                baseColor: Color(0xffE6E8EB),
              ),
              SizedBox(height: sizeFive),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeShimmer(
                    height: 60,
                    width: 60,
                    highlightColor: Color(0xffF9F9FB),
                    baseColor: Color(0xffE6E8EB),
                  ),
                  SizedBox(width: sizeTwo),
                  Expanded(
                    child: Column(
                      children: [
                        const FadeShimmer(
                          height: 5,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: sizeFive),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeShimmer(
                    height: 60,
                    width: 60,
                    highlightColor: Color(0xffF9F9FB),
                    baseColor: Color(0xffE6E8EB),
                  ),
                  SizedBox(width: sizeTwo),
                  Expanded(
                    child: Column(
                      children: [
                        const FadeShimmer(
                          height: 5,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: sizeFive),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeShimmer(
                    height: 60,
                    width: 60,
                    highlightColor: Color(0xffF9F9FB),
                    baseColor: Color(0xffE6E8EB),
                  ),
                  SizedBox(width: sizeTwo),
                  Expanded(
                    child: Column(
                      children: [
                        const FadeShimmer(
                          height: 5,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                        SizedBox(height: sizeTwo),
                        const FadeShimmer(
                          height: 5,
                          millisecondsDelay: 40,
                          width: double.infinity,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
