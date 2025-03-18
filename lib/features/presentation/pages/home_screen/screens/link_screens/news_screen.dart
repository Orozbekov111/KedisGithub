import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});


    Future<void> _launchURL() async {
    const url = 'http://www.kedis.kg/blog';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Не удалось открыть новострую ленту';
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0), // Высота AppBar
          child: AppBarWidget(
            nameAppBar: 'Новости',
          ),
        ),
      body: ButtonWidget(
        text: 'Актуальные новости',
        pressed: _launchURL,
      ),
    );
  }
}