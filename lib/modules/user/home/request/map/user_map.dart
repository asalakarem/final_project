import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

class UserMap extends StatelessWidget {
  final TextEditingController addressController;

  const UserMap({super.key, required this.addressController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);

        if (state is MainLoadingMapStates) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final Set<Marker> markers = {};

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
                initialCameraPosition: cubit.position != null
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
                    final Address address = await cubit.reverseGeocoding(
                      latitude: cubit.position!.latitude,
                      longitude: cubit.position!.longitude,
                    );
                    // تحديث TextFormField مباشرة
                    addressController.text =
                        address.streetAddress ?? 'شارع غير معروف';
                    Navigator.pop(context);
                  },
                  text: 'SAVE Address',
                  foregroundColor: const Color(0xff6C2C2C),
                  fontSize: 30.0,
                  backgroundColor: const Color(0xffB8BB84).withOpacity(0.9),
                ),
              ),
            ],
          ),
        );
      },
      bloc: MainCubit.get(context)..determinePosition(),
    );
  }
}
