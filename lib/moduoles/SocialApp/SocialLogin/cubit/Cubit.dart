import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Network/Local/Cach_Helper.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/moduoles/SocialApp/SocialLogin/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
          print(value.user!.email),
          print('value.user!.uid'),
          print(value.user!.uid),
      emit(SocialLoginSuccessState(value.user!.uid)) ,
    })
        .catchError((error) {
          print(error.toString());
          emit(SocialLoginErrorState(error));
    });
  }


  var isShow = true;

  IconData IconPassword = Icons.visibility;

  void hidden() {
    isShow = !isShow;
    if (isShow == true) {
      IconPassword = Icons.visibility;
    } else {
      IconPassword = Icons.visibility_off;
    }
    emit(SocialLoginChangeState());
  }
}
