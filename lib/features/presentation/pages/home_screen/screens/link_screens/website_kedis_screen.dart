import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';

class WebsiteKedisScreen extends StatelessWidget {
  const WebsiteKedisScreen({super.key});

  Future<void> _launchURL() async {
    const url = 'http://www.kedis.kg/';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Не удалось открыть';
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0), // Высота AppBar
          child: AppBarWidget(
            nameAppBar: 'Наш сайт',
          ),
        ),
      body: ButtonWidget(
        text: 'Перейти на наш сайт',
        pressed: _launchURL,
      ),
    );
  }
}