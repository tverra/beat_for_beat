import 'package:flutter/material.dart';

typedef FutureCallback = Future<dynamic> Function();

class AsyncElevatedButton extends StatefulWidget {
  const AsyncElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final FutureCallback? onPressed;
  final Widget child;

  @override
  State<AsyncElevatedButton> createState() => _AsyncElevatedButtonState();
}

class _AsyncElevatedButtonState extends State<AsyncElevatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final FutureCallback? onPressed = widget.onPressed;

    return ElevatedButton(
      onPressed: !_isPressed && onPressed != null
          ? () async => _callback(onPressed)
          : null,
      child: widget.child,
    );
  }

  Future<void> _callback(FutureCallback callback) async {
    setState(() => _isPressed = true);
    await callback();
    setState(() => _isPressed = false);
  }
}
