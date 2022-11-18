import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion/data/model/categories_model.dart';
import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view/const/fonts.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/categories_widgets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var cubit = LayoutCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Categories",
          style: AppFont.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.black,),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
             buildSalesSide(),
              SizedBox(height: 16.0,),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.9,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount:cubit.categoriesModel!.data!.data!.length,
                  itemBuilder: (context, index) =>
                      buildCategoryItem(cubit.categoriesModel!.data!.data![index]),
                  separatorBuilder: (context, index) => SizedBox(height: 16.0,),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  },
);
  }
}




