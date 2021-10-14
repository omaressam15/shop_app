import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/statas_news.dart';
import 'package:shop_app/Dio/sherd_prefrens.dart';

class CubitNews extends Cubit<NewsStats>{

  CubitNews():super (InitialNewsState());

  CubitNews get(context) =>BlocProvider.of(context);

  bool isDark = false;

  void changThemeMode({bool fromShard}){

    if(fromShard !=null){
      isDark = fromShard;
      emit(AppChangeMode());

    }else{

      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeMode());

      });
    }
  }
}
