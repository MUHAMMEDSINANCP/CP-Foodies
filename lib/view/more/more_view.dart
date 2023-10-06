import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/more/about_us_view.dart';
import 'package:food_delivery_app/view/more/inbox_view.dart';
import 'package:food_delivery_app/view/more/my_order_view.dart';
import 'package:food_delivery_app/view/more/notification_view.dart';
import 'package:food_delivery_app/view/more/payment_details_view.dart';

import '../../common/color_extension.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  List moreArr = [
    {
      "index": "1",
      "name": "Payment Details",
      "image": "assets/img/more_payment.png",
      "base": 0,
    },
    {
      "index": "2",
      "name": "My Orders",
      "image": "assets/img/more_my_order.png",
      "base": 0,
    },
    {
      "index": "3",
      "name": "Notifications",
      "image": "assets/img/more_notification.png",
      "base": 11,
    },
    {
      "index": "4",
      "name": "Inbox",
      "image": "assets/img/more_inbox.png",
      "base": 4,
    },
    {
      "index": "5",
      "name": "About Us",
      "image": "assets/img/more_info.png",
      "base": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "More",
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
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: moreArr.length,
                itemBuilder: (context, index) {
                  var mObj = moreArr[index] as Map? ?? {};
                  var countBase = mObj["base"] as int? ?? 0;
                  return InkWell(
                    onTap: () {
                      switch (mObj["index"].toString()) {
                        case "1":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentDetailsView()),
                          );
                        case "2":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOrderView()),
                          );
                          break;
                        case "3":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsView(),
                            ),
                          );
                        case "4":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InboxView(),
                            ),
                          );
                        case "5":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutUsView(),
                            ),
                          );
                        default:
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: TColor.textfield,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: TColor.placeholder,
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    mObj["image"].toString(),
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    mObj["name"].toString(),
                                    style: TextStyle(
                                      color: TColor.primaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                if (countBase > 0)
                                  Container(
                                    height: 22,
                                    width: 22,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.5),
                                      color: Colors.red,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      countBase.toString(),
                                      style: TextStyle(
                                        color: TColor.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: TColor.textfield,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset(
                              "assets/img/btn_next.png",
                              width: 12,
                              height: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
