import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/dio_helper.dart';
import 'package:shop_app/Dio/network/end_point.dart';
import 'package:shop_app/SearchScreen/CubitSearch/states.dart';
import 'package:shop_app/model/search_model.dart';

class CubitSearch extends Cubit<ShopSearchStates>{

  CubitSearch() :super(ShopSearchInitialState());

  static CubitSearch get(context)=>BlocProvider.of(context);

  GetSearchModel getSearchModel;

  void postSearch ({
    @required String text,
  }){

    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        data:
        {
          'text':text,
        }
    ).then((value) {
      getSearchModel = GetSearchModel.fromJson(value.data);

      emit(ShopSearchSuccessState());

    }).catchError((error){
      debugPrint(error);
      emit(ShopSearchErrorState(error.toString()));
    });

  }

}

