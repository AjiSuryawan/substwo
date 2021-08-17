import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodlistdicoding/bloc/detail_food_bloc.dart';
import 'package:foodlistdicoding/event/food_list_event.dart';
import 'package:foodlistdicoding/state/food_detail_state.dart';

class DetailScreen extends StatelessWidget {
  final String idrestaurant;

  DetailScreen(this.idrestaurant);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: SingleChildScrollView(
            child:
            BlocProvider(
                create: (context) => FoodDetailBloc()..add(GetFoodDetail(idrestorant: idrestaurant)),
                child: BlocBuilder<FoodDetailBloc, DetailFoodState>(
                    builder: (context, state) {
                      // foodBloc = BlocProvider.of<ListFoodBloc>(context);
                      if (state is OnDetailFoodState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child:

                                  Container(
                                    child: CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      imageUrl: "https://restaurant-api.dicoding.dev/images/medium/"+state.FoodDetail.restaurant.pictureId,
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
                                SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.black,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        FavoriteButton(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Center(
                                      child: Text(
                                        state.FoodDetail.restaurant.name,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Location: ${state.FoodDetail.restaurant.city}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          SizedBox(height: 15),
                                          Text(
                                            state.FoodDetail.restaurant.description,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10,top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Restaurant Menus',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900, fontSize: 30)),
                                  Text('Food',
                                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                // physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Card(
                                          child: Container(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.asset('images/food.png'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 10),
                                                  child: Text(state.FoodDetail.restaurant.menus.foods[index].name,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 16)),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  );
                                },
                                itemCount: state.FoodDetail.restaurant.menus.foods.length,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10,top: 20),
                              child: Text('Drinks',
                                  style: TextStyle(color: Colors.grey, fontSize: 18)),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                // physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Card(
                                          child: Container(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.asset('images/drinkicon.png'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 10),
                                                  child: Text(state.FoodDetail.restaurant.menus.drinks[index].name,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 16)),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  );
                                },
                                itemCount: state.FoodDetail.restaurant.menus.drinks.length,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10,top: 20),
                              child: Text('Reviews '+state.FoodDetail.restaurant.customerReviews.length.toString()+" comments",
                                  style: TextStyle(color: Colors.grey, fontSize: 18)),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 50),
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                // physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Card(
                                          child: Container(
                                            width: 250,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(bottom: 10),
                                                      width: 10,
                                                      height: 10,
                                                      child: Icon(Icons.person_outline_outlined,color: Colors.blue,),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 20,top: 5),
                                                      child: Text(state.FoodDetail.restaurant.customerReviews[index].name,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                              fontSize: 15)),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 10),
                                                  child: Text(state.FoodDetail.restaurant.customerReviews[index].date),
                                                ),

                                            Expanded(child: Container(
                                              margin: EdgeInsets.only(left: 10 , top: 10),
                                              child: Text("'"+state.FoodDetail.restaurant.customerReviews[index].review+"'"),),
                                            )
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  );
                                },
                                itemCount: state.FoodDetail.restaurant.customerReviews.length,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Scaffold(
                          body: Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                    }))

          )),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
