import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view/screens/cart_screen/cart_screen.dart';
import 'package:fashion/view/screens/category_screen/category_screen.dart';
import 'package:fashion/view/screens/favorites_screen/favorites_screen.dart';
import 'package:fashion/view/screens/home_screen/home_screen.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = LayoutCubit.get(context);

        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 2,
            currentIndex: cubit.currentIndex,
            unselectedItemColor: AppColors.primaryColorGray,
            selectedItemColor: AppColors.primaryColorRed,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: cubit.currentIndex != 0
                    ? SvgPicture.asset('assets/image/home_inactive.svg')
                    : SvgPicture.asset('assets/image/home_active.svg'),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: cubit.currentIndex != 1
                    ? SvgPicture.asset('assets/image/categories_inactive.svg')
                    : SvgPicture.asset('assets/image/categories_active.svg'),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: cubit.currentIndex != 2
                    ? SvgPicture.asset('assets/image/bag_inactive.svg')
                    : SvgPicture.asset('assets/image/bag_active.svg'),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: cubit.currentIndex != 3
                    ? SvgPicture.asset('assets/image/hear_inactive.svg')
                    : SvgPicture.asset('assets/image/hear_active.svg'),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: cubit.currentIndex != 4
                    ? SvgPicture.asset('assets/image/profile_inactive.svg')
                    : SvgPicture.asset('assets/image/profile_active.svg'),
                label: 'Personal',
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
