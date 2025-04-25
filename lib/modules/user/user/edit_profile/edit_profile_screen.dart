import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {
        if (state is MainUpdateUserSuccessState) {
          MainCubit.get(context).snackBar(
            context: context,
            title: 'Success',
            message: 'User Updated Successfully',
            type: ContentType.success,
          );
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        final loginModel = cubit.loginModel;
        firstNameController.text = loginModel?.firstName ?? '';
        lastNameController.text = loginModel?.lastName ?? '';
        emailController.text = loginModel?.email ?? '';
        phoneController.text = loginModel?.phoneNumber?.toString() ?? '';
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xffF2EFEA),
            label: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.updateUser(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      phone: int.parse(phoneController.text),
                    );
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffC79E9E),
                  ),
                ),
              ),
            ],
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: 0,
                      intensity: 0.8,
                      color: const Color(0xffD19E9E).withValues(alpha: 0.41),
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12),
                      ),
                    ),
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        label: Text(
                          'First Name',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6C2C2C),
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: 0,
                      intensity: 0.8,
                      color: const Color(0xffD19E9E).withValues(alpha: 0.41),
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12),
                      ),
                    ),
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Last Name',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6C2C2C),
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: 0,
                      intensity: 0.8,
                      color: const Color(0xffD19E9E).withValues(alpha: 0.41),
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12),
                      ),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6C2C2C),
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: 0,
                      intensity: 0.8,
                      color: const Color(0xffD19E9E).withValues(alpha: 0.41),
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12),
                      ),
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6C2C2C),
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
