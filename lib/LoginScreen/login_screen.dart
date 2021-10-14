import 'dart:math';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Dio/sherd_prefrens.dart';
import 'package:shop_app/LoginScreen/Cubite/cubite_stats.dart';
import 'package:shop_app/LoginScreen/Cubite/login_cubite.dart';
import 'package:shop_app/ShopLayout/shop_screen.dart';
import 'package:shop_app/ShopRegisterScreen/shop_register_screen.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/constants.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(

      create:(BuildContext context) => ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){

          if(state is ShopLoginSuccessState){

            if(state.loginModel.status){

              print(state.loginModel.data.token);
              print(state.loginModel.message);

              CacheHelper.saveData(key: 'token', value: state.loginModel.data.token)
                  .then((value) {

                   token = state.loginModel.data.token;

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

                        Text('Login',style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),),

                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 30,),

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
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            iconData: Icons.email,
                            isPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            },
                            suffix: ShopLoginCubit.get(context).suffix,
                            label: 'Password',
                            validator: (String value){

                              if(value.isEmpty){
                                return 'please enter your password';

                              }

                            }
                        ),

                        const SizedBox(height: 30,),

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                         const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigate(
                                    ShopRegisterScreen(),
                                  context,
                                );
                              },
                              text: 'register',
                            ),
                          ],
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
