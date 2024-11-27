abstract class AuthStates {}

////////////////////////////////////////////////////////////////////////////////
final class AuthInitial extends AuthStates {}

////////////////////////////////////////////////////////////////////////////////
class AuthSignInLoadingState extends AuthStates {}

class AuthSignInSuccessState extends AuthStates {
  String? token;
  AuthSignInSuccessState({this.token});
}

class AuthSignInErrorState extends AuthStates {
  String error;
  AuthSignInErrorState({required this.error});
}

class AuthSignInChangeEyeState extends AuthStates {}

class AuthSignInChangeRememberMeState extends AuthStates {}

////////////////////////////////////////////////////////////////////////////////
class AuthSignUpLoadingState extends AuthStates {}

class AuthSignUpSuccessState extends AuthStates {
  AuthSignUpSuccessState();
}

class AuthSignUpErrorState extends AuthStates {
  String error;
  AuthSignUpErrorState({required this.error});
}

////////////////////////////////////////////////////////////////////////////////
class AuthGetAreasLoadingState extends AuthStates {}

class AuthGetAreasSuccessState extends AuthStates {}

class AuthGetAreasErrorState extends AuthStates {
  String error;
  AuthGetAreasErrorState({required this.error});
}

////////////////////////////////////////////////////////////////////////////////
class AuthCheckOtpLoadingState extends AuthStates {}

class AuthCheckOtpSuccessState extends AuthStates {}

class AuthCheckOtpErrorState extends AuthStates {}
