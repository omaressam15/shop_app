import 'package:shop_app/model/model_user.dart';

abstract class ShopRegistrationStates{}

class ShopRegistrationInitialState extends ShopRegistrationStates{}

class ShopRegistrationLoadingState extends ShopRegistrationStates {}

class ChangeVisibility extends ShopRegistrationStates{}

class ShopRegistrationSuccessState extends ShopRegistrationStates {

 final ShopUserData loginModel;

  ShopRegistrationSuccessState(this.loginModel);

}

class ShopRegistrationErrorState extends ShopRegistrationStates
{
  final String error;

  ShopRegistrationErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopRegistrationStates {}
