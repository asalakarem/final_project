import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/models/user/user_model.dart';
import 'package:untitled1/modules/user/home/home_screen.dart';
import 'package:untitled1/modules/user/inquiry/inquiry_screen.dart';
import 'package:untitled1/modules/user/involved/involved_screen.dart';
import 'package:untitled1/modules/user/user/user_screen.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/endPoint.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialStates());

  static MainCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    const InvolvedScreen(),
    const InquiryScreen(),
    UserScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(MainChangeBottomNavStates());
  }

  final Map<String, bool> isShowPassword = {
    'login': true,
    'signUp': true,
    'newPassword': true,
  };

  void changePasswordVisibility(String key) {
    isShowPassword[key] = !isShowPassword[key]!;
    emit(MainChangePasswordVisibilityStates());
  }

  // YouTube Player
  late YoutubePlayerController youtubeController1;
  late YoutubePlayerController youtubeController2;
  late YoutubePlayerController youtubeController3;

  void initYoutubeController() {
    youtubeController1 = YoutubePlayerController(
      initialVideoId: 'L8Ue7NspO70',
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
    youtubeController2 = YoutubePlayerController(
      initialVideoId: 'vr73xuMlSxU',
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
    youtubeController3 = YoutubePlayerController(
      initialVideoId: '4QpQkVPdubc',
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  Future<void> close() {
    youtubeController1.dispose();
    youtubeController2.dispose();
    youtubeController3.dispose();
    return super.close();
  }

  //camera
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  XFile? capturedImage;

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        cameraController = CameraController(
          cameras![0],
          ResolutionPreset.veryHigh,
        );
        await cameraController!.initialize();
        emit(MainCameraInitializedState());
      }
    } catch (e) {
      emit(MainCameraErrorState(e.toString()));
    }
  }

  Future<void> captureImage(context) async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      try {
        capturedImage = await cameraController!.takePicture();
        Navigator.pop(context);
        emit(MainCameraCaptureState(capturedImage!.path));
      } catch (e) {
        emit(MainCameraErrorState(e.toString()));
      }
    }
  }

  void disposeCamera() {
    cameraController?.dispose();
    emit(MainCameraDisposedState());
  }

  //login
  UserModel? loginModel;

  void getUserData() {
    DioHelper.getData(url: PROFILE)
        .then((value) {
          UserModel(
            firstName: value.data['firstName'],
            lastName: value.data['lastName'],
            email: value.data['email'],
            phoneNumber: value.data['phoneNumber'],
          );
          emit(MainGetUserDataSuccessState(loginModel!));
        })
        .catchError((error) {
          print(error.toString());
          emit(MainGetUserDataErrorState(error.toString()));
        });
  }

  void userLogin({required String email, required String password}) {
    DioHelper.getData(url: LOGIN, query: {'email': email, 'password': password})
        .then((value) {
          loginModel = UserModel.fromJson(value.data);
          emit(MainLoginSuccessState(loginModel!));
        })
        .catchError((error) {
          print(error.toString());
          emit(MainLoginErrorState(error.toString()));
        });
  }

  //register
  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required int password,
    required String phone,
  }) {
    final String formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());
    DioHelper.postData(
          url: REGISTER,
          data: {
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'password': password,
            'phoneNumber': phone,
            'dateJoined': formattedDate,
            'otp': 8080,
          },
        )
        .then((value) {
          loginModel = UserModel.fromJson(value.data);
          emit(MainRegisterSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(MainRegisterErrorState(error.toString()));
        });
  }

  //forgot password
  void sendEmail({required String email}) {
    DioHelper.postData(url: SEND_EMAIL, query: {'toEmail': email})
        .then((value) {
          UserModel(email: email);
          emit(MainSendEmailSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(MainSendEmailErrorState(error.toString()));
        });
  }

  //otp
  void verifyOtp({required int otp, required String email}) {
    DioHelper.getData(url: VERIFY_OTP, query: {'otp': otp, 'email': email})
        .then((value) {
          UserModel(otp: otp);
          emit(MainVerifyOtpSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(MainVerifyOtpErrorState(error.toString()));
        });
  }

  //new password
  void newPassword({required String email, required String password}) {
    DioHelper.putData(
          url: NEW_PASSWORD,
          query: {'email': email, 'password': password},
        )
        .then((value) {
          UserModel(email: email, password: password);
          emit(MainNewPasswordSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(MainNewPasswordErrorState(error.toString()));
        });
  }

  //Map
  Position? position;

  Future<Address> reverseGeocoding({
    required double latitude,
    required double longitude,
  }) async {
    final geoCode = GeoCode();
    Address address = await geoCode.reverseGeocoding(
      latitude: latitude,
      longitude: longitude,
    );
    return address;
  }

  Future<Position> determinePosition() async {
    emit(MainLoadingMapStates());

    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    position = await Geolocator.getCurrentPosition();
    emit(MainLocationSuccessState());
    return position!;
  }
}
