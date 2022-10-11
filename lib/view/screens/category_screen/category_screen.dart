import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view/const/fonts.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
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

        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              buildSalesSide(),
              SizedBox(height: 16.0,),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) => buildCategoryItem(),
                  separatorBuilder: (context, index) => SizedBox(height: 16.0,),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}

Widget buildCategoryItem() {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Row(
      children: [
        Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 23.0),
              child: Text(
                "New",
                style: AppFont.bold.copyWith(
                    fontSize: 20.0
                ),
              ),
            )
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            child: Image.asset(
              "assets/image/header.png",
              fit: BoxFit.cover,
              height: 100,

            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSalesSide() {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: AppColors.primaryColorRed,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SUMMER SALES",
            style: AppFont.bold.copyWith(color: Colors.white, fontSize: 25),
          ),
          Text(
            "Up to 50% off",
            style: AppFont.regular.copyWith(color: Colors.white, fontSize: 15),
          ),

        ],
      ),
    ),
  );
}