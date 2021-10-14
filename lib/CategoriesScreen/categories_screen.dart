import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_cubit.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_states.dart';
import 'package:shop_app/model/model_categories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,stats){},
        builder: (context,stats){
          var cubit = HomeCubit.get(context).categoriesModel.dataCategories;
          return ListView.separated(

            shrinkWrap: true,
            itemCount:cubit.data.length ,
            itemBuilder: (context,index )=> buildCategories(cubit.data[index]),
            separatorBuilder: (context,index)=>const Divider(),

          );

        }

        );
  }

  Widget buildCategories(Data data) {

   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 13),
     child: Row(
        children:  [
          Image(image: NetworkImage(data.image),height: 100,width: 100,),

          const SizedBox(width: 18,),

          Text(data.name,style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 17),),

          const Spacer(),

          const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
        ],
      ),
   );

  }
}
