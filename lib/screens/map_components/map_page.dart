import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Cabecera'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: FlutterMap(
              nonRotatedChildren: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        AppBar(
                          actions: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 30, right: 30),
                              elevation: 7.5,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.arrow_circle_up_rounded,
                                  color: Colors.green,
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 30, right: 30),
                          elevation: 7.5,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
                            width: double.infinity,
                            child: ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Color(0xFFBFBFBF),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: "Calle 8 de julio",
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(right: 5, left: 20),
                                        child: Icon(
                                          Icons.cancel,
                                          color: Color(0xFFBFBFBF),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Icon(
                                          Icons.settings,
                                          color: Color(0xFFBFBFBF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 30, right: 30),
                          elevation: 7.5,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
                            width: double.infinity,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    margin: EdgeInsets.only(top: 20, left: 15),
                                    width: 100,
                                    height: 100,
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "\$5",
                                            style: TextStyle(
                                              fontFamily:
                                                  GoogleFonts.getFont('Lato')
                                                      .fontFamily,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "/Hrs",
                                            style: TextStyle(
                                              color: Color(0xFFBFBFBF),
                                              fontFamily:
                                                  GoogleFonts.getFont('Lato')
                                                      .fontFamily,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 175,
                                    child: ListTile(
                                      leading: Icon(Icons.star),
                                      subtitle: Text(
                                        "San Jose",
                                        style: TextStyle(
                                          color: Color(0xFFBFBFBF),
                                          fontFamily:
                                              GoogleFonts.getFont('Lato')
                                                  .fontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      title: Text(
                                        "120 FordhamRd",
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.getFont('Lato')
                                                  .fontFamily,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  color: Color(0xFFBFBFBF),
                                  height: 2,
                                  width: double.infinity,
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Available Spaces",
                                      style: TextStyle(
                                        color: Color(0xFFBFBFBF),
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                LinearPercentIndicator(
                                  width: 200.0,
                                  animation: true,
                                  animationDuration: 750,
                                  lineHeight: 20.0,
                                  percent: 0.4,
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: Colors.green,
                                  trailing: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "4",
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.directions_walk),
                                  title: Text(
                                    "123 meters walk",
                                    style: TextStyle(
                                      color: Color(0xFFBFBFBF),
                                      fontFamily: GoogleFonts.getFont('Lato')
                                          .fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 30, right: 30),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.green),
                              elevation: MaterialStateProperty.all(0),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(14)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text("Go!"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              options: MapOptions(
                center: LatLng(56.704173, 11.543808),
                minZoom: 12.0,
                maxZoom: 14.0,
                zoom: 13.0,
                swPanBoundary: LatLng(56.6877, 11.5089),
                nePanBoundary: LatLng(56.7378, 11.6644),
              ),
              layers: [
                TileLayerOptions(
                    maxZoom: 14.0,
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
