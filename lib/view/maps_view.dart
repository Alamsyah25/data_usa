import 'package:data_usa/utils/colors.dart';
import 'package:data_usa/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key, required this.state});
  final String state;
  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  Future<List<Location>> _getData() async {
    List<Location> locations = [];
    locations = await locationFromAddress("${widget.state}, $country");
    return locations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimary,
          title: Text(widget.state),
        ),
        body: FutureBuilder<List<Location>?>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return FlutterMap(
                options: MapOptions(
                  initialCenter:
                      LatLng(data?[0].latitude ?? 0, data?[0].longitude ?? 0),
                  initialZoom: 10,
                  cameraConstraint: CameraConstraint.contain(
                    bounds: LatLngBounds(
                      const LatLng(-90, -180),
                      const LatLng(90, 180),
                    ),
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: urlTemplate,
                    userAgentPackageName: packageName,
                  ),
                ],
              );
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
        ));
  }
}
