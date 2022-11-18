import 'package:fashion/data/model/home_model.dart';
import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../const/fonts.dart';



Widget homeBody(HomeModel? model,context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Sale",
                  style: AppFont.bold.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Supper sale",
                  style: AppFont.regular.copyWith(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'View all',
              style: AppFont.regular.copyWith(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 350,

          child: ListView(
            scrollDirection: Axis.horizontal,
            children: model!.data!.products!.map((e) => Padding(
              padding:  EdgeInsets.only(right: 15.0),
              child:  Container(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child:  Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10,right: 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "${e.image}",
                               // fit: BoxFit.contain,
                                width: 160,
                                height: 220,
                              ),
                            ),
                          ),
                          if(e.discount != 0) Positioned(
                            left: 10,
                            top: 10,
                            child: Container(
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppColors.primaryColorRed,
                              ),
                              width: MediaQuery.of(context).size.width * 0.11,
                              child: Center(
                                child: Text(
                                  "${e.discount}%",
                                  style: AppFont.bold.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                          // Favorites Icon:
                          Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: GestureDetector(
                                onTap: (){
                                  LayoutCubit.get(context).changeFavorites(e.id!);
                                },
                                child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                      color: LayoutCubit.get(context).favorites[e.id]!
                                          ? AppColors.primaryColorRed
                                          : AppColors.primaryBackground,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.2),
                                          offset: Offset(1, 1),
                                          spreadRadius: 1.5,
                                        ),
                                      ],
                                    ),

                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 17,
                                      color: LayoutCubit.get(context).favorites[e.id]!
                                          ? AppColors.primaryColorWhite
                                          :Colors.black,
                                    )),
                              )
                          ),

                          // CART ICON :
                          Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              child: GestureDetector(
                                onTap: (){
                                  LayoutCubit.get(context).changeCart(e.id!);
                                },
                                child:  Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                      color: LayoutCubit.get(context).cart[e.id]!
                                          ? AppColors.primaryColorRed
                                          : AppColors.primaryBackground,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.2),
                                          offset: Offset(1, 1),
                                          spreadRadius: 1.5,
                                        ),
                                      ],
                                    ),

                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 17,
                                      color: LayoutCubit.get(context).cart[e.id]!
                                          ? AppColors.primaryColorWhite
                                          :Colors.black,
                                    )),
                              )
                          ),
                        ],
                      ),
                    ),


                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 5,
                                direction: Axis.horizontal,
                                itemSize: 15,
                                itemCount: 5,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("(10)"),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text("${e.name}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppFont.bold.copyWith(
                                fontSize: 13,
                                height: 1,
                                color: Colors.black,
                              ),),
                          ),

                          // Text("title",style: AppFont.bold.copyWith(
                          //   fontSize: 17,
                          // ),),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text("${e.price}",style: AppFont.bold.copyWith(
                                  fontSize: 14,
                                  color: AppColors.primaryColorRed
                              ),),
                              SizedBox(
                                width: 8,
                              ),
                              if(e.discount != 0) Text("${e.oldPrice}",style: AppFont.bold.copyWith(
                                fontSize: 14,
                                color: AppColors.primaryColorGray,
                                decoration: TextDecoration.lineThrough,

                              ),),
                            ],
                          ),

                        ],
                      ),
                    ) ,


                  ],
                ),
              ),
            ),).toList(),
          ),
        ),

        // const SizedBox(
        //   height: 30,
        // ),
        // // buildHeaderBody(title: "New", description: "Supper new"),
        // Row(
        //   children: [
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Text(
        //           "New",
        //           style: AppFont.bold.copyWith(
        //             fontSize: 35,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 8,
        //         ),
        //         Text(
        //           "Supper new",
        //           style: AppFont.regular.copyWith(
        //             fontSize: 13,
        //             color: Colors.grey,
        //             fontWeight: FontWeight.normal,
        //           ),
        //         ),
        //       ],
        //     ),
        //     const Spacer(),
        //     Text(
        //       'View all',
        //       style: AppFont.regular.copyWith(
        //         fontSize: 13,
        //         color: Colors.black,
        //         fontWeight: FontWeight.normal,
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // SizedBox(
        //   height: 300,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (context, index)=> Padding(
        //       padding: EdgeInsets.only(right: 15.0),
        //       child: Container(
        //
        //
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Stack(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(bottom: 10,right: 2),
        //                   child: ClipRRect(
        //                     borderRadius: BorderRadius.circular(8),
        //                     child: Image.asset(
        //                       "assets/image/header.png",
        //                       fit: BoxFit.cover,
        //                       width: 160,
        //                       height: 220,
        //                     ),
        //                   ),
        //                 ),
        //                 Positioned(
        //                   left: 10,
        //                   top: 10,
        //                   child: Container(
        //                     height: 25,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(20.0),
        //                       color: AppColors.primaryColorRed,
        //                     ),
        //                     width: MediaQuery.of(context).size.width * 0.11,
        //                     child: Center(
        //                       child: Text(
        //                         "-20%",
        //                         style: AppFont.bold.copyWith(
        //                             fontSize: 11,
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.white),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 Positioned(
        //                     bottom: 0.0,
        //                     right: 0.0,
        //                     child: Container(
        //                         height: 40.0,
        //                         width: 40.0,
        //                         decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           shape: BoxShape.circle,
        //                           boxShadow: [
        //                             BoxShadow(
        //                               color: Colors.grey.withOpacity(.2),
        //                               offset: Offset(1, 1),
        //                               spreadRadius: 1.5,
        //                             ),
        //                           ],
        //                         ),
        //
        //                         child: Icon(
        //                           Icons.favorite_border,
        //                           size: 15,
        //                         ))),
        //               ],
        //             ),
        //
        //             Padding(
        //               padding: EdgeInsets.only(left: 5),
        //               child:  Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Row(
        //                     children: [
        //                       RatingBar.builder(
        //                         initialRating: 5,
        //                         direction: Axis.horizontal,
        //                         itemSize: 15,
        //                         itemCount: 5,
        //                         ignoreGestures: true,
        //                         itemBuilder: (context, _) => Icon(
        //                           Icons.star,
        //                           color: Colors.amber,
        //                         ),
        //                         onRatingUpdate: (rating) {
        //                           print(rating);
        //                         },
        //                       ),
        //                       SizedBox(
        //                         width: 5.0,
        //                       ),
        //                       Text("(10)"),
        //                     ],
        //                   ),
        //                   Text("Prand Name",style: AppFont.regular.copyWith(
        //                     fontSize: 13,
        //                     color: Colors.grey,
        //                     fontWeight: FontWeight.normal,
        //                   ),),
        //                   Text("title",style: AppFont.bold.copyWith(
        //                     fontSize: 17,
        //                   ),),
        //                   SizedBox(
        //                     height: 8,
        //                   ),
        //                   Text("price",style: AppFont.bold.copyWith(
        //                       fontSize: 14,
        //                       color: AppColors.primaryColorRed
        //                   ),),
        //                 ],
        //               ),
        //             ) ,
        //
        //
        //           ],
        //         ),
        //       ),
        //     ),
        //     separatorBuilder: (context, index)=> const SizedBox(width: 5.0,),
        //     itemCount: 10,
        //   ),
        // ),
      ],
    ),
  );
}