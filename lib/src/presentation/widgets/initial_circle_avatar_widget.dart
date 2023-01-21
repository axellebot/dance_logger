import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class InitialCircleAvatar extends StatefulWidget {
  final String text;
  final ImageProvider? backgroundImage;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  const InitialCircleAvatar({
    super.key,
    this.text = '',
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
    return CircleAvatar(
      minRadius: widget.minRadius,
      maxRadius: widget.maxRadius,
      radius: widget.radius,
      backgroundImage: (!_checkLoading) ? widget.backgroundImage : null,
      child: (_checkLoading) ? Text(getInitials(widget.text)) : null,
    );
  }
}
