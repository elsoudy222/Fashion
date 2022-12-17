
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/components/components.dart';
import 'package:fashion/data/model/home_model.dart';
import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view/screens/home_screen/widgets/body.dart';
import 'package:fashion/view/screens/home_screen/widgets/header.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../const/fonts.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context, state) {
        if(state is SuccessChangeFavoritesStates){
          if(state.model.status!){
            showToast(text: state.model.message!, state: ToastState.SUCCESS);
          }if(!state.model.status!){
            showToast(text: "غير مصرح لك بالتعديل حاليا", state: ToastState.ERROR);
          }
        }
        if(state is SuccessChangeCartsStates){
          if(state.cartModel.status!){
            showToast(text: state.cartModel.message!, state: ToastState.SUCCESS);
          }if(!state.cartModel.status!){
            showToast(text: "غير مصرح لك بالتعديل حاليا", state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (context) =>
              SingleChildScrollView(
                child: Column(
                  children: [
                    homeHeader(cubit.homeModel),
                    const SizedBox(
                      height: 15,
                    ),
                      homeBody(cubit.homeModel,context,),
                    const SizedBox(
                      height: 2,
                    ),
                    homeBody(cubit.homeModel,context),
                  ],
                ),
              ),
          fallback: (context) =>
          const Center(
            child: CircularProgressIndicator.adaptive(backgroundColor: AppColors.primaryColorRed,),
          ),
        );
      },
    );
  }
}


