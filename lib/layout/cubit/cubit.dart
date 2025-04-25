import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/models/inquiry/requests_model.dart';
import 'package:untitled1/models/request/request_model.dart';
import 'package:untitled1/models/user/user_model.dart';
import 'package:untitled1/modules/user/home/home_screen.dart';
import 'package:untitled1/modules/user/inquiry/inquiry_screen.dart';
import 'package:untitled1/modules/user/involved/involved_screen.dart';
import 'package:untitled1/modules/user/user/user_screen.dart';
import 'package:untitled1/shared/network/endPoint.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialStates());

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

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

  Future<void> captureImage(BuildContext context) async {
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

  void getUserData(int targetUserId) {
    DioHelper.getData(url: PROFILE)
        .then((value) {
          final List<dynamic> data = value.data;
          final userMap = data.firstWhere(
            (user) => user['userId'] == targetUserId,
            orElse: () => null,
          );
          if (userMap != null) {
            final user = UserModel.fromJson(userMap);
            loginModel = user;
            emit(MainGetUserDataSuccessState(user));
          } else {
            emit(
              MainGetUserDataErrorState("User with ID $targetUserId not found"),
            );
          }
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetUserDataErrorState(error.toString()));
        });
  }

  void updateUser({
    required String firstName,
    required String lastName,
    required String email,
    required int phone,
  }) {
    DioHelper.putData(
          url: UPDATE_PROFILE,
          data: {
            'userId': loginModel!.userId,
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'phoneNumber': phone,
            'password': loginModel!.password,
            'dateJoined': loginModel!.dateJoined,
            'otp': loginModel!.otp,
          },
        )
        .then((value) {
          loginModel = UserModel.fromJson(value.data);
          emit(MainUpdateUserSuccessState(loginModel!));
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainUpdateUserErrorState(error.toString()));
        });
  }

  void userLogin({required String email, required String password}) {
    DioHelper.getData(url: LOGIN, query: {'email': email, 'password': password})
        .then((value) {
          loginModel = UserModel.fromJson(value.data);
          emit(MainLoginSuccessState(loginModel!));
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainLoginErrorState(error.toString()));
        });
  }

  //register
  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int phone,
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
        .catchError((dynamic error) {
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
        .catchError((dynamic error) {
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
        .catchError((dynamic error) {
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
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainNewPasswordErrorState(error.toString()));
        });
  }

  //createRequest
  RequestModel? requestModel;

  void createRequest({
    required double latitude,
    required double longitude,
    required String description,
    required int dogCount,
  }) {
    final String formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());
    DioHelper.postData(
          url: CREATE_REQUEST,
          data: {
            'userId': loginModel!.userId,
            'status': 'inProgress',
            'latitude': latitude,
            'longitude': longitude,
            'submissionTime': formattedDate,
            'description': description,
            'dogImage': null,
            'dogsCount': dogCount,
          },
        )
        .then((value) {
          requestModel = RequestModel.fromJson(value.data);
          emit(MainCreateRequestSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainCreateRequestErrorState(error.toString()));
        });
  }

  //collapse
  final Map<String, bool> isCollapse = {
    'inProgress': false,
    'accepted': false,
    'missionDone': false,
  };

  int currentIndexCollapse = 0;

  void changeInProgress(int index, String key) {
    if (currentIndexCollapse == index) {
      isCollapse[key] = !isCollapse[key]!;
    } else {
      currentIndexCollapse = index;
      isCollapse[key] = true;
    }
    emit(MainInProgressChangeState());
  }

  //InProgressRequests
  List<RequestsModel> inProgressList = [];

  void inProgressRequest() {
    DioHelper.getData(url: GET_IN_PROGRESS)
        .then((value) {
          inProgressList = [];
          final List<dynamic> data = value.data;

          final userRequest = data.where(
            (user) => user['userId'] == loginModel!.userId,
          );

          if (userRequest.isNotEmpty) {
            for (var item in userRequest) {
              final model = RequestsModel.fromJson(item);
              inProgressList.add(model);
            }
            emit(MainInProgressRequestSuccessState());
          } else {
            emit(
              MainInProgressRequestErrorState("No in-progress requests found"),
            );
          }
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainInProgressRequestErrorState(error.toString()));
        });
  }

  //AcceptedRequests
  List<RequestsModel> acceptedList = [];

  void acceptedRequest() {
    DioHelper.getData(url: GET_ACCEPTED)
        .then((value) {
          acceptedList = [];
          final List<dynamic> data = value.data;

          final userRequest = data.where(
            (user) => user['userId'] == loginModel!.userId,
          );

          if (userRequest.isNotEmpty) {
            for (var item in userRequest) {
              final model = RequestsModel.fromJson(item);
              acceptedList.add(model);
            }
            emit(MainAcceptedRequestSuccessState());
          } else {
            emit(
              MainAcceptedRequestErrorState("No in-progress requests found"),
            );
          }
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainAcceptedRequestErrorState(error.toString()));
        });
  }

  //DoneRequests
  List<RequestsModel> doneList = [];

  void doneRequest() {
    DioHelper.getData(url: GET_DONE)
        .then((value) {
          doneList = [];
          final List<dynamic> data = value.data;

          final userRequest = data.where(
            (user) => user['userId'] == loginModel!.userId,
          );

          if (userRequest.isNotEmpty) {
            for (var item in userRequest) {
              final model = RequestsModel.fromJson(item);
              doneList.add(model);
            }
            emit(MainDoneRequestSuccessState());
          } else {
            emit(
              MainDoneRequestErrorState("No in-progress requests found"),
            );
          }
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainDoneRequestErrorState(error.toString()));
        });
  }

  //Map
  Position? position;

  Future<Address> reverseGeocoding({
    required double latitude,
    required double longitude,
  }) async {
    final geoCode = GeoCode();
    final Address address = await geoCode.reverseGeocoding(
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

  void snackBar({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType type,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: type,
        ),
      ),
    );
  }
}
