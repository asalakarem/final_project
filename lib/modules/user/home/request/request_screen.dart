import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/modules/user/home/request/map/user_map.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:image/image.dart' as img;

class RequestScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final dogCountController = TextEditingController();
  final descriptionController = TextEditingController();

  RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {
        if (state is MainCreateRequestSuccessState) {
          MainCubit.get(context).snackBar(
            context: context,
            title: 'Success',
            message: 'Request Created Successfully Follow Your Request Status',
            type: ContentType.success,
          );
          Navigator.pop(context);
          MainCubit.get(context).capturedImage = null;
        } else if (state is MainCreateRequestErrorState) {
          MainCubit.get(context).snackBar(
            context: context,
            title: 'Error',
            message: state.error,
            type: ContentType.failure,
          );
        }
        if (state is MainDogImageRejectedState)
        {
          MainCubit.get(context).snackBar(
            context: context,
            title: 'Error',
            message: 'This image is not dog',
            type: ContentType.failure,
          );
        }
      },
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xffF2EFEA),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InkWell(
                      onTap: () {
                        cubit.pickImage(context);
                      },
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image:
                              cubit.capturedImage != null
                                  ? DecorationImage(
                                    image: FileImage(
                                      File(cubit.capturedImage!.path),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                  : const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/pic_profile.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        depth: -5,
                        intensity: 0.8,
                        color: const Color(0xffE7E8D8),
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: TextFormField(
                        controller: addressController,
                        readOnly: true,
                        onTap: () {
                          navigateTo(
                            context,
                            UserMap(addressController: addressController),
                          );
                        },
                        decoration: const InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(
                            color: Color(0xff6C2C2C),
                            fontSize: 20.0,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        depth: -5,
                        intensity: 0.8,
                        color: const Color(0xffE7E8D8),
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: TextFormField(
                        controller: dogCountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Dogs Number',
                          hintStyle: TextStyle(
                            color: Color(0xff6C2C2C),
                            fontSize: 20.0,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter dogs number';
                          }
                          final number = int.tryParse(value);
                          if (number == null) {
                            return 'Please enter a valid number';
                          }
                          if (number == 0) {
                            return 'Number cannot be zero';
                          }
                          if (number >= 20) {
                            return 'Number cannot be more than 20';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      '**The number of dogs is an estimate and may not reflect the exact count.**',
                      style: TextStyle(
                        color: Color(0xff635C5C),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: -5,
                          intensity: 0.8,
                          color: const Color(0xffE7E8D8),
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12),
                          ),
                        ),
                        child: TextFormField(
                          maxLines: null,
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Add notes',
                            hintStyle: TextStyle(
                              color: Color(0xff6C2C2C),
                              fontSize: 20.0,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter description';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  defaultButton(
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        if (cubit.capturedImage != null) {
                          final originalBytes = await File(cubit.capturedImage!.path).readAsBytes();
                          final decodedImage = img.decodeImage(originalBytes);
                          final resized = img.copyResize(decodedImage!, width: 500);
                          final compressedBytes = img.encodeJpg(resized, quality: 50);
                          final base64Image = base64Encode(compressedBytes);
                          cubit.createRequest(
                            latitude: cubit.position!.latitude,
                            longitude: cubit.position!.longitude,
                            streetAddress: addressController.text,
                            dogCount: int.parse(dogCountController.text),
                            dogImage: base64Image,
                            description: descriptionController.text,
                          );
                        }
                      }
                    },
                    text: 'Request',
                    backgroundColor: const Color(
                      0xffAF6B58,
                    ).withValues(alpha: 0.92),
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
