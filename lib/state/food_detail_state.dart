

import 'package:foodlistdicoding/model/detail_resto_model.dart';

abstract class DetailFoodState {
  final DetailRestaurantModel FoodDetailKu;

  DetailFoodState({this.FoodDetailKu});
}

class DetailFoodInitial extends DetailFoodState {}

class OnDetailFoodState extends DetailFoodState {
  DetailRestaurantModel FoodDetail;

  OnDetailFoodState({this.FoodDetail,})
      : super(FoodDetailKu: FoodDetail);


  OnDetailFoodState copyWith(
      {
        final DetailRestaurantModel myFoodModel,
      }) {
    return OnDetailFoodState(
      FoodDetail: myFoodModel ?? this.FoodDetail,
    );
  }
}