import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_cubit.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_states.dart';
import 'package:shop_app/ProductsScreen/products_details.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/model/model_categories.dart';
import 'package:shop_app/model/model_home.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,states){

          if(states is SussesFavoritePost){

            if(!states.favoritesModel.status) {
              showToast(
                state: ToastStates.ERROR,
                text: states.favoritesModel.message,
              );
            }
          }

        },
        builder: (context,states){

         var cubit = HomeCubit.get(context);


          return ConditionalBuilder(


              condition: cubit.homeModel!=null && cubit.categoriesModel!=null,
              fallback: (context)=>const Center(child: CircularProgressIndicator(),),
              builder:(context)=>productBuilder(cubit.homeModel,cubit.categoriesModel,context),

          );

        },
    );


  }
  Widget productBuilder (HomeModel homeModel,
      CategoriesModel categoriesModel,
      context) => SingleChildScrollView(

    child: Column(
        children: [

          CarouselSlider(
              items:homeModel.data.banner.map((e) =>
                  Image(image: NetworkImage(e.image),width: double.infinity,)).toList(),
              options: CarouselOptions(
                autoPlay: true,
                height: 220,
                initialPage: 0,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,


              ),

          ),

          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Categories',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w400),),

                SizedBox(
                  height: 130,
                  child: ListView.separated(
                      itemBuilder: (context,index)=>buildCategories(categoriesModel.dataCategories.data[index]),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder:(context,index)=> const SizedBox(width: 10,),
                      itemCount: categoriesModel.dataCategories.data.length),
                ),

                const SizedBox(height: 20,),

                const Text('Products',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w400),),
              ],
            ),
          ),

          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio:1/1.71,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(homeModel.data.products.length,
                    (index) =>buildProductsGridView(homeModel.data.products[index],context),
                ),),
          ),
        ],
      ),
  );

  Widget buildProductsGridView(Products products,context)=>InkWell(
    onTap: (){
      navigate(ProductDetails(ID:products.id,), context);
    },
    child:  Container(
      color: Colors.white,
      child: Column(


        children: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image(image: NetworkImage(products.image),height: 200,width: double.infinity,),
                    if(products.discount!=0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.red,
                        child: const Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 9.0),),

                      ),

                  ],
                  alignment: Alignment.bottomLeft,
                ),

                Text(products.name,maxLines: 2,style: const TextStyle(color: Colors.black,fontSize: 14),),

                Row(
                  children: [
                    Text(
                      '${products.price}',style: const TextStyle(color: Colors.blue),),

                    const SizedBox(width: 10,),

                    if(products.discount !=0)

                      Text('${products.oldPrice}',
                        style: const TextStyle(fontSize: 11,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),),

                    const Spacer(),

                    IconButton(onPressed: (){

                      HomeCubit.get(context).postFavorites(products.id);
                    },
                        iconSize: 20,
                        icon: Icon(
                          HomeCubit.get(context).favorites[products.id]
                              ?Icons.favorite:Icons.favorite_border,

                          color:HomeCubit.get(context).favorites[products.id]
                              ?Colors.red:Colors.grey.withOpacity(0.5) ,

                        )),

                  ],
                ),
              ],
            ),
          )



        ],),
    ),
  );

  Widget buildCategories (Data data)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(data.image),width: 120,height: 130,),
      Container(
        width: 120,
        color: Colors.black.withOpacity(0.7),
          child: Text(data.name,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            maxLines: 1,overflow: TextOverflow.ellipsis,),

      ),
    ],
  );



}
