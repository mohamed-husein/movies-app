import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  const BlurContainer(
      {Key? key,
      required this.width,
      this.raduis = 0.0,
      required this.height,
      required this.child,
      this.topRight = 0,
      this.topLeft = 0,
      this.bottomRight = 0,
      this.bottomLeft = 0,
      this.raduisOnly = false})
      : super(key: key);

  final double width;
  final double height;
  final double raduis;
  final double topRight;
  final double topLeft;
  final double bottomRight;
  final double bottomLeft;
  final bool raduisOnly;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: raduisOnly
          ? BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeft),
              topLeft: Radius.circular(topLeft),
            )
          : BorderRadius.circular(raduis),
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        //we use Stack(); because we want the effects be on top of each other,
        //  just like layer in photoshop.
        child: Stack(
          children: [
            //blur effect ==> the third layer of stack
            BackdropFilter(
              filter: ImageFilter.blur(
                //sigmaX is the Horizontal blur
                sigmaX: 4.0,
                //sigmaY is the Vertical blur
                sigmaY: 4.0,
              ),
              //we use this container to scale up the blur effect to fit its
              //  parent, without this container the blur effect doesn't appear.
              child: Container(),
            ),
            //gradient effect ==> the second layer of stack

            Container(
              decoration: BoxDecoration(
                borderRadius: raduisOnly
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(bottomLeft),
                        bottomRight: Radius.circular(bottomRight),
                        topLeft: Radius.circular(topLeft),
                        topRight: Radius.circular(topRight),
                      )
                    : BorderRadius.circular(raduis),
                //shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    //begin color
                    Colors.white.withOpacity(0.15),
                    //end color
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
            ),
            //child ==> the first/top layer of stack
            Center(child: child),
          ],
        ),
      ),
    );
  }
}
