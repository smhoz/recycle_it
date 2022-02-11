import 'package:flutter/material.dart';
import 'package:hackathon_app/core/repository/global_repositor.dart';
import 'package:hackathon_app/core/utils/locator_get_it.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = getIt<GlobalRepository>().user;
    return Center(
      child: Text(_user?.surname ?? ""),
    );
  }
}
