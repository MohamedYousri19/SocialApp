import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Models/ShopApp/login_model.dart';
import 'package:to_do_app/Network/Remote/dio_helper.dart';
import 'package:to_do_app/Network/end_points.dart';
import '../../../../Moduoles/ShopApp/LoginScreen/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>
{
  ShopLoginCubit() : super (ShopLoginInitialState()) ;
  static ShopLoginCubit get(context) => BlocProvider.of(context) ;
  ShopLoginModel? loginModel ;
  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState()) ;
    DioHelper.postData(url: LOGIN, data:{
      'email':email,
      'password':password,
    }).then((value) => {
      loginModel = ShopLoginModel.fromJson(value.data) ,
      print('loginModel!.status') ,
      print(loginModel!.status) ,
      print(loginModel!.message) ,
      print(loginModel!.data!.token) ,
      emit(ShopLoginSuccessState(loginModel!)),
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString(),loginModel!));
    }) ;
  }
  var isShow = true ;
  IconData IconPassword = Icons.visibility ;
  void hidden(){
    isShow = !isShow ;
    if(isShow == true){
      IconPassword = Icons.visibility ;
    }else{
      IconPassword = Icons.visibility_off ;
    }
    emit(ShopLoginChangeState()) ;
  }
}