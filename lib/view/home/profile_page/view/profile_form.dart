import 'package:flutter/material.dart';
import '../../_product/widgets/profile/profile_field.dart';
import '../../../../core/components/text/input_field.dart';

import '../viewmodel/cubit/profileform_cubit.dart';

class ProfileForm extends StatelessWidget {
  ProfileForm({Key? key}) : super(key: key);
  final _cubit = ProfileformCubit();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _cubit.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileField(
            textTitle: "Name",
            textBody: _cubit.nameController.text,
            iconData: Icons.person,
            inputField: InputField(
              title: "Name",
              icon: const Icon(Icons.person),
              onChanged: _cubit.onFieldChanged,
              controller: _cubit.nameController,
            ),
          ),
          ProfileField(
            textTitle: "Surname",
            textBody: _cubit.surnameController.text,
            iconData: Icons.person,
            inputField: InputField(
              title: "Surname",
              icon: const Icon(Icons.person),
              onChanged: _cubit.onFieldChanged,
              controller: _cubit.surnameController,
            ),
          ),
          ProfileField(
            textTitle: "Email",
            textBody: _cubit.mailController.text,
            iconData: Icons.mail,
            inputField: InputField(
              title: "Email",
              icon: const Icon(Icons.mail),
              onChanged: _cubit.onFieldChanged,
              controller: _cubit.mailController,
              readOnly: true,
            ),
          ),

          /*  BlocBuilder(
            bloc: _cubit,
            builder: (context, state) {
              if (state is ProfileformLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CustomRoundedButton(onTap: state is ProfileformButtonActive ? () => _cubit.update() : null, title: 'Güncelle');
              }
            },
          )*/
        ],
      ),
    );
  }
}
