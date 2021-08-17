import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodlistdicoding/bloc/list_food_bloc.dart';
import 'package:foodlistdicoding/event/food_list_event.dart';
import 'package:foodlistdicoding/widget/search_widget.dart';
import '../state/food_list_state.dart';
import 'detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ListFoodBloc foodBloc;
  List<dynamic> data;
  // bool isLoading = false;
  String query = '';
  String hintText = 'Search...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Discover',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 40)),
                      Text('Restaurant List',
                          style: TextStyle(color: Colors.grey, fontSize: 18)),
                      buildSearch(),
                      SizedBox(height: 20),
                      // buildList(list)
                      BlocProvider(
                          create: (context) => ListFoodBloc()..add(GetListFood()),
                          child: BlocBuilder<ListFoodBloc, ListFoodState>(
                              builder: (context, state) {
                                foodBloc = BlocProvider.of<ListFoodBloc>(context);
                                if (state is OnListFoodState) {
                                  if (state.listFood.restaurants.length > 0) {
                                    return Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: state.listFood.restaurants.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                    return DetailScreen(state.listFood.restaurants[index].id);
                                                  }));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                                  child: Container(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 1,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(5),
                                                            child: CachedNetworkImage(
                                                              height: 100,
                                                              imageUrl: "https://restaurant-api.dicoding.dev/images/small/"+state.listFood.restaurants[index].pictureId,
                                                              placeholder: (context, url) => Image.asset(
                                                                'images/food.png',
                                                                height: 200,
                                                              ),
                                                              errorWidget: (context, url, error) => Image.asset(
                                                                'images/food.png',
                                                                height: 200,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Text(state.listFood.restaurants[index].name,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black,
                                                                      fontSize: 16)),
                                                              SizedBox(height: 3),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Icon(Icons.pin_drop),
                                                                  Text(
                                                                    '${state.listFood.restaurants[index].city}',
                                                                    style: TextStyle(fontSize: 14),
                                                                    maxLines: 3,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 15),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Icon(Icons.star,color: Colors.yellow,),
                                                                  Text(
                                                                    '${state.listFood.restaurants[index].rating.toString()}',
                                                                    style: TextStyle(fontSize: 14),
                                                                    maxLines: 3,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }else{
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset('images/loop.png'),
                                            width: 100,
                                            height: 100,
                                          ),
                                          Text("no data",style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: Container(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              }))
                    ],
                  )),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }


  void searchData(String query) {
    foodBloc..add(GetListFoodSearch(query: query));
  }

  Widget buildSearch() =>
      SearchWidget(text: query, onChanged: searchData, hintText: hintText);

}
