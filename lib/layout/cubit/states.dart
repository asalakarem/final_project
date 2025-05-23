import 'package:untitled1/models/user/user_model.dart';


abstract class MainStates {}

class MainInitialStates extends MainStates {}

class MainChangeBottomNavStates extends MainStates {}

class MainChangePasswordVisibilityStates extends MainStates {}

class MainCameraInitializedState extends MainStates {}

class MainDeleteDogImageState extends MainStates {}

class MainDogImageAcceptedState extends MainStates {
  final String label;
  final double confidence;

  MainDogImageAcceptedState(this.label, this.confidence);
}

class MainDogImageRejectedState extends MainStates {
  final String label;
  final double confidence;

  MainDogImageRejectedState(this.label, this.confidence);
}

class MainDogImageErrorState extends MainStates {
  final String message;

  MainDogImageErrorState(this.message);
}

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

class MainUpdateUserSuccessState extends MainStates {
  final UserModel loginModel;

  MainUpdateUserSuccessState(this.loginModel);
}

class MainUpdateUserErrorState extends MainStates {
  String error;

  MainUpdateUserErrorState(this.error);
}

class MainGetUserDataSuccessState extends MainStates {
  final UserModel loginModel;

  MainGetUserDataSuccessState(this.loginModel);
}

class MainGetUserDataErrorState extends MainStates {
  String error;

  MainGetUserDataErrorState(this.error);
}

class MainSendEmailLoadingState extends MainStates {}

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

class MainCreateRequestSuccessState extends MainStates {}

class MainCreateRequestErrorState extends MainStates {
  String error;

  MainCreateRequestErrorState(this.error);
}

class MainInProgressRequestSuccessState extends MainStates {}

class MainInProgressRequestErrorState extends MainStates {
  String error;

  MainInProgressRequestErrorState(this.error);
}

class MainAcceptedRequestSuccessState extends MainStates {}

class MainAcceptedRequestErrorState extends MainStates {
  String error;

  MainAcceptedRequestErrorState(this.error);
}

class MainDoneRequestSuccessState extends MainStates {}

class MainDoneRequestErrorState extends MainStates {
  String error;

  MainDoneRequestErrorState(this.error);
}

class MainInProgressChangeState extends MainStates {}

class MainDeleteRequestSuccessState extends MainStates {}

class MainDeleteRequestErrorState extends MainStates {
  String error;

  MainDeleteRequestErrorState(this.error);
}
