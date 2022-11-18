import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/home_model.dart';


Widget homeHeader(HomeModel? model) {
  return Column(
    children: [
      CarouselSlider(
        options: CarouselOptions(
          height: 300,
          viewportFraction: 1.0,
          autoPlay: true,
          enlargeCenterPage: false,

        ),
        items: model!.data!.banners!.map((e) =>
            Image(
              image: NetworkImage(
                  "${e.image}"),
              width: double.infinity,
              fit: BoxFit.cover,
            )
        ).toList(),
      )
    ],
  );
}