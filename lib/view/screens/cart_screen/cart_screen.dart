import 'package:fashion/view/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title:Text(
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
            icon: const Icon(Icons.search, color: Colors.black,),
          )
        ],
      ),
      body:  SingleChildScrollView(
    child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                 height: MediaQuery.of(context).size.height *  0.5,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) => buildCartItem(),
                  separatorBuilder: (context, index) => const SizedBox(height: 16.0,),
                ),
              ),
              const SizedBox(height: 15.0,),
              buildPromoCode(context),
              const SizedBox(height: 20.0,),
              buildTotalPrice(),
              const SizedBox(height: 20.0,),
              buildCheckOutButton(context)
            ],
          ),
        ),
),
      
    );
  }
}

Widget buildCartItem() {
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
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft:  Radius.circular(15.0),
              bottomLeft:  Radius.circular(15.0),
            ),
            child: Image.asset(
              "assets/image/header.png",
              fit: BoxFit.cover,
              height: 120,

            ),
          ),
        ),
        Expanded(
          flex: 2,
            child: Padding(
              padding: const EdgeInsets.all( 15.0),
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("T-Shirt",style: AppFont.bold,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text("Color: Black"),
                              SizedBox(width: 10,),
                              Text("Size: L"),
                            ],
                          )

                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.dashboard),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(.1),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: (){},
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                              flex: 1,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Flexible(
                              flex: 2,
                              child: Text("1"),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: (){

                                },
                                child: const Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Text("100 \$")
                    ],
                  ),
                ],
              )
            )
        ),

      ],
    ),
  );
}

Widget buildPromoCode(context){
  return Stack(

    children:[
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
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
        ),
      ),

      Positioned(
        right: 0.0,
    child: Container(
        height: 40.0,
        width: 50.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black
        ),
      child: IconButton(
          onPressed: (){
            buildBottomSheet(context);
          },
          icon: const Icon(Icons.arrow_forward,color: Colors.white,),
      )
      ),
)
    ]
);
}

Widget buildTotalPrice(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
          "Total amount:",
        style: AppFont.regular.copyWith(
          color: Colors.grey
        ),
      ),
      Text("150 D",style: AppFont.bold),
    ],
  );
}

Widget buildCheckOutButton(context){
  return InkWell(
    onTap: (){
      
    },
    child: Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColorRed,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.black)
      ),
      child: Center(
        child: Text(
          "CHECK OUT",
          style: AppFont.regular.copyWith(
              color: Colors.white
          ),
        ),
      ),
    ),
  );
}

Future buildBottomSheet(context)async{
  return showModalBottomSheet(
      context: context,
      builder: (context){
        return  Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width:  double.infinity,
          decoration: BoxDecoration(
              color:  AppColors.primaryBackground,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30)
            )
          ),
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 40,
                right: 10,
                left: 10
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                    children:[
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  TextFormField(

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
                                shape: BoxShape.circle,
                                color: Colors.black
                            ),
                            child: Icon(
                              Icons.arrow_forward,color: Colors.white,),
                          )
                      ),

                    ]
                ),
                SizedBox(height: 20.0,),
                Text(
                  " Your Promo Codes",
                  style: AppFont.semiBold.copyWith(
                    fontSize: 22
                  )
                ),
              ],
            ),
          )
        ) ;
      }
  );
}

