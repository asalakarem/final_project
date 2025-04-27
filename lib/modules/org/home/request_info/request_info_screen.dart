import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/org/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestInfoScreen extends StatelessWidget {
  final int requestId;
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final dogNumberController = TextEditingController();
  final streetAddressController = TextEditingController();
  final noteController = TextEditingController();

  RequestInfoScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgCubit, OrgStates>(
      bloc: OrgCubit.get(context)..getRequestInfo(requestId: requestId),
      builder: (BuildContext context, OrgStates state) {
        final cubit = OrgCubit.get(context);
        final model = cubit.requestModel;
        if (state is OrgGetRequestInfoLoadingState || model == null) {
          return const Center(child: CircularProgressIndicator());
        }
        userNameController.text = model.userName ?? '';
        phoneController.text = model.phoneNumber?.toString() ?? '';
        dogNumberController.text = model.dogsCount?.toString() ?? '';
        streetAddressController.text = model.streetAddress ?? '';
        noteController.text = model.description ?? '';
        return Scaffold(
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
                          child: Image.asset(
                            'assets/images/pic_profile.jpg',
                            fit: BoxFit.cover,
                          ),
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
                const SizedBox(height: 20.0),
                if (model.status == 'Inprogress')
                  defaultButton(
                    function: () {},
                    text: 'Accept Request ...',
                    backgroundColor: const Color(0xffAF6B58),
                  ),
                if (model.status == 'Accepted')
                  defaultButton(
                    function: () {},
                    text: 'Done',
                    foregroundColor: const Color(0xff6C2C2C),
                    backgroundColor: const Color(0xffE7E8D8),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
