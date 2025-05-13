import 'package:untitled1/models/org/org_model.dart';

abstract class OrgStates {}

class OrgInitialStates extends OrgStates {}

class OrgTimerStates extends OrgStates {}

class OrgChangeIndexStates extends OrgStates {}

class OrgChangePasswordVisibilityStates extends OrgStates {}

class OrgLocationLoadingStates extends OrgStates {}

class OrgLocationSuccessState extends OrgStates {}

class OrgLoginSuccessState extends OrgStates {
  final OrgModel loginModel;

  OrgLoginSuccessState(this.loginModel);
}

class OrgLoginErrorState extends OrgStates {
  final String error;

  OrgLoginErrorState(this.error);
}

class OrgSignUpSuccessState extends OrgStates {}

class OrgSignUpErrorState extends OrgStates {
  final String error;

  OrgSignUpErrorState(this.error);
}

class OrgForgetPasswordLoadingState extends OrgStates {}

class OrgForgetPasswordSuccessState extends OrgStates {}

class OrgForgetPasswordErrorState extends OrgStates {
  final String error;

  OrgForgetPasswordErrorState(this.error);
}

class OrgVerifyOtpSuccessState extends OrgStates {}

class OrgVerifyOtpErrorState extends OrgStates {
  final String error;

  OrgVerifyOtpErrorState(this.error);
}

class OrgChangePasswordSuccessState extends OrgStates {}

class OrgChangePasswordErrorState extends OrgStates {
  final String error;

  OrgChangePasswordErrorState(this.error);
}

class MainGetOrgDataSuccessState extends OrgStates {
  final OrgModel loginModel;

  MainGetOrgDataSuccessState(this.loginModel);
}

class MainGetOrgDataErrorState extends OrgStates {
  final String error;

  MainGetOrgDataErrorState(this.error);
}

class OrgGetRequestLoadingState extends OrgStates {}

class OrgGetRequestSuccessState extends OrgStates {}

class OrgGetRequestErrorState extends OrgStates {
  final String error;

  OrgGetRequestErrorState(this.error);
}

class OrgGetAcceptRequestSuccessState extends OrgStates {}

class OrgGetAcceptRequestErrorState extends OrgStates {
  final String error;

  OrgGetAcceptRequestErrorState(this.error);
}

class OrgExtraTimeButtonSuccessState extends OrgStates {}

class OrgExtraTimeButtonErrorState extends OrgStates {
  final String error;

  OrgExtraTimeButtonErrorState(this.error);
}

class OrgGetMissionDoneRequestSuccessState extends OrgStates {}

class OrgGetMissionDoneRequestErrorState extends OrgStates {
  final String error;

  OrgGetMissionDoneRequestErrorState(this.error);
}

class OrgGetRequestInfoLoadingState extends OrgStates {}

class OrgGetRequestInfoSuccessState extends OrgStates {}

class OrgGetRequestInfoErrorState extends OrgStates {
  final String error;

  OrgGetRequestInfoErrorState(this.error);
}

class OrgAcceptRequestButtonSuccessState extends OrgStates {}

class OrgAcceptRequestButtonErrorState extends OrgStates {
  final String error;

  OrgAcceptRequestButtonErrorState(this.error);
}

class OrgMissionDoneButtonSuccessState extends OrgStates {}

class OrgMissionDoneButtonErrorState extends OrgStates {
  final String error;

  OrgMissionDoneButtonErrorState(this.error);
}

class OrgCameraInitializedState extends OrgStates {}

class OrgDogImageAcceptedState extends OrgStates {
  final String label;
  final double confidence;

  OrgDogImageAcceptedState(this.label, this.confidence);
}

class OrgDogImageRejectedState extends OrgStates {
  final String label;
  final double confidence;

  OrgDogImageRejectedState(this.label, this.confidence);
}

class OrgDogImageErrorState extends OrgStates {
  final String message;

  OrgDogImageErrorState(this.message);
}

class OrgLocationErrorState extends OrgStates {
  final String error;

  OrgLocationErrorState(this.error);
}
