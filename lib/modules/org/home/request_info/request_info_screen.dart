import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/org/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image/image.dart' as img;

class RequestInfoScreen extends StatelessWidget {
  final int requestId;
  final int assignmentId;
  final int numberExtraTimeUsed;
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final dogNumberController = TextEditingController();
  final streetAddressController = TextEditingController();
  final noteController = TextEditingController();

  final ngoDogsCountController = TextEditingController();
  final ngoDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RequestInfoScreen({
    super.key,
    required this.requestId,
    required this.assignmentId,
    required this.numberExtraTimeUsed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrgCubit, OrgStates>(
      listener: (BuildContext context, OrgStates state) {
        if (state is OrgAcceptRequestButtonSuccessState) {
          OrgCubit.get(context).snackBar(
            context: context,
            title: 'Success',
            message: 'Request Accepted Successfully',
            type: ContentType.success,
          );
          Navigator.pop(context);
          OrgCubit.get(context).capturedImages.remove(requestId);
        }
        if (state is OrgMissionDoneButtonSuccessState) {
          OrgCubit.get(context).snackBar(
            context: context,
            title: 'Success',
            message: 'Request Done Successfully',
            type: ContentType.success,
          );
          Navigator.pop(context);
        }
        if (state is OrgExtraTimeButtonSuccessState) {
          OrgCubit.get(context).snackBar(
            context: context,
            title: 'Success',
            message: 'Extra Time Added Successfully',
            type: ContentType.success,
          );
        }
      },
      bloc: OrgCubit.get(context)..getRequestInfo(requestId: requestId),
      builder: (BuildContext context, OrgStates state) {
        final cubit = OrgCubit.get(context);
        final model = cubit.requestModel;
        if (state is OrgGetRequestInfoLoadingState || model == null) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: Colors.white,
              size: 50,
            ),
          );
        }
        userNameController.text = model.userName ?? '';
        phoneController.text = model.phoneNumber.toString();
        dogNumberController.text = model.dogsCount.toString();
        streetAddressController.text = model.streetAddress ?? '';
        noteController.text = model.description ?? '';
        return Scaffold(
          key: scaffoldKey,
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xffF2EFEA),
          ),
          body: SingleChildScrollView(
            child: Column(
              spacing: 10.0,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Requests: ${model.requestId}',
                        style: GoogleFonts.aclonica(
                          fontSize: 40.0,
                          color: const Color(0xff6C2C2C),
                        ),
                      ),
                    ),
                    myDivider(color: const Color(0xff6C2C2C)),
                  ],
                ),
                Row(
                  spacing: 7,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child:
                              model.dogImage != null
                                  ? Image.memory(
                                    base64Decode('${model.dogImage}'),
                                    fit: BoxFit.cover,
                                  )
                                  : const Center(child: Text('لا توجد صورة')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 15,
                        children: [
                          Neumorphic(
                            style: NeumorphicStyle(
                              depth: -5,
                              intensity: 0.8,
                              color: const Color(
                                0xffE7E8D8,
                              ).withValues(alpha: 0.41),
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12),
                              ),
                            ),
                            child: TextFormField(
                              controller: userNameController,
                              decoration: const InputDecoration(
                                label: Text(
                                  'User Name',
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
                              depth: -5,
                              intensity: 0.8,
                              color: const Color(
                                0xffE7E8D8,
                              ).withValues(alpha: 0.41),
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
                          Neumorphic(
                            style: NeumorphicStyle(
                              depth: -5,
                              intensity: 0.8,
                              color: const Color(
                                0xffE7E8D8,
                              ).withValues(alpha: 0.41),
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12),
                              ),
                            ),
                            child: TextFormField(
                              controller: dogNumberController,
                              decoration: const InputDecoration(
                                label: Text(
                                  'Dogs Number',
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
                          const Text(
                            '**The number of dogs is an estimate and may not reflect the exact count.**',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: -5,
                      intensity: 0.8,
                      color: const Color(0xffE7E8D8).withValues(alpha: 0.41),
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12),
                      ),
                    ),
                    child: TextFormField(
                      controller: streetAddressController,
                      readOnly: true,
                      onTap: () async {
                        final double? latitude = model.latitude;
                        final double? longitude = model.longitude;
                        final url =
                            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          throw 'Could not open the map.';
                        }
                      },
                      decoration: const InputDecoration(
                        label: Text(
                          'Address',
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
                ),
                SizedBox(
                  height: 108,
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
                        controller: noteController,
                        decoration: const InputDecoration(
                          label: Text('Note'),
                          labelStyle: TextStyle(
                            color: Color(0xff6C2C2C),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
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
                      ),
                    ),
                  ),
                ),
                if (model.status == 'Inprogress') ...[
                  const SizedBox(height: 20.0),
                  defaultButton(
                    function: () {
                      cubit.acceptRequestButton(assignmentId: assignmentId);
                    },
                    height: 45.0,
                    fontSize: 28.0,
                    text: 'Accept Request ...',
                    backgroundColor: const Color(0xffAF6B58),
                  ),
                ],
                if (model.status == 'Accepted') ...[
                  if (numberExtraTimeUsed != 2) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17.0,
                        vertical: 10.0,
                      ),
                      child: DropdownMenu<String>(
                        width: double.infinity,
                        label: const Text(
                          'Need more time?',
                          style: TextStyle(
                            color: Color(0xFF795548),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        textStyle: const TextStyle(color: Color(0xFF795548)),
                        dropdownMenuEntries: cubit.extraTimeList,
                        inputDecorationTheme: InputDecorationTheme(
                          filled: true,
                          fillColor: const Color(0xFFE7E8D8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIconColor: const Color(0xFF5D2B1A),
                        ),
                        onSelected: (String? value) {
                          cubit.selectedTime = value;
                        },
                      ),
                    ),
                    defaultButton(
                      function: () {
                        if (cubit.selectedTime != null) {
                          cubit.extraTimeButton(
                            assignmentId: assignmentId,
                            extraNeededDays: int.tryParse(cubit.selectedTime!),
                          );
                        } else {
                          cubit.snackBar(
                            context: context,
                            title: 'Error',
                            message: 'Please select time',
                            type: ContentType.failure,
                          );
                        }
                      },
                      height: 45.0,
                      fontSize: 28.0,
                      text: 'Extend',
                      foregroundColor: const Color(0xff6C2C2C),
                      backgroundColor: const Color(0xffE7E8D8),
                    ),
                  ],
                  defaultButton(
                    function: () {
                      scaffoldKey.currentState!.showBottomSheet(
                        showDragHandle: true,
                        backgroundColor: Colors.grey[200],
                        (context) => SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              spacing: 20.0,
                              children: [
                                BlocConsumer<OrgCubit, OrgStates>(
                                  listener: (context, state) {
                                    if (state is OrgDogImageRejectedState) {
                                      OrgCubit.get(context).snackBar(
                                        context: context,
                                        title: 'Error',
                                        message: 'This image is not dog',
                                        type: ContentType.failure,
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  builder: (context, state) {
                                    final cubit = OrgCubit.get(context);
                                    final capturedImage =
                                        cubit.capturedImages[requestId];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.pickImage(requestId);
                                        },
                                        child: Container(
                                          height: 150.0,
                                          width: 150.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12.0,
                                            ),
                                            image:
                                                capturedImage != null
                                                    ? DecorationImage(
                                                      image: FileImage(
                                                        File(
                                                          capturedImage.path,
                                                        ),
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
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: -5,
                                      intensity: 0.8,
                                      color: const Color(
                                        0xffE7E8D8,
                                      ).withValues(alpha: 0.41),
                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: ngoDogsCountController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          'Taken Dogs Number',
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
                                ),
                                SizedBox(
                                  height: 108,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
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
                                        controller: ngoDescriptionController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          label: Text('Note'),
                                          labelStyle: TextStyle(
                                            color: Color(0xff6C2C2C),
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                      ),
                                    ),
                                  ),
                                ),
                                defaultButton(
                                  function: () async {
                                    if (formKey.currentState!.validate()) {
                                      final capturedImage =
                                          cubit.capturedImages[requestId];
                                      final currentPosition = cubit.position;
                                      if (capturedImage != null &&
                                          currentPosition != null) {
                                        final originalBytes =
                                            await File(
                                              capturedImage.path,
                                            ).readAsBytes();
                                        final decodedImage = img.decodeImage(
                                          originalBytes,
                                        );
                                        final resized = img.copyResize(
                                          decodedImage!,
                                          width: 500,
                                        );
                                        final compressedBytes = img.encodeJpg(
                                          resized,
                                          quality: 50,
                                        );
                                        final base64Image = base64Encode(
                                          compressedBytes,
                                        );
                                        final latitude =
                                            currentPosition.latitude;
                                        final longitude =
                                            currentPosition.longitude;
                                        cubit.missionDoneButton(
                                          assignmentId: assignmentId,
                                          ngoDogsCount: int.parse(
                                            ngoDogsCountController.text,
                                          ),
                                          description:
                                              ngoDescriptionController.text,
                                          image: base64Image,
                                          latitude: latitude,
                                          longitude: longitude,
                                        );
                                      }
                                    }
                                  },
                                  height: 45.0,
                                  fontSize: 28.0,
                                  horizontal: 10.0,
                                  text: 'Done',
                                  foregroundColor: const Color(0xffEDDED9),
                                  backgroundColor: const Color(
                                    0xffAF6B58,
                                  ).withOpacity(0.92),
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    height: 45.0,
                    fontSize: 28.0,
                    text: 'Next to be Done',
                    foregroundColor: const Color(0xffEDDED9),
                    backgroundColor: const Color(0xffAF6B58).withOpacity(0.92),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
