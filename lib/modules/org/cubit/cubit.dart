import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/models/org/org_model.dart';
import 'package:untitled1/models/org/org_request/org_request_model.dart';
import 'package:untitled1/modules/org/complete/org_complete.dart';
import 'package:untitled1/modules/org/cubit/states.dart';
import 'package:untitled1/modules/org/done/org_done.dart';
import 'package:untitled1/modules/org/home/org_home.dart';
import 'package:untitled1/modules/org/user/org_profile_screen.dart';
import 'package:untitled1/shared/network/endPoint.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';

class OrgCubit extends Cubit<OrgStates> {
  OrgCubit() : super(OrgInitialStates());

  static OrgCubit get(BuildContext context) => BlocProvider.of(context);

  List<Widget> screens = [
    const OrgHome(),
    const OrgDone(),
    const OrgComplete(),
    OrgProfileScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(OrgChangeIndexStates());
  }

  final Map<String, bool> isShowPassword = {
    'login': true,
    'signUp': true,
    'newPassword': true,
  };

  void changePasswordVisibility(String key) {
    isShowPassword[key] = !isShowPassword[key]!;
    emit(OrgChangePasswordVisibilityStates());
  }

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
    emit(OrgLoadingStates());

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
    emit(OrgLocationSuccessState());
    return position!;
  }

  //login and signUp
  OrgModel? loginModel;

  void getOrgData(int targetUserId) {
    DioHelper.getData(url: ORGPROFILE)
        .then((value) {
          final List<dynamic> data = value.data;
          final userMap = data.firstWhere(
            (user) => user['ngoId'] == targetUserId,
            orElse: () => null,
          );
          if (userMap != null) {
            final user = OrgModel.fromJson(userMap);
            loginModel = user;
            emit(MainGetOrgDataSuccessState(user));
          } else {
            emit(
              MainGetOrgDataErrorState("User with ID $targetUserId not found"),
            );
          }
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetOrgDataErrorState(error.toString()));
        });
  }

  void orgLogin({required String email, required String password}) {
    DioHelper.getData(
          url: ORGLOGIN,
          query: {'email': email, 'password': password},
        )
        .then((value) {
          loginModel = OrgModel.fromJson(value.data);
          emit(OrgLoginSuccessState(loginModel!));
        })
        .catchError((dynamic error) {
          emit(OrgLoginErrorState(error.toString()));
        });
  }

  void signUp({
    required String name,
    required String email,
    required String password,
    required int phone,
    required double latitude,
    required double longitude,
    required String address,
  }) {
    final String formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());
    DioHelper.postData(
          url: ORGREGISTER,
          data: {
            'name': name,
            'email': email,
            'password': password,
            'phoneNumber': phone,
            'dateJoined': formattedDate,
            'latitude': latitude,
            'longitude': longitude,
            'address': address,
            'otp': 8080,
          },
        )
        .then((value) {
          loginModel = OrgModel.fromJson(value.data);
          emit(OrgSignUpSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgSignUpErrorState(error.toString()));
        });
  }

  //forgetPassword
  void forgetPassword({required String email}) {
    DioHelper.postData(url: ORG_SEND_EMAIL, query: {'toEmail': email})
        .then((value) {
          OrgModel(email: email);
          emit(OrgForgetPasswordSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgForgetPasswordErrorState(error.toString()));
        });
  }

  //otp
  void verifyOtp({required int otp, required String email}) {
    DioHelper.getData(url: ORG_VERIFY_OTP, query: {'otp': otp, 'email': email})
        .then((value) {
          OrgModel(otp: otp, email: email);
          emit(OrgVerifyOtpSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgVerifyOtpErrorState(error.toString()));
        });
  }

  //changePassword
  void changePassword({required String email, required String password}) {
    DioHelper.putData(
          url: ORG_NEW_PASSWORD,
          query: {'email': email, 'password': password},
        )
        .then((value) {
          OrgModel(email: email, password: password);
          emit(OrgChangePasswordSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgChangePasswordErrorState(error.toString()));
        });
  }

  //snackBar
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

  //getRequest
  OrgRequestModel? requestModel;

  List<OrgRequestModel> requestList = [];

  void getRequest() {
    emit(OrgGetRequestLoadingState());
    DioHelper.getData(url: ORG_GET_REQUEST)
        .then((value) {
          requestList = [];
          final List<dynamic> data = value.data;
          final userMap = data.where(
            (user) =>
                user['ngoId'] == loginModel!.ngoId &&
                user['status'] == 'Assigned',
          );
          if (userMap.isNotEmpty) {
            for (var item in userMap) {
              final user = OrgRequestModel.fromJson(item);
              requestList.add(user);
            }
            emit(OrgGetRequestSuccessState());
          } else {
            emit(OrgGetRequestErrorState("No requests found"));
          }
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgGetRequestErrorState(error.toString()));
        });
  }

  void getRequestInfo({required int? requestId}) {
    emit(OrgGetRequestInfoLoadingState());
    DioHelper.getData(
          url: ORG_GET_REQUEST_INFO,
          query: {'requestId': requestId},
        )
        .then((value) {
          requestModel = OrgRequestModel.fromJson(value.data);
          emit(OrgGetRequestInfoSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgGetRequestInfoErrorState(error.toString()));
        });
  }

  //acceptRequestButton
  void acceptRequestButton({required int? assignmentId}) {
    final String formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());
    DioHelper.putData(
          url: ORG_SEND_ACCEPT_REQUEST,
          data: {
            "assignmentId": assignmentId,
            "status": "Accepted",
            "assignedDate": formattedDate,
            "responseDuration": 3,
            "responseDate": null,
            "responseExpiredDate": null,
            "actionDuration": null,
            "actionDate": null,
            "notes": null,
            "numberNeededExtraTime": 4,
            "isActive": "0",
          },
        )
        .then((value) {
          getRequest();
          emit(OrgAcceptRequestButtonSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgAcceptRequestButtonErrorState(error.toString()));
        });
  }

  //missionDoneButton
  void missionDoneButton({required int? assignmentId}) {
    final String formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());
    DioHelper.postData(
      url: ORG_SEND_MISSION_DONE_REQUEST,
      data: {
        'assignmentId': assignmentId,
        'status': 'Mission Done',
        'transactionDate': formattedDate,
        'notes': 'Mission Done',
      },
    ).then((value) {
      getAcceptRequest();
      emit(OrgMissionDoneButtonSuccessState());
    }).catchError((dynamic error) {
      print(error.toString());
      emit(OrgMissionDoneButtonErrorState(error.toString()));
    });
  }

  //acceptRequest
  List<OrgRequestModel> acceptRequestList = [];

  void getAcceptRequest() {
    DioHelper.getData(url: ORG_ACCEPT_REQUEST)
        .then((value) {
          acceptRequestList = [];
          final List<dynamic> data = value.data;
          final userMap = data.where(
            (user) => user['ngoId'] == loginModel!.ngoId,
          );
          if (userMap.isNotEmpty) {
            for (var item in userMap) {
              final user = OrgRequestModel.fromJson(item);
              acceptRequestList.add(user);
            }
            emit(OrgGetAcceptRequestSuccessState());
          } else {
            emit(OrgGetAcceptRequestErrorState("No requests found"));
          }
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgGetAcceptRequestErrorState(error.toString()));
        });
  }

  //getMissionDone
  List<OrgRequestModel> missionDoneList = [];

  void getMissionDone() {
    DioHelper.getData(url: ORG_MISSION_DONE)
        .then((value) {
          missionDoneList = [];
          final List<dynamic> data = value.data;
          final userMap = data.where(
            (user) => user['ngoId'] == loginModel!.ngoId,
          );
          if (userMap.isNotEmpty) {
            for (var item in userMap) {
              final user = OrgRequestModel.fromJson(item);
              missionDoneList.add(user);
            }
            emit(OrgGetMissionDoneRequestSuccessState());
          } else {
            emit(OrgGetMissionDoneRequestErrorState("No requests found"));
          }
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(OrgGetMissionDoneRequestErrorState(error.toString()));
        });
  }
}
