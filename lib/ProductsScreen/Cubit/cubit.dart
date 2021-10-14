import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/dio_helper.dart';
import 'package:shop_app/ProductsScreen/Cubit/state.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/model/products_model_details.dart';

class DetailsCubit extends Cubit<States>{

  DetailsCubit() : super(InitialState());

  static DetailsCubit get(context) =>BlocProvider.of(context);

  CarouselController buttonCarouselController = CarouselController();


  ProductModelDetails productModelDetails;

  void getDetailsProducts(int productID){
    emit(LoadingDetailsScreen());

    DioHelper.getData(url:'products/$productID',
      token: token,
    ).then((value) {
      emit(SussesDetailsScreen());
      productModelDetails = ProductModelDetails.fromJson(value.data);
      print(productModelDetails.data.name);
      print(productModelDetails.data.image);
      print(productID);


    }).catchError((onError){
      emit(ErrorDetailsScreen());
      print(onError);
    }

    );

  }


}