import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_cubit.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_states.dart';
import 'package:shop_app/components.dart';

class FavoritesScreen extends StatelessWidget {

  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,stats){},
        builder: (context,stats){

         var cubit = HomeCubit.get(context).getFavoritesModel.dataFav;

          return ConditionalBuilder(
            builder: (context)=> ListView.separated(
                itemBuilder: (context,index)=>buildListViewProductItem(cubit.dataList[index].product,context),
                separatorBuilder: (context,index)=>const Divider(),
                itemCount: cubit.dataList.length),
            condition: stats is !LoadingFavoriteScreen,
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),

          );

        }
    );

  }

}
