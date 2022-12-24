import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class InitialCircleAvatar extends StatefulWidget {
  final String text;
  final double elevation;
  final ImageProvider? backgroundImage;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  const InitialCircleAvatar({
    super.key,
    this.text = '',
    this.elevation = 0.0,
    this.backgroundImage,
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
    widget.backgroundImage
        ?.resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      if (mounted) {
        setState(() {
          _checkLoading = false;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _checkLoading == true
        ? Material(
            shape: const CircleBorder(),
            elevation: widget.elevation,
            child: CircleAvatar(
              minRadius: widget.minRadius,
              maxRadius: widget.maxRadius,
              radius: widget.radius,
              child: Text(getInitials(widget.text)),
            ),
          )
        : Material(
            shape: const CircleBorder(),
            elevation: widget.elevation,
            child: CircleAvatar(
              minRadius: widget.minRadius,
              maxRadius: widget.maxRadius,
              radius: widget.radius,
              backgroundImage: widget.backgroundImage,
            ),
          );
  }
}
