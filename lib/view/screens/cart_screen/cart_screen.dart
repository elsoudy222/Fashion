import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/components/components.dart';
import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/carts_model.dart';
import '../../const/fonts.dart';
import '../Address_screen/address_screen.dart';
import '../add_address/add_address_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
            backgroundColor: AppColors.primaryBackground,
            appBar: AppBar(
              title: Text(
                "My Bag",
                style: AppFont.bold.copyWith(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! LoadingGetCartsStates,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: cubit.cartsModel!.data!.cartItems!.length,
                          itemBuilder: (context, index) => buildCartItem(
                              cubit.cartsModel!.data!.cartItems![index],
                              context,
                              index),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      buildPromoCode(context),
                      const SizedBox(
                        height: 20.0,
                      ),
                      buildTotalPrice(context),
                      const SizedBox(
                        height: 20.0,
                      ),
                      buildCheckOutButton(context)
                    ],
                  ),
                ),
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ));
      },
    );
  }
}

Widget buildCartItem(CartItems cartItems, context, index) {
  var cubit = LayoutCubit.get(context);
  return Container(
    height: 120.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Image.network(
                  "${cartItems.product!.image}",
                  fit: BoxFit.cover,
                  height: 120,
                ),
              ),
              if (cubit.cartsModel!.data!.cartItems![index].product!.discount !=
                  0)
                Positioned(
                  left: 0,
                  bottom: 10,
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: AppColors.primaryColorRed,
                    ),
                    width: MediaQuery.of(context).size.width * 0.11,
                    child: Center(
                      child: Text(
                        "${cubit.cartsModel!.data!.cartItems![index].product!.discount}%",
                        style: AppFont.bold.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "${cartItems.product!.name}",
                                style: AppFont.bold,
                                maxLines: 1,
                              ),
                              width: 180,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text("Color: Black"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Size: L"),
                              ],
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.changeCart(cubit.cartsModel!.data!
                                .cartItems![index].product!.id!);
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        RawMaterialButton(
                          elevation: 0,
                          shape: const CircleBorder(),
                          fillColor: AppColors.primaryColorRed,
                          onPressed: () {
                            cubit.plusQuantity(cubit.cartsModel!, index);
                            cubit.updateCartsData(
                              id: cubit.cartsModel!.data!.cartItems![index].id
                                  .toString(),
                              quantity: cubit.quantity,
                            );
                            print(index.toString());
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                          constraints: const BoxConstraints.tightFor(
                              height: 30, width: 30),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          LayoutCubit.get(context)
                              .cartsModel!
                              .data!
                              .cartItems![index]
                              .quantity
                              .toString(),
                          style: const TextStyle(fontSize: 23.0),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        RawMaterialButton(
                          elevation: 0,
                          shape: const CircleBorder(),
                          fillColor: AppColors.primaryColorGray,
                          onPressed: () {
                            cubit.minusQuantity(cubit.cartsModel!, index);
                            cubit.updateCartsData(
                              id: cubit.cartsModel!.data!.cartItems![index].id
                                  .toString(),
                              quantity: cubit.quantity,
                            );
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 20,
                          ),
                          constraints: const BoxConstraints.tightFor(
                              height: 30, width: 30),
                        ),
                        const Spacer(),
                        Text(
                          "${cartItems.product!.price}",
                          style:
                              const TextStyle(color: AppColors.primaryColorRed),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        if (cubit.cartsModel!.data!.cartItems![index].product!
                                .discount !=
                            0)
                          Text(
                            "${cartItems.product!.oldPrice}",
                            style: AppFont.bold.copyWith(
                              fontSize: 14,
                              color: AppColors.primaryColorGray,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ))),
      ],
    ),
  );
}

Widget buildPromoCode(context) {
  return Stack(children: [
    Container(
      height: 40.0,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "Enter your promo code..",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ),
    Positioned(
      right: 0.0,
      child: Container(
          height: 40.0,
          width: 50.0,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          child: IconButton(
            onPressed: () {
              buildBottomSheet(context);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          )),
    )
  ]);
}

Widget buildTotalPrice(context) {
  var cubit = LayoutCubit.get(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Total amount:",
        style: AppFont.regular.copyWith(color: Colors.grey),
      ),
      Text('${cubit.cartsModel!.data!.total} EGP', style: AppFont.bold),
    ],
  );
}

Widget buildCheckOutButton(context) {
  return InkWell(
    onTap: () {
      navigateTo(context, const AddressScreen());
    },
    child: Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColorRed,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          "CHECK OUT",
          style: AppFont.regular.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}

Future buildBottomSheet(context) async {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                      height: 40.0,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        // controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your promo code ",
                          alignLabelWithHint: true, // center labastyle
                          labelStyle: AppFont.regular.copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 0.0,
                        child: Container(
                          height: 40.0,
                          width: 30.0,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )),
                  ]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(" Your Promo Codes",
                      style: AppFont.semiBold.copyWith(fontSize: 22)),
                ],
              ),
            ));
      });
}
