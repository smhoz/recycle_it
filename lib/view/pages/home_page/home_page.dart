import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hackathon_app/view/pages/home_page/cubit/home_cubit.dart';
import 'package:hackathon_app/view/pages/home_page/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = HomeCubit();
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: const HomeBody(),
      ),
      bottomNavigationBar: _BottomNavigationBar(_cubit),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar(
    this.homeCubit, {
    Key? key,
  }) : super(key: key);
  final HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
          currentIndex: homeCubit.state.index,
          selectedItemColor: Colors.red,
          onTap: homeCubit.onIndexChange,
        );
      },
    );
  }
}
