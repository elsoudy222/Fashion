import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/view/const/fonts.dart';
import 'package:fashion/view_model/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isShowPass = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(0.0),
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                            size: 20,
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Login",
                        style: AppFont.bold.copyWith(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // TextFieldAddress(vi
                      //     textEditingController: emailController, lableText: "Email"),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(1, 1),
                              ),
                            ]),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Email",
                            alignLabelWithHint: true, // center labastyle
                            labelStyle: AppFont.regular.copyWith(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(1, 1),
                              ),
                            ]),
                        child: TextFormField(
                          controller: passController,
                          obscureText: isShowPass,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Password",
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isShowPass = !isShowPass;
                                  });
                                },
                                child: Icon(
                                  isShowPass ? Icons.visibility : Icons
                                      .visibility_off,
                                  size: 16,
                                )),
                            alignLabelWithHint: true,
                            // center labastyle
                            labelStyle: AppFont.regular.copyWith(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
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
                      SizedBox(
                        height: 35,
                      ),
                      ConditionalBuilder(
                          condition: true,
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
                              onPressed: () {

                              },
                              child: Text(
                                "Login".toUpperCase(),
                                style: AppFont.medium
                                    .copyWith(fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                          fallback: (context)=> Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                      ),

                      Spacer(),
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
                      SizedBox(
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
                      SizedBox(
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
                                      offset: Offset(1, 1),
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
                                      offset: Offset(1, 1),
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
          );
        },
      ),
    );
  }
}
