import 'package:covid_tracker/models/world_states_model.dart';
import 'package:covid_tracker/pages/countries_list_screen.dart';
import 'package:covid_tracker/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  _WorldStateScreenState createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              FutureBuilder(
                  future: stateServices.fetchWorldStatesRecord(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Death": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReUseAbleRow(
                                      title: "Total",
                                      value: snapshot.data!.cases.toString()),
                                  ReUseAbleRow(
                                      title: "Recovered",
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReUseAbleRow(
                                      title: "Deaths",
                                      value: snapshot.data!.deaths.toString()),
                                  ReUseAbleRow(
                                      title: "Active",
                                      value: snapshot.data!.active.toString()),
                                  ReUseAbleRow(
                                      title: "Critical",
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReUseAbleRow(
                                      title: "Today's Recovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                  ReUseAbleRow(
                                      title: "Today's Death",
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0,),
                            child: Container(
                              height: 50,
                              width: 400,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>CountriesListScreen()));
                                },
                                child: const Text("Track Countries"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff1aa260)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUseAbleRow extends StatelessWidget {
  String title, value;

  ReUseAbleRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
