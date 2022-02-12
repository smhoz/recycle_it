import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/view/pages/home_page/components/profile_component/profile_form/cubit/profileform_cubit.dart';
import 'package:hackathon_app/view/widgets/_custom_text_field.dart';

import '../../../../../widgets/_widget_const.dart';

class ProfileForm extends StatelessWidget {
  ProfileForm({Key? key}) : super(key: key);
  final _tpDivider = WC.tpDivider;
  final _cubit = ProfileformCubit();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: WC.paddingAll(
        child: Form(
          key: _cubit.formKey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: "Name",
                onChanged: _cubit.onFieldChanged,
                controller: _cubit.nameController,
              ),
              _tpDivider,
              CustomTextFormField(
                labelText: "Surname",
                onChanged: _cubit.onFieldChanged,
                controller: _cubit.surnameController,
              ),
              _tpDivider,
              CustomTextFormField(
                labelText: "Mail",
                onChanged: _cubit.onFieldChanged,
                controller: _cubit.mailController,
              ),
              _tpDivider,
              BlocBuilder(
                bloc: _cubit,
                builder: (context, state) {
                  if (state is ProfileformLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ElevatedButton.icon(
                        onPressed: state is ProfileformButtonActive
                            ? () => _cubit.update()
                            : null,
                        icon: const Icon(Icons.send),
                        label: const Text('Submit'));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
