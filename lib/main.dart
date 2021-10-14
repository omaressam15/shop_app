import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/BorderScreen/border_screen.dart';
import 'package:shop_app/Dio/dio_helper.dart';
import 'package:shop_app/Dio/sherd_prefrens.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_cubit.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_states.dart';
import 'package:shop_app/LoginScreen/login_screen.dart';
import 'package:shop_app/ShopLayout/shop_screen.dart';
import 'package:shop_app/Thems/thems.dart';
import 'package:shop_app/constants.dart';

import 'BlocObserver/BlocObserver.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.inti();
  await CacheHelper.init();
  
  Widget widget;
  
  bool onBoarding = CacheHelper.getData(key:'onBoarding');

   token = CacheHelper.getData(key:'token');

  print(token);

  if(onBoarding!=null){

    if(token!=null) {
      widget= const ShopScreen();

    } else {
      widget = LoginScreen();
    }

  }else{
    widget = const OnBordScreen();
  }

  runApp( MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp({Key key, this.startWidget}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>HomeCubit()..getDataHome(2)..getCategoriesHome()..getFavorites()..getUserData(),
      child:BlocConsumer<HomeCubit,HomeStates>(
        listener:(context,states) {},
        builder: (context,states){
          return  MaterialApp(
            title: 'Flutter Demo',
            theme: themeLight,
            darkTheme: themeDark,
            home: startWidget,
          );
        },
      ) ,
    );
  }
}