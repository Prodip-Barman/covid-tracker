import 'package:covid_tracker/pages/details_screen.dart';
import 'package:covid_tracker/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: TextFormField(
              controller: searchEditingController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServices.countriesListApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ));
                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]["country"];

                      if (searchEditingController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            image: snapshot.data![index]["countryInfo"]["flag"],
                                            name: snapshot.data![index]["country"],
                                            totalCases: snapshot.data![index]["cases"],
                                            totalDeaths: snapshot.data![index]["deaths"],
                                            totalRecovered: snapshot.data![index]["recovered"],
                                            active: snapshot.data![index]["active"],
                                            critical: snapshot.data![index]["critical"],
                                            todayRecovered: snapshot.data![index]["todayRecovered"],
                                            test:snapshot.data![index]["tests"])));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"]),
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (name.toLowerCase().contains(
                          searchEditingController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            image: snapshot.data![index]["countryInfo"]["flag"],
                                            name: snapshot.data![index]["country"],
                                            totalCases: snapshot.data![index]["cases"],
                                            totalDeaths: snapshot.data![index]["deaths"],
                                            totalRecovered: snapshot.data![index]["recovered"],
                                            active: snapshot.data![index]["active"],
                                            critical: snapshot.data![index]["critical"],
                                            todayRecovered: snapshot.data![index]["todayRecovered"],
                                            test:snapshot.data![index]["tests"])));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"]),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}