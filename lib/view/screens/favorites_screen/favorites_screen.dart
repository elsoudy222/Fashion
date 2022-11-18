import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view/screens/favorites_screen/widgets/favorits_item_widget.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/components.dart';
import '../../const/fonts.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if(state is SuccessChangeFavoritesStates){
          if(state.model.status!){
            showToast(text: state.model.message!, state: ToastState.SUCCESS);
          }if(!state.model.status!){
            showToast(text: "غير مصرح لك بالتعديل حاليا", state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
       var cubit = LayoutCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Favorites",
              style: AppFont.bold,
            ),

          ),
          body: ConditionalBuilder(
            condition: state is! LoadingGetFavoritesStates,
            builder: (context) =>SingleChildScrollView(
              child: GridView.count(
                // scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.62,
                mainAxisSpacing: 0.5,
                crossAxisSpacing: 0.1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  // Length:
                  cubit.favoritesModel!.data!.data!.length,
                  //builder widget:
                      (index) => buildFavoritesItem(
                    context,
                    cubit.favoritesModel!.data!.data![index],
                  ),
                ),

              ),
            ),
            fallback: (context) => const Center(
                child: CircularProgressIndicator.adaptive(),
            ),
          ),

        );
      },
    );
  }
}
