import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    return BlocConsumer<OrgCubit, OrgStates>(
      listener: (BuildContext context, OrgStates state) {
        if (state is OrgSignUpSuccessState) {
          navigateAndFinish(context, OrgLoginScreen());
        }
      },
      builder: (BuildContext context, OrgStates state) {
        var cubit = OrgCubit.get(context);

        if (state is OrgLoadingStates) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        Set<Marker> markers = {};

        if (cubit.position != null) {
          markers.add(
            Marker(
              markerId: const MarkerId('current_location'),
              position: LatLng(
                cubit.position!.latitude,
                cubit.position!.longitude,
              ),
              infoWindow: const InfoWindow(title: 'موقعي الحالي'),
            ),
          );
        }

        return SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition:
                    cubit.position != null
                        ? CameraPosition(
                          target: LatLng(
                            cubit.position!.latitude,
                            cubit.position!.longitude,
                          ),
                          zoom: 16,
                        )
                        : const CameraPosition(
                          target: LatLng(37.42796133580664, -122.085749655962),
                          zoom: 14.4746,
                        ),
                markers: markers,
                onMapCreated: (GoogleMapController controller) {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: defaultButton(
                  function: () async {
                    Address address = await cubit.reverseGeocoding(
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
                  text: 'SAVE Address',
                  foregroundColor: const Color(0xff6C2C2C),
                  fontSize: 30.0,
                  backgroundColor: const Color(
                    0xffB8BB84,
                  ).withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        );
      },
      bloc: OrgCubit.get(context)..determinePosition(),
    );
  }
}
