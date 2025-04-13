import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {},
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        if (cubit.cameraController == null ||
            !cubit.cameraController!.value.isInitialized) {
          cubit.initializeCamera();
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          body: Center(
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CameraPreview(cubit.cameraController!),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FloatingActionButton(
                    onPressed: () => cubit.captureImage(context),
                    child: const Icon(Icons.camera),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
