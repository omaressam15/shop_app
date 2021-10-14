import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ProductsScreen/products_details.dart';
import 'package:shop_app/SearchScreen/CubitSearch/cubit.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/model/search_model.dart';

import 'CubitSearch/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    var formKey = GlobalKey<FormState>();

    return BlocProvider(
        create:(BuildContext context)=>CubitSearch(),
      child: BlocConsumer<CubitSearch,ShopSearchStates>(
        listener: (BuildContext context, state) {},

        builder: (BuildContext context, state) {

          var cubit = CubitSearch.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              title: Container(
                color: Colors.grey[200],
                width: double.infinity,

                child:Form(
                  key: formKey,
                  child: TextFormField(

                    controller:searchController,
                    onFieldSubmitted: (value){
                      cubit.postSearch(text: value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'enter text to search';
                      }
                      return null;
                    },
                    decoration:const InputDecoration(

                      hintText: 'Search...',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder:InputBorder.none


                    ) ,
                  ),
                )

              ),
            ),

            body: Column(

              children: [
                if (state is SearchLoadingState) const LinearProgressIndicator(),
                if (state is ShopSearchSuccessState)
                  Expanded(
                    child:ListView.separated(
                      itemBuilder: (context, index) => buildListViewProductItem(
                          cubit.getSearchModel.dataSearch.dataList[index], context,isOldPrice: false,fav: false),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: cubit.getSearchModel.dataSearch.dataList.length,

                  ), )

              ],
            )


          );
        },

      ),

    );
  }

}
