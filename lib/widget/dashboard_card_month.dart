import 'dart:developer';

import 'package:bulananku/models/this_month.dart';
import 'package:bulananku/services/get_data_this_month.dart';
import 'package:bulananku/styles/color_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class CardMonth extends StatefulWidget {
  const CardMonth({Key? key}) : super(key: key);

  @override
  _CardMonthState createState() => _CardMonthState();
}

class _CardMonthState extends State<CardMonth> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            alignment: Alignment.centerLeft,
            child: Text("This Month's Summary",
                style: TextStyle(
                    color: ColorStyle.cText,
                    fontFamily: "Bahnschrift",
                    fontWeight: FontWeight.bold,
                    fontSize: 14))),
        Container(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: GetThisMonth.getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print(snapshot.data.size);
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 16 / 9,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    // crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // return Container(
                    //   child: Text("asaaa"),
                    // );
                    // return Text(
                    //   "${snapshot.data[index].nominal}",
                    //   style: TextStyle(fontSize: 12, color: Colors.red),
                    // );

                    return boxSummary(
                        ColorStyle.cBlue,
                        FontAwesomeIcons.ubuntu,
                        snapshot.data[index].category.toString(),
                        snapshot.data[index].nominal.toString());
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
                // return Text("eror");
              }
            },
          ),
        ),
      ],
    );
  }
}

class boxSummary extends StatelessWidget {
  final Color iconColor;
  final IconData iconData;
  final String boxName;
  final String boxTotal;

  const boxSummary(this.iconColor, this.iconData, this.boxName, this.boxTotal);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorStyle.cCardColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xffD8E5FF),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: iconColor, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              iconData,
              color: ColorStyle.cCardColor,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              boxName,
              style: TextStyle(
                  color: ColorStyle.cText,
                  fontFamily: "Bahnschrift",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.centerRight,
            child: Text(
              boxTotal,
              style: TextStyle(
                  color: ColorStyle.cText,
                  fontFamily: "Bahnschrift",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
