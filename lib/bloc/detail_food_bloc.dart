import 'dart:async';
import 'dart:convert';
import 'package:foodlistdicoding/model/detail_resto_model.dart';
import 'package:foodlistdicoding/state/food_detail_state.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:foodlistdicoding/event/food_list_event.dart';
import 'package:foodlistdicoding/model/restaurant_model.dart';

import '../state/food_list_state.dart';


class FoodDetailBloc extends Bloc<ListFoodEvent, DetailFoodState> {
  static String baseUrlRedesain = "https://restaurant-api.dicoding.dev/";
  FoodDetailBloc() : super(DetailFoodInitial());

  @override
  Stream<DetailFoodState> mapEventToState(
      ListFoodEvent event,
      ) async* {
    if (event is GetFoodDetail) {
      yield* mapEventToGetFoodDetail(event.idrestorant);
    }
  }


  Stream<DetailFoodState> mapEventToGetFoodDetail(String idrestorant) async* {
    yield DetailFoodInitial();


    final res = await http.get(Uri.parse(baseUrlRedesain+"detail/"+idrestorant));
    DetailRestaurantModel foodmodel = DetailRestaurantModel.fromJson(json.decode(res.body.toString()));

    yield OnDetailFoodState(FoodDetail : foodmodel);
  }

}
