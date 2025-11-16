import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/share/components/layouts/footer.dart';
import 'package:mobile/share/components/layouts/header.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            child,
            const Footer(),
          ],
        ),
      ),
    );
  }
}
