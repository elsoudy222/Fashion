// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fashion/components/components.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/colors.dart';
import '../../const/fonts.dart';

// ignore: must_be_immutable
class AddOrUpdateAddressScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  bool isEdit;
  int? addressId;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;

  AddOrUpdateAddressScreen({
    Key? key,
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // if(state is SuccessAddOrdersStates){
        //   if(state.addOrderModel.status){
        //     showToast(text: state.addOrderModel.message, state: ToastState.SUCCESS);
        //   }
        // }
        if (state is SuccessUpdateAddressStates){
          if (state.updateAddressModel.status!) {
            showToast(text: "تم التعديل بنجاح", state: ToastState.SUCCESS);
            Navigator.pop(context);
          }
        }
        else if (state is SuccessAddAddressStates)
          if(state.addAddressModel.status) {
            showToast(text: state.addAddressModel.message, state: ToastState.SUCCESS);
            Navigator.pop(context);
          }
      },
      builder: (context, state) {
        if(isEdit){
          notesController.text = name!;
          cityController.text = city!;
          regionController.text = region!;
          detailsController.text = details!;
          notesController.text = notes!;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Adding Shipping Address",
              style: AppFont.bold.copyWith(fontSize: 15),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: AppColors.primaryColorRed),
                  ))
            ],
            elevation: 1.0,
          ),
          body: Padding(
              padding: EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (state is LoadingAddAddressStates ||
                        state is LoadingUpdateAddressStates)
                      Column(
                        children: const [
                          LinearProgressIndicator(
                            color: AppColors.primaryColorRed,
                            backgroundColor: AppColors.primaryColorGray,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return ' Please Enter Your Name';
                        }
                        return null;
                      },
                      label: "Full name",
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                    ),
                    defaultFormField(
                      controller: detailsController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return ' Please Enter Your Address';
                        }
                        return null;
                      },
                      label: "Address",
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                    ),
                    defaultFormField(
                      controller: cityController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return ' Please Enter Your City';
                        }
                        return null;
                      },
                      label: "City",
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                    ),
                    defaultFormField(
                      controller: regionController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return ' Please Enter Your State/Region';
                        }
                        return null;
                      },
                      label: "State/Region",
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                    ),
                    defaultFormField(
                      controller: notesController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return ' Please Enter some notes';
                        }
                        return null;
                      },
                      label: "Notes",
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                    ),
                    buildButton(
                        onTap: () {

                          if (formKey.currentState!.validate()) {
                            if (isEdit) {
                              LayoutCubit.get(context).updateAddress(
                                addressId: addressId,
                                name: nameController.text,
                                city: cityController.text,
                                region: regionController.text,
                                details: detailsController.text,
                                notes: notesController.text,
                              );
                            } else {
                              LayoutCubit.get(context).addAddress(
                                  name: nameController.text,
                                  city: cityController.text,
                                  region: regionController.text,
                                  details: detailsController.text,
                                  notes: notesController.text,
                              );
                            }
                          }
                          print(notesController.text);
                        }
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

Widget buildButton({
  required VoidCallback onTap,
  context}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColorRed,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          "save address".toUpperCase(),
          style: AppFont.regular.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}
