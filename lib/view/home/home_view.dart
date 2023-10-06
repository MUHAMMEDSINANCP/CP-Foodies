import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/color_extension.dart';
import 'package:food_delivery_app/common_widget/category_cell.dart';
import 'package:food_delivery_app/common_widget/most_popular_cell.dart';
import 'package:food_delivery_app/common_widget/round_textfield.dart';
import 'package:food_delivery_app/common_widget/view_all_title_row.dart';
import 'package:food_delivery_app/view/more/my_order_view.dart';

import '../../common_widget/popular_restaurant_row.dart';
import '../../common_widget/recent_item_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtSearch = TextEditingController();

  List catArr = [
    {"image": "assets/img/cat_offer.png", "name": "Offers"},
    {"image": "assets/img/cat_sri.png", "name": "Sri Lankan"},
    {"image": "assets/img/cat_3.png", "name": "Italian"},
    {"image": "assets/img/cat_4.png", "name": "Indian"},
  ];
  List popArr = [
    {
      "image": "assets/img/res_1.png",
      "name": "Oma's Restaurant",
      "rate": "4.9",
      "rating": "123",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/res_2.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "123",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/res_3.png",
      "name": "Lam Cafe",
      "rate": "4.9",
      "rating": "123",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];
  List mostPopArr = [
    {
      "image": "assets/img/m_res_1.png",
      "name": "Oma's Restaurant",
      "rate": "4.9",
      "rating": "123",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/m_res_2.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "123",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];
  List recentArr = [
    {
      "image": "assets/img/item_1.png",
      "name": "Raravis",
      "rate": "4.9",
      "rating": "123",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/item_2.png",
      "name": "Hot Bingy",
      "rate": "4.9",
      "rating": "123",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/item_3.png",
      "name": "Pizza Hut",
      "rate": "4.9",
      "rating": "123",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 64,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Good Morning Sinan!",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOrderView()));
                      },
                      icon: Image.asset(
                        "assets/img/shopping_cart.png",
                        height: 25,
                        width: 25,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivering to",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Current Location",
                          style: TextStyle(
                              color: TColor.secondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          "assets/img/dropdown.png",
                          height: 12,
                          width: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundTextField(
                  hintText: "Search Food",
                  controller: txtSearch,
                  left: Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Image.asset(
                      "assets/img/search.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    itemCount: catArr.length,
                    itemBuilder: (context, index) {
                      var cObj = catArr[index] as Map? ?? {};
                      return CategoryCell(
                        onTap: () {},
                        cObj: cObj,
                      );
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: 'Popular Restaurants',
                  onView: () {},
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: popArr.length,
                  itemBuilder: (context, index) {
                    var pObj = popArr[index] as Map? ?? {};
                    return PopularRestaurantRow(
                      onTap: () {},
                      pObj: pObj,
                    );
                  }),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ViewAllTitleRow(
                    title: 'Most Popular',
                    onView: () {},
                  )),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    itemCount: mostPopArr.length,
                    itemBuilder: (context, index) {
                      var mObj = mostPopArr[index] as Map? ?? {};
                      return MostPopularCell(
                        onTap: () {},
                        mObj: mObj,
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: 'Recent Items',
                  onView: () {},
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  itemCount: recentArr.length,
                  itemBuilder: (context, index) {
                    var rObj = recentArr[index] as Map? ?? {};
                    return RecentItemRow(
                      onTap: () {},
                      rObj: rObj,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
