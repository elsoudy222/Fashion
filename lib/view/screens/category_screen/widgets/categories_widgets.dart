import 'package:flutter/material.dart';

import '../../../../data/model/categories_model.dart';
import '../../../const/colors.dart';
import '../../../const/fonts.dart';

Widget buildCategoryItem(DataModel model) {
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
                "${model.name}",
                style: AppFont.bold.copyWith(
                    fontSize: 18.0
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
            child: Image.network(
              "${model.image}",
              //fit: BoxFit.contain,
              height: 150,

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