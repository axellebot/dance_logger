import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class InitialCircleAvatar extends StatefulWidget {
  final String text;
  final ImageProvider? image;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  const InitialCircleAvatar({
    super.key,
    this.text = '',
    this.image,
    this.radius,
    this.minRadius,
    this.maxRadius,
  }) : assert(radius == null || (minRadius == null && maxRadius == null));

  @override
  State<InitialCircleAvatar> createState() => _InitialCircleAvatarState();
}

class _InitialCircleAvatarState extends State<InitialCircleAvatar> {
  bool _checkLoading = true;

  @override
  void initState() {
    super.initState();
    widget.image?.resolve(const ImageConfiguration()).addListener(ImageStreamListener((image, synchronousCall) {
      if (mounted) {
        setState(() {
          _checkLoading = false;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: widget.minRadius,
      maxRadius: widget.maxRadius,
      radius: widget.radius,
      backgroundImage: (!_checkLoading) ? widget.image : null,
      child: (_checkLoading)
          ? Center(
              child: Text(
                getInitials(widget.text),
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }
}
