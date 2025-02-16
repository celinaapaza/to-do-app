//Flutter imports:
import 'package:flutter/material.dart';

import '../../../utils/k_colors.dart';

//Project imports:

class SwitchThemeComponent extends StatefulWidget {
  final bool isDarkMode;
  final Function onTap;
  const SwitchThemeComponent({
    required this.isDarkMode,
    required this.onTap,
    super.key,
  });

  @override
  State<SwitchThemeComponent> createState() => _SwitchThemeComponentState();
}

class _SwitchThemeComponentState extends State<SwitchThemeComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  void onTap() {
    if (!_animationController.isAnimating) {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    } else {
      if (_animationController.status == AnimationStatus.forward) {
        _animationController.reverse(from: _animationController.value);
      } else if (_animationController.status == AnimationStatus.reverse) {
        _animationController.forward(from: _animationController.value);
      }
    }

    widget.onTap();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = Tween<double>(
      begin: widget.isDarkMode ? 213 : 0,
      end: widget.isDarkMode ? 0 : 213,
    ).animate(_animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: AnimatedContainer(
          height: 60,
          duration: const Duration(milliseconds: 1000),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  widget.isDarkMode
                      ? [kColorBlueT1, kColorBlue]
                      : [kColorBlueL1, kColorBlueL2],
            ),
          ),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder:
                    (context, child) => Transform.translate(
                      offset: Offset(_animation.value, 0),
                      child: child,
                    ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: widget.isDarkMode ? kColorGreyL1 : kColorYellowL1,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color:
                            widget.isDarkMode ? kColorGreyL1 : kColorYellowL1,
                        blurRadius: 20,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: 250,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.bottomRight,
                          colors:
                              widget.isDarkMode
                                  ? [kColorGreenT3, kColorGreenT1]
                                  : [kColorGreenL1, kColorGreenT2],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path =
        Path()
          ..moveTo(0, size.height)
          ..quadraticBezierTo(size.width * 0.5, 0, size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
