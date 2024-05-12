import 'package:data_usa/model/state_response.dart';
import 'package:data_usa/services/dio_services.dart';
import 'package:data_usa/utils/colors.dart';
import 'package:data_usa/utils/strings.dart';
import 'package:data_usa/view/maps_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text(title),
      ),
      body: FutureBuilder<StateResponse?>(
        future: _client.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            StateResponse? response = snapshot.data;
            if (response != null) {
              List<Data> data = response.data ?? [];

              return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  itemBuilder: (context, index) {
                    var item = data[index];

                    return Material(
                      color: kTransparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MapsView(state: item.state ?? ''),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrestigeBlue.withOpacity(0.5),
                              width: 1.3,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                width: 100.0,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        thumbnail,
                                      )),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  color: kTransparent,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("State : ${item.state}",
                                      style: const TextStyle(
                                        color: kPrestigeBlue,
                                        leadingDistribution:
                                            TextLeadingDistribution.even,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        height: 1.57,
                                      )),
                                  Text("Population : ${item.population}",
                                      style: const TextStyle(
                                        color: kGrisaille,
                                        leadingDistribution:
                                            TextLeadingDistribution.even,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        height: 1.57,
                                      )),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.chevron_right,
                                color: kPrestigeBlue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: data.length);
            }
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}",
                  style: const TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    height: 1.57,
                  )),
            );
          }
          return const Center(
              child: CircularProgressIndicator(
            color: kPrimary,
          ));
        },
      ),
    );
  }
}
