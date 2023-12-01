import 'package:flutter/material.dart';

extension AsyncSnapshotUtilities on AsyncSnapshot<dynamic> {
  bool get hasConnection => connectionState == ConnectionState.none;

  bool get waiting => connectionState == ConnectionState.waiting;

  bool get active => connectionState == ConnectionState.active;

  bool get isDone => connectionState == ConnectionState.done;
}
