
import 'package:shop_app/model/model_user.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates {}

class ChangeVisibility extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates {

 final ShopUserData loginModel;

  ShopLoginSuccessState(this.loginModel);

}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}
