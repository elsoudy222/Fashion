import 'package:fashion/components/components.dart';
import 'package:fashion/data/model/address/address_model.dart';
import 'package:fashion/view/screens/add_address/add_address_screen.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';

import '../../../const/colors.dart';
import '../../../const/fonts.dart';

class AddressItem extends StatefulWidget {
  AddressData model;
  late bool checkbok = false;

  AddressItem({Key? key, required this.model}) : super(key: key);

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.model.name!,
                style: AppFont.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              TextButton(
                child: Text(
                  "Edit",
                  style: AppFont.regular.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: AppColors.primaryColorRed),
                ),
                onPressed: () {
                  navigateTo(
                    context,
                    AddOrUpdateAddressScreen(
                      isEdit: true,
                      addressId: widget.model.id,
                      name: widget.model.name,
                      city: widget.model.city,
                      region: widget.model.region,
                      details: widget.model.details,
                      notes: widget.model.notes,
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  LayoutCubit.get(context).deleteAddress(addressId: widget.model.id);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 25,
                  color: AppColors.primaryColorRed,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Container(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'City',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Region',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Details',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Notes',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.model.city!,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.model.region!,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.model.details!,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.model.notes!,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                  //
                ],
              )
            ],
          ),
          RadioListTile(
              value: widget.checkbok,
              contentPadding: EdgeInsets.all(0.0),
              title: Text(
                "Use as the shipping address",
                style: AppFont.regular.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              groupValue: widget.checkbok,
              onChanged: (value) {
                setState(() {
                  widget.checkbok != widget.checkbok;
                });
              })
        ],
      ),
    );
  }
}
