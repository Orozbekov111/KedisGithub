import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  Future<void> _launchURL() async {
    const url = 'https://drive.google.com/drive/folders/1rE2cfbx2tYWmIgEs9smFvU6ONwSdg2tI';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Не удалось открыть библиотеку';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0), // Высота AppBar
          child: AppBarWidget(
            nameAppBar: 'Библиотека',
          ),
        ),
      body: ButtonWidget(
        text: 'Открыть Google Drive',
        pressed: _launchURL,
      ),
    );
  }
}
