import 'package:flutter/material.dart';

/// Animation utilities for micro-interactions
class AppAnimations {
  // Private constructor
  AppAnimations._();

  /// Scale animation (for button press, task completion)
  static Widget scaleAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return ScaleAnimationWidget(child: child, duration: duration);
  }

  /// Fade animation (for screen transitions)
  static Widget fadeAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return FadeAnimationWidget(child: child, duration: duration);
  }

  /// Slide animation (for items entering)
  static Widget slideAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 400),
    Offset beginOffset = const Offset(0, 0.3),
  }) {
    return SlideAnimationWidget(
      child: child,
      duration: duration,
      beginOffset: beginOffset,
    );
  }

  /// Bounce animation (for streak notifications)
  static Widget bounceAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 600),
  }) {
    return BounceAnimationWidget(child: child, duration: duration);
  }

  /// Pulse animation (for progress indicators, badges)
  static Widget pulseAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return PulseAnimationWidget(child: child, duration: duration);
  }

  /// Rotation animation (for timer countdown visual)
  static Widget rotationAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 800),
  }) {
    return RotationAnimationWidget(child: child, duration: duration);
  }

  /// Shake animation (for error states)
  static Widget shakeAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return ShakeAnimationWidget(child: child, duration: duration);
  }

  /// Flip animation (for task completion check)
  static Widget flipAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return FlipAnimationWidget(child: child, duration: duration);
  }
}

/// Scale Animation Implementation
class ScaleAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ScaleAnimationWidget({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<ScaleAnimationWidget> createState() => _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState extends State<ScaleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scaleAnimation, child: widget.child);
  }
}

/// Fade Animation Implementation
class FadeAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeAnimationWidget({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<FadeAnimationWidget> createState() => _FadeAnimationWidgetState();
}

class _FadeAnimationWidgetState extends State<FadeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fadeAnimation, child: widget.child);
  }
}

/// Slide Animation Implementation
class SlideAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset beginOffset;

  const SlideAnimationWidget({
    super.key,
    required this.child,
    required this.duration,
    required this.beginOffset,
  });

  @override
  State<SlideAnimationWidget> createState() => _SlideAnimationWidgetState();
}

class _SlideAnimationWidgetState extends State<SlideAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _slideAnimation = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _slideAnimation, child: widget.child);
  }
}

/// Bounce Animation Implementation
class BounceAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const BounceAnimationWidget({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<BounceAnimationWidget> createState() => _BounceAnimationWidgetState();
}

class _BounceAnimationWidgetState extends State<BounceAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _bounceAnimation, child: widget.child);
  }
}

/// Pulse Animation Implementation
class PulseAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const PulseAnimationWidget({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<PulseAnimationWidget> createState() => _PulseAnimationWidgetState();
}

class _PulseAnimationWidgetState extends State<PulseAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _pulseAnimation, child: widget.child);
  }
}

/// Rotation Animation Implementation
class RotationAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const RotationAnimationWidget({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<RotationAnimationWidget> createState() =>
      _RotationAnimationWidgetState();
}

class _RotationAnimationWidgetState extends State<RotationAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _rotationAnimation, child: widget.child);
  }
}

/// Shake Animation Implementation
class ShakeAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ShakeAnimationWidget({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<ShakeAnimationWidget> createState() => _ShakeAnimationWidgetState();
}

class _ShakeAnimationWidgetState extends State<ShakeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double distance = 10.0;
    var curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    );

    return AnimatedBuilder(
      animation: curvedAnimation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(distance * (sin(curvedAnimation.value * 4 * 3.14159)), 0),
          child: child,
        );
      },
    );
  }
}

/// Flip Animation Implementation
class FlipAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FlipAnimationWidget({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<FlipAnimationWidget> createState() => _FlipAnimationWidgetState();
}

class _FlipAnimationWidgetState extends State<FlipAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      child: widget.child,
      builder: (context, child) {
        final angle = _flipAnimation.value * 3.14159;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: child,
        );
      },
    );
  }
}

// Helper function for sin calculation
double sin(double x) => (x - x * x * x / 6 + x * x * x * x * x / 120).toDouble();
