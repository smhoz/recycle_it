import 'package:flutter/material.dart';
import 'package:hackathon_app/view/pages/home_page/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const HomeBody(),
    );
  }
}
