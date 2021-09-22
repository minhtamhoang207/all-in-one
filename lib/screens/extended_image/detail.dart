import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'hero_widget.dart';

class SlidePage extends StatefulWidget {
  final String url;
  const SlidePage({this.url});
  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
  GlobalKey<ExtendedImageSlidePageState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ExtendedImageSlidePage(
        key: slidePagekey,
        child: GestureDetector(
          child: HeroWidget(
            child: ExtendedImage.network(
              widget.url,
              enableSlideOutPage: true,
              mode: ExtendedImageMode.gesture,

            ),
            tag: widget.url,
            slideType: SlideType.onlyImage,
            slidePagekey: slidePagekey,
          ),
          onTap: () {
            slidePagekey.currentState.popPage();
            Navigator.pop(context);
          },
        ),
        slideAxis: SlideAxis.both,
        slideType: SlideType.onlyImage,
      ),
    );
  }
}