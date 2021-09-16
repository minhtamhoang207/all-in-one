import 'package:flutter/material.dart';

class MyText extends StatefulWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextOverflow overflow;
  final TextAlign textAlign;
  MyText(
      {this.text,
      this.size,
      this.color,
      this.fontWeight,
      this.fontStyle,
      this.overflow,
      this.textAlign});
  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.size,
        fontWeight: widget.fontWeight,
        color: widget.color,
        fontStyle: widget.fontStyle,
      ),
      textAlign: widget.textAlign,
      overflow: widget.overflow,
    );
  }
}