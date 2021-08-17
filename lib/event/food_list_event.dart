import 'package:equatable/equatable.dart';

abstract class ListFoodEvent extends Equatable {
  const ListFoodEvent();

  @override
  List<Object> get props => [];
}

class GetListFood extends ListFoodEvent {}

class GetListFoodSearch extends ListFoodEvent {
  final String query;

  GetListFoodSearch({this.query});
}
class GetFoodDetail extends ListFoodEvent {
  final String idrestorant;

  GetFoodDetail({this.idrestorant});
}