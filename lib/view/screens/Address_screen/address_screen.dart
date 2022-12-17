import 'package:fashion/components/components.dart';
import 'package:flutter/material.dart';
import '../../../view_model/layout/layout_cubit.dart';
import '../../const/fonts.dart';
import '../add_address/add_address_screen.dart';
import 'widgets/address_item.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Shipping Address",
          style: AppFont.semiBold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder:(context,index) => LayoutCubit.get(context).addressModel!.data!.data!.length == 0?
                  Container(
                  ):
                 AddressItem (model:LayoutCubit.get(context).addressModel!.data!.data![index]),
                  separatorBuilder:(context,index) => Container(height: 15,),
                  itemCount: LayoutCubit.get(context).addressModel!.data!.data!.length
              ),
              const SizedBox(height: 100,width: double.infinity,)
            ],
          ),
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateTo(context, AddOrUpdateAddressScreen(isEdit: false,)),
        backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}

// Widget addressItem(AddressData model,context) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding (
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           children: [
//             const Icon(Icons.location_on_outlined,color: Colors.green,),
//             const SizedBox(width: 5,),
//             Text (model.name!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//             const SizedBox(
//               width: 10,
//             ),
//             TextButton(
//                 onPressed: (){
//                 //  LayoutCubit.get(context).deleteAddress(addressId: model.id);
//                 },
//                 child: Expanded(
//                   child: Row(children:
//                   const[
//                     Icon(Icons.delete_outline,size: 17,),
//                     Text('Delete')
//                   ],),
//                 )
//             ),
//             Container(height: 20,width: 1,color: Colors.grey[300],),
//             Expanded(
//               child: TextButton(
//                   onPressed: (){
//                     // navigateTo(context, AddOrUpdateAddress(
//                     //   isEdit: true,
//                     //   addressId: model.id,
//                     //   name: model.name,
//                     //   city: model.city,
//                     //   region: model.region,
//                     //   details: model.details,
//                     //   notes: model.notes,
//                     // ));
//                   },
//                   child: Row(
//                     children: const[
//                       Icon(Icons.edit,size: 17,color: Colors.grey,),
//                       Text('Edit',style: TextStyle(color: Colors.grey),)
//                     ],)
//               ),
//             ),
//
//
//
//           ],
//         ),
//       ),
//
//       Padding(
//         padding: const EdgeInsets.all(15),
//         child: Row(
//           children: [
//             Container(
//               width : 100,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text('City',style: TextStyle(fontSize: 15,color: Colors.grey),),
//                   SizedBox(height: 10,),
//                   Text('Region',style: TextStyle(fontSize: 15,color: Colors.grey),),
//                   SizedBox(height: 10,),
//                   Text('Details',style: TextStyle(fontSize: 15,color: Colors.grey),),
//                   SizedBox(height: 10,),
//                   Text('Notes',style: TextStyle(fontSize: 15,color: Colors.grey),),
//                 ],
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(model.city!,style: const TextStyle(fontSize: 15,)),
//                 const SizedBox(height: 10,),
//                 Text(model.region!,style: const TextStyle(fontSize: 15,)),
//                 const SizedBox(height: 10,),
//                 Text(model.details!,style: const TextStyle(fontSize: 15,)),
//                 const SizedBox(height: 10,),
//                 Text(model.notes!,style: const TextStyle(fontSize: 15,)),
//                 //
//               ],)
//           ],
//         ),
//       ),
//     ],
//   );
// }

