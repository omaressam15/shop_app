
import 'package:shop_app/model/delete_favorites.dart';
import 'package:shop_app/model/favorites_model.dart';
import 'package:shop_app/model/model_user.dart';

abstract class HomeStates {}


class InitialHomeState extends HomeStates{}

class ButtonNavigationBar extends HomeStates{}

class LoadingHomeScreen extends HomeStates{}

class SucssesHomeScreen extends HomeStates{}

class ErrorHomeScreen extends HomeStates{}


class SussesCategoriesScreen extends HomeStates{}

class  ErrorCategoriesScreen extends HomeStates{}


class SussesFavoritePost extends HomeStates{

  final FavoritesModel favoritesModel;

  SussesFavoritePost(this.favoritesModel);


}

class  ErrorFavoritePost extends HomeStates{}


class SussesFavoriteGet extends HomeStates{}

class  ErrorFavoriteGet extends HomeStates{}


class LoadingFavoriteScreen extends HomeStates{

}

class SussesGetUserData extends HomeStates{

 final ShopUserData shopUserData;

  SussesGetUserData(this.shopUserData);

}

class  ErrorGetUserData extends HomeStates{}


class LoadingUserScreen extends HomeStates{

}


class SussesUpdateUserData extends HomeStates{

  final ShopUserData shopUserData;

  SussesUpdateUserData(this.shopUserData);

}

class  ErrorUpdateUserData extends HomeStates{}


class LoadingUpdateUserScreen extends HomeStates{

}





class ChangeFavoriteIcon extends HomeStates{}


