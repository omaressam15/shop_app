import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/dio_helper.dart';
import 'package:shop_app/Dio/network/end_point.dart';
import 'package:shop_app/ShopRegisterScreen/CubitForRegstration/register_stats.dart';
import 'package:shop_app/model/model_user.dart';

class ShopRegistrationCubit extends Cubit<ShopRegistrationStates>{
  ShopRegistrationCubit() : super(ShopRegistrationInitialState());

 static ShopRegistrationCubit get (context)=> BlocProvider.of(context);

 ShopUserData loginUserData;

 bool isPassword = true;

 IconData suffix = Icons.visibility_outlined;

 void changePasswordVisibility(){
   isPassword = !isPassword;

  suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined;

   emit(ChangeVisibility());

 }

  void registrationUser ({
  @required String email,
  @required String password,
  @required String name,
  @required String phone,
}){

   emit(ShopRegistrationLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name': name,
          'email':email,
          'password':password,
          'phone': phone
        }
    ).then((value) {
      loginUserData = ShopUserData.fromJson(value.data);

      emit(ShopRegistrationSuccessState(loginUserData));

    }).catchError((error){
      debugPrint(error);
      emit(ShopRegistrationErrorState(error.toString()));
    });

  }

}