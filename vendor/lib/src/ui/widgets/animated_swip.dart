import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class AnimatedSwipeToConfirm extends StatefulWidget {
  const AnimatedSwipeToConfirm({
    Key? key,
    this.height = 60,
    this.borderWidth = 3,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  final double? height;
  final double? borderWidth;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  _AnimatedSwipeToConfirmState createState() => _AnimatedSwipeToConfirmState();
}

class _AnimatedSwipeToConfirmState extends State<AnimatedSwipeToConfirm> {
  late double _maxWidth;
  late double _handleSize;
  double _dragValue = 0;
  double _dragWidth = 0;
  bool _confirmed = false;
  @override
  Widget build(BuildContext context) {
    _handleSize = (widget.height! - (widget.borderWidth! * 2));
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: LayoutBuilder(builder: (context, constraint) {
        _maxWidth = constraint.maxWidth;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: widget.height,
          decoration: BoxDecoration(
            color: _confirmed
                ? GlobalColors.errorColor
                : GlobalColors.primaryGreen.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: Text(
                    _confirmed
                        ? 'SWIPE LEFT TO GO OFFLINE'
                        : 'SWIPE RIGHT TO GO ONLINE',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: _dragWidth <= _handleSize ? _handleSize : _dragWidth,
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      GestureDetector(
                        onVerticalDragUpdate: _onDragUpdate,
                        onVerticalDragEnd: _onDragEnd,
                        child: Center(
                          child: Container(
                            height: _handleSize / 1.5,
                            padding: EdgeInsets.only(left: 2.w, right: 2.w),
                            child: RotationTransition(
                                turns: _confirmed
                                    ? const AlwaysStoppedAnimation(180 / 360)
                                    : const AlwaysStoppedAnimation(360 / 360),
                                child: Image.asset(
                                  'assets/images/fast-forward.png',
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragValue = (details.globalPosition.dx) / _maxWidth;
      _dragWidth = _maxWidth * _dragValue;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_dragValue > .9) {
      _dragValue = 1;
    } else {
      _dragValue = 0;
    }

    setState(() {
      _dragWidth = _maxWidth * _dragValue;
      _confirmed = _dragValue == 1;
    });

    if (_dragValue == 1) {
      widget.onConfirm();
    } else {
      widget.onCancel();
    }
  }
}
