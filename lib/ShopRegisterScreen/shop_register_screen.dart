import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/sherd_prefrens.dart';
import 'package:shop_app/ShopLayout/shop_screen.dart';
import 'package:shop_app/ShopRegisterScreen/CubitForRegstration/register_cubite.dart';
import '../components.dart';
import '../constants.dart';
import 'CubitForRegstration/register_stats.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({Key key}) : super(key: key);

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(

      create:(BuildContext context) => ShopRegistrationCubit(),

      child: BlocConsumer<ShopRegistrationCubit,ShopRegistrationStates>(
        listener: (context,state){

          if(state is ShopRegistrationSuccessState){

            if(state.loginModel.status){

              print(state.loginModel.data.token);
              print(state.loginModel.message);

              CacheHelper.saveData(key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token =state.loginModel.data.token;
                navigateNoBack(const ShopScreen(), context);
              });


            }else{
              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }

          }

        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[

                        Text('Registration',style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),),

                        Text(
                          'Registration now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(

                            controller: nameController,
                            textInputType: TextInputType.name,
                            iconData: Icons.person,
                            label: 'name',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter your name';

                              }

                            }
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        defaultFormField(

                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            iconData: Icons.email,
                            label: 'Email Address',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter your email address';

                              }

                            }
                        ),



                        const SizedBox(
                          height: 30,
                        ),

                        defaultFormField(

                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            isPassword: ShopRegistrationCubit.get(context).isPassword,
                            iconData: Icons.lock,
                            isPressed: (){
                              ShopRegistrationCubit.get(context).changePasswordVisibility();
                            },
                            suffix: ShopRegistrationCubit.get(context).suffix,
                            label: 'Password',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter your password';

                              }

                            }
                        ),


                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(

                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            iconData: Icons.phone,
                            label: 'phone',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter phone';

                              }

                            }
                        ),


                        const SizedBox(height: 30,),

                        ConditionalBuilder(
                          condition: state is! ShopRegistrationLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopRegistrationCubit.get(context).registrationUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,

                                );
                              }
                            },
                            text: 'Registration',
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

