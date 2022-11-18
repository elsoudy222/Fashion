import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/components/components.dart';
import 'package:fashion/data/services/shared_pref.dart';
import 'package:fashion/view/const/fonts.dart';
import 'package:fashion/view_model/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/colors.dart';
import '../layout_screen/layout_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            if(state.loginModel.status!){
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(key: "token", value: state.loginModel.data!.token).then((value) {
                navigateAndFinish(context, const LayoutScreen());
              });
              showToast(
                  text: state.loginModel.message!,
                  state: ToastState.SUCCESS
              );
              navigateAndFinish(context, LayoutScreen());

            }else{
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message!,
                  state: ToastState.ERROR
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Form(
                    key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(0.0),
                              icon: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.black,
                                size: 20,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Login",
                            style: AppFont.bold.copyWith(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value){
                                if(value.isEmpty){
                                  return "Email is not true ";
                                }
                              },
                              label: "Email"
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                              controller: passController,
                              type: TextInputType.text,
                              validate: (value){
                                if(value.isEmpty){
                                  return "Password is not true ";
                                }
                              },
                              label: "Password",
                            isPassword: cubit.isPassword,
                            suffix: cubit.suffix,
                            suffixPressed: (){
                                cubit.changeVisPassword();
                              }
                          ),

                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Forgot yours password?",
                                style: AppFont.medium.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: AppColors.primaryColorRed,
                                value: true,
                                onChanged: (value) {

                                },
                              ),
                              Text("Remember me?", style: AppFont.medium.copyWith(
                                fontSize: 14,
                              ),),
                            ],
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.primaryColorRed,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ),
                                  // Function
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passController.text,
                                      );
                                    }

                                  },
                                  child: Text(
                                    "Login".toUpperCase(),
                                    style: AppFont.medium
                                        .copyWith(fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                              fallback: (context)=> const Center(
                                child:  CircularProgressIndicator.adaptive(),
                              )
                          ),

                          const Spacer(),
                          InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, RegisterScreens);
                            },
                            child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Don't have a account? ",
                                      style: AppFont.medium.copyWith(fontSize: 13),
                                      children: [
                                        TextSpan(
                                          text: "Register",
                                          style: AppFont.bold.copyWith(
                                              fontSize: 13,
                                              color: AppColors.primaryColorRed),
                                        )
                                      ]),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Center(
                            child: Text(
                              'Or',
                              style: AppFont.medium.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 80,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.1),
                                          offset: const Offset(1, 1),
                                          blurRadius: 1,
                                          spreadRadius: 2,
                                        )
                                      ]),
                                  child: SvgPicture.asset(
                                    'assets/image/ic_google.svg',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.1),
                                          offset: const Offset(1, 1),
                                          blurRadius: 1,
                                          spreadRadius: 2,
                                        )
                                      ]),
                                  child: SvgPicture.asset(
                                    'assets/image/ic_fb.svg',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ],
                            ),
                          )
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
