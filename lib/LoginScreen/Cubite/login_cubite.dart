import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/dio_helper.dart';
import 'package:shop_app/Dio/network/end_point.dart';
import 'package:shop_app/LoginScreen/Cubite/cubite_stats.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/model/model_user.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());


 static ShopLoginCubit get(context)=> BlocProvider.of(context);

 ShopUserData loginUserData;

 bool isPassword = true;

 IconData suffix = Icons.visibility_outlined;

 void changePasswordVisibility(){
   isPassword = !isPassword;

  suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined;

   emit(ChangeVisibility());

 }

  void loginUser ({
  @required String email,
  @required String password,
}){

   emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: loginUrl,
        token: token,
        data:
        {
          'email':email,
          'password':password,
        }
    ).then((value) {
      loginUserData = ShopUserData.fromJson(value.data);

      emit(ShopLoginSuccessState(loginUserData));

    }).catchError((error){
      debugPrint(error);
      emit(ShopLoginErrorState(error.toString()));
    });

  }

}