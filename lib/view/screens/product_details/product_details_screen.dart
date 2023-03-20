import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatelessWidget {
   ProductDetailsScreen({Key? key}) : super(key: key);
  PageController imageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                height: 350,
                width: double.infinity,
                child: PageView.builder(
                  controller: imageController,
                  itemBuilder: (context, index) => CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl:"https://static.thehoneycombers.com/wp-content/uploads/sites/2/2021/07/singapore-fashion-brands-Reckless-Ericka.jpg",
                  ),
                  itemCount: 5,
                ),
              ),
              SmoothPageIndicator(
                controller: imageController,
                count: 5,
                effect: const WormEffect(
                    dotColor: Colors.white,
                    activeDotColor: AppColors.primaryColorRed,
                    dotWidth: 85,
                    dotHeight: 3,
                    spacing: 0
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
