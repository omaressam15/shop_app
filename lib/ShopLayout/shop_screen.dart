import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_cubit.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_states.dart';
import 'package:shop_app/SearchScreen/search_screen.dart';
import 'package:shop_app/components.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(

        listener: (context,stats){},
        builder: (context,stats){

          var cubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Softagy'),
              actions: [
                IconButton(onPressed: ()=>navigate(SearchScreen(), context), icon: const Icon(Icons.search)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(

              onTap: (int index){
                cubit.changeBottomNavigationBar(index);
              },

              items:cubit.bottomNavigationBarItem,


              currentIndex: cubit.currentIndex,

            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
        );
  }
}
