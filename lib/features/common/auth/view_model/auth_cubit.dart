import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../shared/services/remote/dio_helper.dart';
import '../../../../shared/services/remote/exceptions.dart';
import '../model/areas_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
////////////////////////////////////////////////////////////////////////////////
  /// (Sign in)
  bool signInPasswordEye = true;
  bool signInRememberMe = true;

  final supabase = Supabase.instance.client;

  /// Functions
  void signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthSignInLoadingState());
    // await supabase.auth
    //     .signInWithOtp(
    //   email: email,
    //   emailRedirectTo: kIsWeb ? null : 'io.supabase.flutter://signin-callback/',
    // )
    //     .then((value) {
    //   print("Success");
    //   emit(AuthSignInSuccessState());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(AuthSignInErrorState(error: error.toString()));
    // });
    try {
      await supabase.auth
          .signInWithPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        await supabase.auth
            .signInWithOtp(
          email: value.user!.email!,
          shouldCreateUser: false,
        )
            .then((value) {
          print("Success");
          emit(AuthSignInSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(AuthSignInErrorState(error: "error in OTP"));
        });
      }).catchError((error) {
        print(error.toString());
        emit(AuthSignInErrorState(error: "error in Sign in"));
      });

      // final Session? session = res.session;
      // final User? user = res.user;
      // print(user);
      // print(session);
    } catch (e) {
      // TODO
      print(e.toString());
      emit(AuthSignInErrorState(error: "Error signing in"));
    }

    // DioHelper.postData(endPoint: "/client/login", body: {
    //   "email_address": email,
    //   "password": password,
    // }).then((value) {
    //   if (kDebugMode) {
    //     print(value.data);
    //   }
    //   emit(AuthSignInSuccessState(token: value.data["token"]));
    // }).catchError((error) {
    //
    //   final errorMessage = DioExceptions.fromDioError(error).toString();
    //   print(errorMessage);
    //   emit(AuthSignInErrorState(error: errorMessage));
    // });
  }

  Future<bool> confirmOtp(String token, String email) async {
    // Add your function code here!
    // Get a reference your Supabase client
    emit(AuthCheckOtpLoadingState());
    try {
      await supabase.auth.verifyOTP(
        type: OtpType.magiclink,
        token: token,
        email: email,
      );
      emit(AuthCheckOtpSuccessState());
      return true;
    } catch (error) {
      print(error.toString());
      emit(AuthCheckOtpErrorState());
      return false;
    }
  }

  void signInWithChangeEye() {
    signInPasswordEye = !signInPasswordEye;
    emit(AuthSignInChangeEyeState());
  }

  void signInChangeRememberMe() {
    signInRememberMe = !signInRememberMe;
    emit(AuthSignInChangeRememberMeState());
  }

  //////////////////////////////////////////////////////////////////////////////
  bool signUpPasswordEye = true;

  void signUp({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(AuthSignUpLoadingState());
    supabase.auth.signUp(
      email: email,
      password: password,
      data: {"username": username},
    ).then((value) {
      print(value.user);
      print(value.session);
    }).then((value) {
      emit(AuthSignUpSuccessState());
    }).catchError((error) {
      emit(AuthSignUpErrorState(
          error: DioExceptions.fromDioError(error).toString()));
    });
  }

  void signUpWithChangeEye() {
    signUpPasswordEye = !signUpPasswordEye;
    emit(AuthSignInChangeEyeState());
  }

  //////////////////////////////////////////////////////////////////////////////
  AreasModel? areasModel;
  void getAreas() {
    emit(AuthGetAreasLoadingState());
    DioHelper.getData(endPoint: "/business_locations").then((value) {
      if (kDebugMode) {
        print(value.data);
      }
      areasModel = AreasModel.fromJson(value.data);
      emit(AuthGetAreasSuccessState());
    }).catchError((error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      emit(AuthGetAreasErrorState(error: errorMessage));
    });
  }
}
