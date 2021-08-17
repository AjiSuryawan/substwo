import '../model/restaurant_model.dart';

abstract class ListFoodState {
  final RestaurantModel listFoodKu;

  ListFoodState({this.listFoodKu});
}

class ListFoodInitial extends ListFoodState {}

class OnListFoodState extends ListFoodState {
  RestaurantModel listFood;

  OnListFoodState({this.listFood,})
      : super(listFoodKu: listFood);


  OnListFoodState copyWith(
      {
        final RestaurantModel myFoodModel,
        }) {
    return OnListFoodState(
        listFood: myFoodModel ?? this.listFood,
        );
  }
}
