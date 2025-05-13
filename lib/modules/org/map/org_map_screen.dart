import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/org/cubit/states.dart';
import 'package:untitled1/modules/org/login/org_login_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class MapScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String phone;

  const MapScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: OrgCubit.get(context)..determinePosition(),
      child: BlocConsumer<OrgCubit, OrgStates>(
        listener: (BuildContext context, OrgStates state) {
          if (state is OrgSignUpSuccessState) {
            navigateAndFinish(context, OrgLoginScreen());
            OrgCubit.get(context).snackBar(
              context: context,
              title: 'Sign Up Success',
              message: 'Wait for admin approval',
              type: ContentType.success,
            );
          }
          if (state is OrgSignUpErrorState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, OrgStates state) {
          final cubit = OrgCubit.get(context);

          if (state is OrgLocationLoadingStates) {
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.white,
                  size: 50,
                ),
              ),
            );
          }

          if (cubit.position == null) {
            return const Scaffold(
              body: Center(child: Text("تعذر الحصول على الموقع الحالي")),
            );
          }

          final markers = {
            Marker(
              markerId: const MarkerId('current_location'),
              position: LatLng(
                cubit.position!.latitude,
                cubit.position!.longitude,
              ),
              infoWindow: const InfoWindow(title: 'موقعي الحالي'),
            ),
          };

          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    compassEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        cubit.position!.latitude,
                        cubit.position!.longitude,
                      ),
                      zoom: 16,
                    ),
                    markers: markers,
                    onMapCreated: (GoogleMapController controller) {
                      cubit.setMapController(controller);
                    },
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    right: 20,
                    child: defaultButton(
                      function: () async {
                        final address = await cubit.reverseGeocoding(
                          latitude: cubit.position!.latitude,
                          longitude: cubit.position!.longitude,
                        );
                        cubit.signUp(
                          name: name,
                          email: email,
                          password: password,
                          phone: int.parse(phone),
                          latitude: cubit.position!.latitude,
                          longitude: cubit.position!.longitude,
                          address: address.streetAddress ?? 'شارع غير معروف',
                        );
                      },
                      text: 'Save Address',
                      foregroundColor: Colors.white,
                      fontSize: 20.0,
                      backgroundColor: Colors.teal.shade600.withOpacity(0.9),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        cubit.determinePosition();
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.my_location, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
