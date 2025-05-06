import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

class UserMap extends StatelessWidget {
  final TextEditingController addressController;

  const UserMap({super.key, required this.addressController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: MainCubit.get(context)..determinePosition(),
      child: BlocBuilder<MainCubit, MainStates>(
        builder: (context, state) {
          final cubit = MainCubit.get(context);

          if (state is MainLoadingMapStates) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
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
                    onMapCreated: (controller) {
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
                        addressController.text =
                            address.streetAddress ?? 'شارع غير معروف';
                        Navigator.pop(context);
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
