import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_cubit.dart';
import 'package:shop_app/HomeShop/HomeCubit/home_states.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();


    return BlocConsumer<HomeCubit,HomeStates>(

        listener: (context,stats){},

       builder: (context,stats){

         var model= HomeCubit.get(context).shopUserData;

         nameController.text = model.data.name;
         emailController.text = model.data.email;
         phoneController.text = model.data.phone;

          return ConditionalBuilder(

            condition: HomeCubit.get(context).getUserData != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children:
                  [
                    if(stats is LoadingUpdateUserScreen)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      textInputType: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }

                        return null;
                      },
                      label: 'Name',
                      iconData: Icons.person,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'email must not be empty';
                        }

                        return null;
                      },
                      label: 'Email Address',
                      iconData: Icons.email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty';
                        }

                        return null;
                      },
                      label: 'Phone',
                      iconData: Icons.phone,
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      function: ()
                      {
                        if(formKey.currentState.validate())
                        {
                          HomeCubit.get(context).updateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        }
                      },
                      text: 'update',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    defaultButton(
                      function: ()=>signOut(context),

                      text: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
    );

        }
  }
