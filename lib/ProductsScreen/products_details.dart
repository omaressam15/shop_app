import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ProductsScreen/Cubit/cubit.dart';
import 'package:shop_app/ProductsScreen/Cubit/state.dart';
import 'package:shop_app/model/products_model_details.dart';

class ProductDetails extends StatelessWidget {

  final int ID;

  const ProductDetails({Key key, this.ID}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>DetailsCubit()..getDetailsProducts(ID),
      child: BlocConsumer<DetailsCubit,States>(
          listener: (context,stats){},
          builder: (context,stats){

            var model = DetailsCubit.get(context).productModelDetails;


            return Scaffold(
              appBar: AppBar(),


              body:ConditionalBuilder(
                condition: (model !=null),
                builder:(context)=> itemBulider(model.data,context),
                fallback: (context)=>const Center(child: CircularProgressIndicator(),),
              ),
            );

          }


      ),
    );
  }
  Widget itemBulider(DataProducts data,context)=>SingleChildScrollView(

    child: Column(
      children:  [

        CarouselSlider(

          items: data.image.map((e) =>Image(image: NetworkImage(e),width: double.infinity,height: 210,)).toList(),
          carouselController:DetailsCubit.get(context).buttonCarouselController ,
          options: CarouselOptions(

            autoPlay: true,
            height: 230,
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

      /*  SmoothPageIndicator(
          count: data.image.length,
          effect: const ExpandingDotsEffect(
            dotColor: Colors.grey,
            activeDotColor: Colors.blue,
            dotHeight: 8,
            expansionFactor: 4,
            dotWidth: 8,
            spacing: 5.0,

          ),

        ),*/


        Padding(
           padding: const EdgeInsets.all(20),
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.name,style: const TextStyle(fontSize: 17,color: Colors.black),),

              Row(
                children: [
                  Text(
                    'Price  ${data.price}',style: const TextStyle(color: Colors.blue,fontSize: 16),),
                  const SizedBox(width: 10,),
                  if(data.discount !=0)
                    Text('${data.oldPrice}',style: const TextStyle(fontSize: 13,color: Colors.grey,decoration: TextDecoration.lineThrough),),

                ],
              ),
              
              const Text('Description',style: TextStyle(color: Colors.black,fontSize: 30),),
              
              SizedBox(

                child: Text(data.description,style: TextStyle(fontSize: 15,color: Colors.grey[800]),),
                width: double.infinity,
              ),
            ],
          ),
        ),

      ],
    ),
  );
}
