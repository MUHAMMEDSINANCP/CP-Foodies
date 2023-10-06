import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/color_extension.dart';
import 'package:food_delivery_app/common_widget/round_icon_button.dart';
import 'package:food_delivery_app/common_widget/round_textfield.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({super.key});

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  TextEditingController txtCardNumber = TextEditingController();
  TextEditingController txtCardMonth = TextEditingController();
  TextEditingController txtCardYear = TextEditingController();
  TextEditingController txtCardCode = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  bool isAnyTime = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      width: media.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add Credit/Debit Card",
                style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: TColor.primaryText,
                  size: 25,
                ),
              ),
            ],
          ),
          Divider(
            color: TColor.secondaryText.withOpacity(0.4),
          ),
          const SizedBox(
            height: 15,
          ),
          RoundTextField(
            hintText: "Card Number",
            controller: txtCardNumber,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Expiry",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                child: RoundTextField(
                  hintText: "MM",
                  controller: txtCardMonth,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 100,
                child: RoundTextField(
                  hintText: "YYYY",
                  controller: txtCardYear,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          RoundTextField(
            hintText: "Card Security Code",
            controller: txtCardCode,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 15,
          ),
          RoundTextField(
            hintText: "First Name",
            controller: txtFirstName,
          ),
          const SizedBox(
            height: 15,
          ),
          RoundTextField(
            hintText: "Last Name",
            controller: txtLastName,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "You can remove this card at anytime",
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                      inactiveThumbColor: TColor.primary,
                      value: isAnyTime,
                      activeColor: TColor.primary,
                      inactiveTrackColor: TColor.textfield,
                      onChanged: (newVal) {
                        setState(() {
                          isAnyTime = newVal;
                        });
                      }),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          RoundIconButton(
            onPressed: () {},
            title: "Add Card",
            icon: "assets/img/add.png",
            color: TColor.primary,
            fontsize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
