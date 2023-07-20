import 'package:flutter/material.dart';

class AboutComponent extends StatefulWidget {
  final String title, descriptions;
  final Image img;

  const AboutComponent(
      {super.key,
      required this.title,
      required this.descriptions,
      required this.img});
  @override
  _AboutComponentState createState() => _AboutComponentState();
}

class _AboutComponentState extends State<AboutComponent> {
  static const double padding = 20;
  static const double avatarRadius = 45;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: padding,
              top: avatarRadius + padding,
              right: padding,
              bottom: padding),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  widget.descriptions,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
                child: widget.img),
          ),
        ),
      ],
    );
  }
}
