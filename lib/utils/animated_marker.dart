import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AnimatedMarker extends StatelessWidget {
  final Marker marker;

  const AnimatedMarker({Key? key, required this.marker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: GoogleMapMarkerWidget(marker: marker),
    );
  }
}

class GoogleMapMarkerWidget extends StatelessWidget {
  final Marker marker;

  const GoogleMapMarkerWidget({super.key, required this.marker});

  @override
  Widget build(BuildContext context) {
    return BounceAnimation(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.location_on,
            size: 40,
            color: Colors.red, // Base marker color
          ),
          Positioned(
            bottom: 4,
            child: Text(
              marker.infoWindow.title ?? "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BounceAnimation extends StatefulWidget {
  final Widget child;

  const BounceAnimation({Key? key, required this.child}) : super(key: key);

  @override
  _BounceAnimationState createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0.8, end: 1.2)
        .chain(CurveTween(curve: Curves.bounceOut))
        .animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
