import 'package:bloc/bloc.dart';
import 'package:fashion/components/constance.dart';
import 'package:fashion/data/model/carts_model.dart';
import 'package:fashion/data/model/categories_model.dart';
import 'package:fashion/data/model/home_model.dart';
import 'package:fashion/data/services/dio_helper.dart';
import 'package:fashion/data/services/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/change_cart_model.dart';
import '../../data/model/change_cart_model.dart';
import '../../data/model/change_favorites_model.dart';
import '../../data/model/favorites_model.dart';
import '../../view/screens/cart_screen/cart_screen.dart';
import '../../view/screens/category_screen/category_screen.dart';
import '../../view/screens/favorites_screen/favorites_screen.dart';
import '../../view/screens/home_screen/home_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    FavoritesScreen(),
    FavoritesScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(LayoutChangeNavBarStates());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};

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
            token: token
    ).then((value) {
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
  void plusQuantity(CartsModel model, index){
    quantity = model.data!.cartItems![index].quantity!;
    quantity++ ;
    emit(PlusQuantityStates());
  }

  void minusQuantity(CartsModel model, index){
    quantity = model.data!.cartItems![index].quantity!;
    if (quantity > 1) quantity--;
    emit(MinusQuantityStates());
  }


void updateCartsData({
  required String id,
  int? quantity,
}){
    DioHelper.putData(
        url: "${UPDATECARTS + id.toString()}",
        data: {
          "quantity" : quantity,
        },
      token: token
    ).then((value){
      emit(SuccessUpdateCartsDataStates());
      getCarts();
    }).catchError((error){
      emit(ErrorUpdateCartsDataStates(error.toString()));
      printFullText(error.toString());
    });
}





}
