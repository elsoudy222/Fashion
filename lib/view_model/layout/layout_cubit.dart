import 'package:bloc/bloc.dart';
import 'package:fashion/components/constance.dart';
import 'package:fashion/data/model/address/add_address_model.dart';
import 'package:fashion/data/model/carts_model.dart';
import 'package:fashion/data/model/categories_model.dart';
import 'package:fashion/data/model/home_model.dart';
import 'package:fashion/data/model/product_details_model.dart';
import 'package:fashion/data/services/dio_helper.dart';
import 'package:fashion/data/services/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/address/address_model.dart';
import '../../data/model/address/update_address_model.dart';
import '../../data/model/change_cart_model.dart';
import '../../data/model/change_cart_model.dart';
import '../../data/model/change_favorites_model.dart';
import '../../data/model/favorites_model.dart';
import '../../view/screens/cart_screen/cart_screen.dart';
import '../../view/screens/category_screen/category_screen.dart';
import '../../view/screens/favorites_screen/favorites_screen.dart';
import '../../view/screens/home_screen/home_screen.dart';
import '../../view/screens/profile_screen/profile_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(LayoutChangeNavBarStates());
  }

 
  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};

  HomeModel? homeModel;
  void getHomeData() {
    emit(LoadingHomeDataStates());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      homeModel!.data!.products!.forEach((element) {
        cart.addAll({
          element.id!: element.inCart!,
        });
      });
      //   print(favorites.toString());
      emit(SuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeDataStates(error));
    });
  }
  
  ProductDetailsModel? productDetailsModel;
  void getProductDetails(int productId){
    emit(LoadingProductDetailsStates());
    DioHelper.getData(
      url: PRODUCTDETAILS + productId.toString(),
      token: token,
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(SuccessProductDetailsStates());
    }).catchError((error){
      emit(ErrorProductDetailsStates(error.toString()));
      print(error.toString());
    });
  }


  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(LoadingCategoryDataStates());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(value.data);
      emit(SuccessCategoryDataStates());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ErrorCategoryDataStates(error));
    });
  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesStates());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        "product_id": productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(SuccessChangeFavoritesStates(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ErrorChangeFavoritesStates(error));
      print(error.toString());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(LoadingGetFavoritesStates());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(SuccessGetFavoritesStates());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ErrorGetFavoritesStates(error));
    });
  }

  ChangeCartModel? changeCartModel;

  void changeCart(int productId) {
    cart[productId] = !cart[productId]!;
    emit(ChangeCartsStates());
    DioHelper.postData(
            url: CARTS,
            data: {
              "product_id": productId,
            },
            token: token)
        .then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      if (!changeCartModel!.status!) {
        cart[productId] = !cart[productId]!;
      } else {
        getCarts();
      }
      emit(SuccessChangeCartsStates(changeCartModel!));
    }).catchError((error) {
      cart[productId] = !cart[productId]!;
      emit(ErrorChangeCartsStates(error));
    });
  }

  CartsModel? cartsModel;
  void getCarts() {
    emit(LoadingGetCartsStates());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartsModel = CartsModel.fromJson(value.data);
      print(value.data);
      emit(SuccessGetCartsStates());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ErrorGetCartsStates(error));
    });
  }

  int quantity = 1;
  void plusQuantity(CartsModel model, index) {
    quantity = model.data!.cartItems![index].quantity!;
    quantity++;
    emit(PlusQuantityStates());
  }

  void minusQuantity(CartsModel model, index) {
    quantity = model.data!.cartItems![index].quantity!;
    if (quantity > 1) quantity--;
    emit(MinusQuantityStates());
  }

  void updateCartsData({
    required String id,
    int? quantity,
  }) {
    DioHelper.putData(
            url: "${UPDATECARTS + id}",
            data: {
              "quantity": quantity,
            },
            token: token)
        .then((value) {
      emit(SuccessUpdateCartsDataStates());
      getCarts();
    }).catchError((error) {
      emit(ErrorUpdateCartsDataStates(error.toString()));
      printFullText(error.toString());
    });
  }

  AddressModel? addressModel;
  void getAddress() {
    emit(LoadingGetAddressStates());
    DioHelper.getData(url: ADDRESS, token: token).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      print(value.data);
      emit(SuccessGetAddressStates());
    }).catchError((error) {
      emit(ErrorGetAddressStates(error.toString()));
      print(error.toString());
    });
  }

  AddAddressModel? addAddressModel;
  void addAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(LoadingAddAddressStates());
    DioHelper.postData(
      url: ADDRESS,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
      token: token,
    ).then((value){
      addAddressModel = AddAddressModel.fromJson(value.data);
      if (addAddressModel!.status) getAddress();
      emit(SuccessAddAddressStates(addAddressModel!));
    }).catchError((error){
      emit(ErrorAddAddressStates(error));
      print(error.toString());
    });
  }


  UpdateAddressModel? updateAddressModel;
  void updateAddress({
    required int ?addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(LoadingUpdateAddressStates());
    DioHelper.putData(
        url: 'addresses/$addressId',
        token: token,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        }
    ).then((value) {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      if (updateAddressModel!.status!) getAddress();
      emit(SuccessUpdateAddressStates(updateAddressModel!));
    }).catchError((error) {
      emit(ErrorUpdateAddressStates(error.toString()));
      print("Error is :::::::::::::" + error.toString());
    });
  }

  UpdateAddressModel? deleteAddressModel;
  void deleteAddress({required addressId}) {
    emit(LoadingDeleteAddressStates());
    DioHelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value) {
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      if (deleteAddressModel!.status!) getAddress();
      emit(SuccessDeleteAddressStates());
    }).catchError((error) {
      emit(ErrorDeleteAddressStates(error.toString()));
      print(error.toString());
    });
  }














}
