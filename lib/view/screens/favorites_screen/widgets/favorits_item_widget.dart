
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../components/components.dart';
import '../../../../data/model/favorites_model.dart';
import '../../../../view_model/layout/layout_cubit.dart';
import '../../../const/colors.dart';
import '../../../const/fonts.dart';

Widget buildFavoritesItem(context,FavoritesData model) {
  return Padding(
      padding: EdgeInsets.only(left: 10,top: 10.0),
    child: Container(
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
                      "${model.product!.image!}",
                      //fit: BoxFit.cover,
                      width: 160,
                      height: 220,
                    ),
                  ),
                ),
                  if( model.product!.discount != 0)
                Positioned(
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
                        "${model.product!.discount}%",
                        style: AppFont.bold.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //REMOVE FROM FAVORITES:
                Positioned(
                    top: 5.0,
                    right: 10.0,
                    child: GestureDetector(
                      onTap: (){
                        LayoutCubit.get(context).changeFavorites(model.product!.id!);
                      },
                      child: Container(

                          decoration: BoxDecoration(
                            // color: LayoutCubit.get(context).cart[e.id]!
                            //     ? AppColors.primaryColorRed
                            //     : AppColors.primaryBackground,
                          //  color:AppColors.primaryColorRed ,
                           // shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                offset: Offset(1, 1),
                                spreadRadius: 1.5,
                              ),
                            ],
                          ),

                          child: Image.asset(
                            "assets/icons/x_shape.png",
                            height: 15,
                            color: Colors.grey[900],
                          )
                      ),
                    )
                ),

                // CART Icon:
                Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: GestureDetector(
                      onTap: (){
                        LayoutCubit.get(context).changeCart(model.product!.id!);
                      },
                      child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            color: LayoutCubit.get(context).cart[model.product!.id]!
                                ? AppColors.primaryColorRed
                                : AppColors.primaryBackground,
                            //color:AppColors.primaryColorRed ,
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
                           // color:AppColors.primaryColorWhite ,
                            color: LayoutCubit.get(context).cart[model.product!.id]!
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
                  child: Text(
                    "${model.product!.name!}",
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
                      if(model.product!.discount != 0)
                    Text(
                      "${model.product!.oldPrice!}",
                      style: AppFont.bold.copyWith(
                      fontSize: 14,
                      color: AppColors.primaryColorGray,
                      decoration: TextDecoration.lineThrough,

                    ),),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "${model.product!.price!}",
                      style: AppFont.bold.copyWith(
                        fontSize: 14,
                        color: AppColors.primaryColorRed
                    ),),


                  ],
                ),

              ],
            ),
          ) ,


        ],
      ),
    ),
  );


}
