part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class LayoutChangeNavBarStates extends LayoutState{}

class LoadingHomeDataStates extends LayoutState{}
class SuccessHomeDataStates extends LayoutState{}
class ErrorHomeDataStates extends LayoutState{
  final String error;
  ErrorHomeDataStates(this.error);
}

class LoadingProductDetailsStates extends LayoutState{}
class SuccessProductDetailsStates extends LayoutState{}
class ErrorProductDetailsStates extends LayoutState{
  final String error;
  ErrorProductDetailsStates(this.error);
}


class LoadingCategoryDataStates extends LayoutState{}
class SuccessCategoryDataStates extends LayoutState{}
class ErrorCategoryDataStates extends LayoutState{
  final String error;
  ErrorCategoryDataStates(this.error);
}

class ChangeFavoritesStates extends LayoutState{}
class SuccessChangeFavoritesStates extends LayoutState{
  final ChangeFavoritesModel model;
  SuccessChangeFavoritesStates(this.model);
}
class ErrorChangeFavoritesStates extends LayoutState{
  final String error;
  ErrorChangeFavoritesStates(this.error);
}

class LoadingGetFavoritesStates extends LayoutState{}
class SuccessGetFavoritesStates extends LayoutState{}
class ErrorGetFavoritesStates extends LayoutState{
  final String error;
  ErrorGetFavoritesStates(this.error);
}


class ChangeCartsStates extends LayoutState{}
class SuccessChangeCartsStates extends LayoutState{
  final ChangeCartModel cartModel;
  SuccessChangeCartsStates(this.cartModel);
}
class ErrorChangeCartsStates extends LayoutState{
  final String error;
  ErrorChangeCartsStates(this.error);
}


class LoadingGetCartsStates extends LayoutState{}
class SuccessGetCartsStates extends LayoutState{}
class ErrorGetCartsStates extends LayoutState{
  final String error;
  ErrorGetCartsStates(this.error);
}


class PlusQuantityStates extends LayoutState{}
class MinusQuantityStates extends LayoutState{}

class SuccessUpdateCartsDataStates extends LayoutState{}
class ErrorUpdateCartsDataStates extends LayoutState{
  final String error;
  ErrorUpdateCartsDataStates(this.error);
}


class LoadingGetAddressStates extends LayoutState{}
class SuccessGetAddressStates extends LayoutState{}
class ErrorGetAddressStates extends LayoutState{
  final String error;
  ErrorGetAddressStates(this.error);
}


class LoadingUpdateAddressStates extends LayoutState{}
class SuccessUpdateAddressStates extends LayoutState{
  final UpdateAddressModel updateAddressModel;

  SuccessUpdateAddressStates(this.updateAddressModel);
}
class ErrorUpdateAddressStates extends LayoutState{
  final String error;
  ErrorUpdateAddressStates(this.error);
}


class LoadingAddAddressStates extends LayoutState{}
class SuccessAddAddressStates extends LayoutState{
final  AddAddressModel addAddressModel;
  SuccessAddAddressStates(this.addAddressModel);
}
class ErrorAddAddressStates extends LayoutState{
  final String error;
  ErrorAddAddressStates(this.error);
}

class LoadingDeleteAddressStates extends LayoutState{}
class SuccessDeleteAddressStates extends LayoutState{}
class ErrorDeleteAddressStates extends LayoutState{
  final String error;
  ErrorDeleteAddressStates(this.error);
}



