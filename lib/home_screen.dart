import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_dashboard/model/order.dart';
import 'package:food_dashboard/order_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Order>> futureOrders;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // futureOrders = fetchOrders(http.Client());
    // MOCKING DATA STARTS
    String jsonString = '[{ "total": "26.40","order_date": "12 jan 2021, 08:28pm",'
        '"order_no": "#6758",'
        '"ordered_by": "https://rosius.s3.us-east-2.amazonaws.com/cropped_rosius.png",'
        '"items": ['
        '{ "name": "Vegetable Mixups","pic": "https://rosius.s3.us-east-2.amazonaws.com/meal1+(1).jpg","price": "\$10.20","desc": "Vegetable Fritters with Egg","qty": 5},'
        '{'
        ' "name": "Chicken Mixed Salad","pic": "https://rosius.s3.us-east-2.amazonaws.com/meal4+(1).jpeg","price": "\$16.20","desc": "Roasted Chicken, mixed with salad","qty": 2}'
        ']'
        '}]';
    // # Parse the JSON data
    List<Order> orders = (jsonDecode(jsonString) as List)
        .map((data) => Order.fromJson(data))
        .toList();
    // Create a new Future that completes with the value of the orders list
    futureOrders = Future.value(orders);
    // MOCKING DATA ENDS
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Food Dashboard"), centerTitle: true,),
        body: Row(

          children: [
            NavigationRail(
              // minWidth: 40.0,
              // groupAlignment: 0.5,
              groupAlignment: 1,


              trailing: IconButton(
                icon: Icon(Icons.logout),
              ),


              selectedIndex: _selectedIndex,

              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              selectedLabelTextStyle: TextStyle(color: Theme
                  .of(context)
                  .primaryColor, fontWeight: FontWeight.bold),
              destinations: [
                NavigationRailDestination(

                    label: Text(""),
                    icon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/dashboard.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        // color: color,

                      ),
                    ),
                    selectedIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/dashboard.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        color: Theme
                            .of(context)
                            .primaryColor,

                      ),
                    )),
                NavigationRailDestination(
                    label: Text(""),

                    icon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/orders.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        // color: color,

                      ),
                    ),
                    selectedIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/orders.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        color: Theme
                            .of(context)
                            .primaryColor,

                      ),
                    )),
                NavigationRailDestination(
                    label: Text(""),

                    icon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/home.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        // color: color,

                      ),
                    ),
                    selectedIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/home.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        color: Theme
                            .of(context)
                            .primaryColor,

                      ),
                    )),

                NavigationRailDestination(

                    label: Text(""),
                    icon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/messages.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        color: Colors.black,

                      ),
                    ),
                    selectedIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/messages.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        color: Theme
                            .of(context)
                            .primaryColor,

                      ),
                    )),
                NavigationRailDestination(

                    label: Text(""),
                    icon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/settings.svg",

                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                        color: Colors.black,

                      ),
                    ),
                    selectedIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/settings.svg",

                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        color: Theme
                            .of(context)
                            .primaryColor,

                      ),
                    )),


              ],
            ),
            VerticalDivider(thickness: 1, width: 1),
            Expanded(child: FutureBuilder<List<Order>>(
              future: futureOrders,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Order> orderLists = snapshot.data;
                  return ListView.builder(itemBuilder: (context, index) {
                    return OrderItem(orderLists[index]);
                  }, itemCount: snapshot.data.length,);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Container(
                    height: 40,
                    width: 40,

                    child: Center(child: CircularProgressIndicator()));
              },
            ))
          ],
        )
    );
  }
}
