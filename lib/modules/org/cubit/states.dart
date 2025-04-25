import 'package:untitled1/models/org/org_model.dart';

abstract class OrgStates {}

class OrgInitialStates extends OrgStates {}

class OrgChangeIndexStates extends OrgStates {}

class OrgChangePasswordVisibilityStates extends OrgStates {}

class OrgLoadingStates extends OrgStates {}

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
