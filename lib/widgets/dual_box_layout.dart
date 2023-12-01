import 'package:flutter/material.dart';

class DualBoxLayout extends StatelessWidget {
  const DualBoxLayout({
    super.key,
    required this.startBox,
    required this.endBox,
  });

  final Widget startBox;
  final Widget endBox;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: _BoxLayout(
                        child: startBox,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      flex: 3,
                      child: _BoxLayout(
                        child: endBox,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _BoxLayout(
                  child: startBox,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                _BoxLayout(
                  child: endBox,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class _BoxLayout extends StatelessWidget {
  const _BoxLayout({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
