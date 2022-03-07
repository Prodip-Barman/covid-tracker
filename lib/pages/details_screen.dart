import 'package:covid_tracker/pages/world_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String image, name;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;


  DetailScreen({Key? key,
      required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ReUseAbleRow(title: "Cases", value: widget.totalCases.toString()),
                        ReUseAbleRow(title: "Deaths", value: widget.totalDeaths.toString()),
                        ReUseAbleRow(title: "Recovered", value: widget.totalRecovered.toString()),
                        ReUseAbleRow(title: "Active", value: widget.active.toString()),
                        ReUseAbleRow(title: "Critical", value: widget.critical.toString()),
                        ReUseAbleRow(title: "Today's Recovered", value: widget.todayRecovered.toString()),
                        ReUseAbleRow(title: "Test", value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
