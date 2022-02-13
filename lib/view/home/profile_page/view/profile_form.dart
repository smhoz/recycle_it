import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/core/components/button/custom_rounded_button.dart';
import 'package:hackathon_app/core/components/text/input_field.dart';

import '../viewmodel/cubit/profileform_cubit.dart';

class ProfileForm extends StatelessWidget {
  ProfileForm({Key? key}) : super(key: key);
  final _cubit = ProfileformCubit();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Form(
        key: _cubit.formKey,
        child: Column(
          children: [
            InputField(
              title: "Ad",
              icon: const Icon(Icons.person),
              onChanged: _cubit.onFieldChanged,
              controller: _cubit.nameController,
            ),
            InputField(
              title: "Soyad",
              icon: const Icon(Icons.person),
              onChanged: _cubit.onFieldChanged,
              controller: _cubit.surnameController,
            ),
            InputField(
              title: "Email",
              icon: const Icon(Icons.mail),
              onChanged: _cubit.onFieldChanged,
              controller: _cubit.mailController,
            ),
            BlocBuilder(
              bloc: _cubit,
              builder: (context, state) {
                if (state is ProfileformLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return CustomRoundedButton(
                      onTap: state is ProfileformButtonActive
                          ? () => _cubit.update()
                          : null,
                      icon: const Icon(Icons.send),
                      title: 'Güncelle');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
