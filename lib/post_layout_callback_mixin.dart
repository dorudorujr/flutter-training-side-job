import 'package:flutter/material.dart';

/// レイアウトが表示された後に処理を行うためのMixin
mixin PostLayoutCallbackMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    _executeAfterLayout();
  }

  /// レイアウト表示後に実行する処理
  /// サブクラスでこのメソッドをオーバーライドして実行したい処理を記述する
  void onPostLayout();

  Future<void> _executeAfterLayout() async {
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) {
      onPostLayout();
    }
  }
}
