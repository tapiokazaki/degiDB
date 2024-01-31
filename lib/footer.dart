import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final void Function(int) onItemTapped; // 追加: onItemTappedパラメータ

  const Footer({required this.onItemTapped}); // 追加: コンストラクタ

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph),
          label: 'graph',
        ),
      ],
      onTap: widget.onItemTapped, // 追加: onTapをonItemTappedに変更
    );
  }
}
