import 'dart:async';
import 'dart:convert';
import 'package:foodlistdicoding/model/detail_resto_model.dart';
import 'package:foodlistdicoding/state/food_detail_state.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:foodlistdicoding/event/food_list_event.dart';
import 'package:foodlistdicoding/model/restaurant_model.dart';

import '../state/food_list_state.dart';


class ListFoodBloc extends Bloc<ListFoodEvent, ListFoodState> {
  static String baseUrlRedesain = "https://restaurant-api.dicoding.dev/";
  ListFoodBloc() : super(ListFoodInitial());

  @override
  Stream<ListFoodState> mapEventToState(
      ListFoodEvent event,
  ) async* {
    if (event is GetListFood) {
      yield* mapEventToGetFoodList();
    }else if (event is GetListFoodSearch) {
      yield* mapEventToGetFoodListSearch(event.query);
    }
  }

  Stream<ListFoodState> mapEventToGetFoodList() async* {
    yield ListFoodInitial();


    final res = await http.get(Uri.parse(baseUrlRedesain+"list"));
    RestaurantModel foodmodel = RestaurantModel.fromJson(json.decode(res.body.toString()));

    yield OnListFoodState(listFood: foodmodel);
  }

  Stream<ListFoodState> mapEventToGetFoodListSearch(String query) async* {
    yield ListFoodInitial();


    final res = await http.get(Uri.parse(baseUrlRedesain+"search?q="+query));
    RestaurantModel foodmodel = RestaurantModel.fromJson(json.decode(res.body.toString()));

    yield OnListFoodState(listFood: foodmodel);
  }

}
