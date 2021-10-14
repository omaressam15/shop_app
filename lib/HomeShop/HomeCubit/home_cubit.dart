
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/CategoriesScreen/categories_screen.dart';
import 'package:shop_app/Dio/dio_helper.dart';
import 'package:shop_app/Dio/network/end_point.dart';
import 'package:shop_app/FavoritesScreen/favorites_screen.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_states.dart';
import 'package:shop_app/HomeShop/home_screen.dart';
import 'package:shop_app/SettingsScreen/settings_screen.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/model/delete_favorites.dart';
import 'package:shop_app/model/favorites_model.dart';
import 'package:shop_app/model/get_favorites_model.dart';
import 'package:shop_app/model/model_categories.dart';
import 'package:shop_app/model/model_home.dart';
import 'package:shop_app/model/model_user.dart';
import 'package:shop_app/model/products_model_details.dart';

class HomeCubit extends Cubit<HomeStates>{

  HomeCubit() : super(InitialHomeState());

 static HomeCubit get(context) =>BlocProvider.of(context);

  int currentIndex = 0;

  List <Widget> screens = [

   const HomeScreen(),

   const CategoriesScreen(),

   const FavoritesScreen(),

   const SettingsScreen(),

  ];

  void changeBottomNavigationBar (int index){

    currentIndex = index;
    emit(ButtonNavigationBar());

  }

 List<BottomNavigationBarItem>  bottomNavigationBarItem = [

   const BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
   const BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
   const BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
   const BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),


  ];

  Map<int,bool> favorites = {};

  HomeModel homeModel;

  Products productsModel;

  void getDataHome(int index){

    emit(LoadingHomeScreen());

    DioHelper.getData(url: HOME,token: token).then((value) {


      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel.data.products) {

        favorites.addAll({element.id:element.inFavorites});

      }

      print(favorites);
      emit(SucssesHomeScreen());



      print(homeModel.data.products[index].name);

    }).catchError((error){
      emit(ErrorHomeScreen());
      print(error.toString());

    });

  }


   CategoriesModel categoriesModel;

  void getCategoriesHome(){

    emit(LoadingHomeScreen());

    DioHelper.getData(url: categories).then((value) {


      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(SussesCategoriesScreen());



      print(categoriesModel.dataCategories.data[0].name);

    }).catchError((error){
      emit(ErrorCategoriesScreen());
      print(error.toString());

    });

  }


  FavoritesModel favoritesModel;
  void postFavorites (int productId){

    emit(ChangeFavoriteIcon());

    favorites[productId] = !favorites[productId];

    DioHelper.postData(url: FAVORITES,
        data: {'product_id': productId},
      token: token,

    ).then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);

      print(favoritesModel.message);
      emit(SussesFavoritePost(favoritesModel));
      if(!favoritesModel.status){

        favorites[productId] = !favorites[productId];
      }else{
        getFavorites();
      }
    }
    ).catchError((error){
      emit(ErrorFavoritePost());
      if(!favoritesModel.status){

        favorites[productId] = !favorites[productId];

      }
      print(error.toString());
    }

    );

  }


  GetFavoritesModel getFavoritesModel;
  void getFavorites(){

    emit(LoadingFavoriteScreen());

    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value) {
      emit(SussesFavoriteGet());
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);


      print("Hi ${getFavoritesModel.dataFav.dataList[0].product.name}");

    }).catchError((error){
      emit(ErrorFavoriteGet());
      print(error.toString());
    }
    );


  }




  ShopUserData shopUserData;
  void getUserData(){

    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      shopUserData = ShopUserData.fromJson(value.data);

      print("My Name is : ${shopUserData.data.name}");
      emit(SussesGetUserData(shopUserData));


    }).catchError((error){
      emit(ErrorGetUserData());
      print(error.toString());
    }
    );
  }

  ShopUserData shopUpdateData;
  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  })

  {
    emit(LoadingUpdateUserScreen());
    DioHelper.updateData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        }
    ).then((value) {
      shopUpdateData = ShopUserData.fromJson(value.data);

      print("My Name is : ${shopUpdateData.data.name}");
      emit(SussesUpdateUserData(shopUpdateData));


    }).catchError((error){
      emit(ErrorUpdateUserData());
      print(error.toString());
    }
    );
  }

}