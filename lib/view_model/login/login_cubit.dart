import 'package:fashion/data/model/login_model.dart';
import 'package:fashion/data/services/dio_helper.dart';
import 'package:fashion/data/services/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeVisPassword(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangePassVisibilityState());
  }



  late LoginModel loginModel;
  // Login method :
  void userLogin(
  {
    required String email,
    required String password,
}
){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email' : email,
          'password' : password
    }).then((value){
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data?.token);
      print(loginModel.data?.name);
      print(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

}
