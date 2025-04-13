import 'package:untitled1/models/user/user_model.dart';


abstract class MainStates {}

class MainInitialStates extends MainStates {}

class MainChangeBottomNavStates extends MainStates {}

class MainChangePasswordVisibilityStates extends MainStates {}

class MainCameraInitializedState extends MainStates {}

class MainCameraErrorState extends MainStates {
  String error;
  MainCameraErrorState(this.error);
}

class MainCameraCaptureState extends MainStates {
  String imagePath;
  MainCameraCaptureState(this.imagePath);
}

class MainCameraDisposedState extends MainStates {}

class MainLoginSuccessState extends MainStates {
  final UserModel loginModel;

  MainLoginSuccessState(this.loginModel);
}

class MainLoginErrorState extends MainStates {
  String error;

  MainLoginErrorState(this.error);
}

class MainRegisterSuccessState extends MainStates {}

class MainRegisterErrorState extends MainStates {
  String error;

  MainRegisterErrorState(this.error);
}

class MainGetUserDataSuccessState extends MainStates {
  final UserModel loginModel;

  MainGetUserDataSuccessState(this.loginModel);
}

class MainGetUserDataErrorState extends MainStates {
  String error;

  MainGetUserDataErrorState(this.error);
}

class MainSendEmailSuccessState extends MainStates {}

class MainSendEmailErrorState extends MainStates {
  String error;

  MainSendEmailErrorState(this.error);
}

class MainVerifyOtpSuccessState extends MainStates {}

class MainVerifyOtpErrorState extends MainStates {
  String error;

  MainVerifyOtpErrorState(this.error);
}

class MainNewPasswordSuccessState extends MainStates {}

class MainNewPasswordErrorState extends MainStates {
  String error;

  MainNewPasswordErrorState(this.error);
}

class MainLoadingMapStates extends MainStates {}

class MainLocationSuccessState extends MainStates {}
