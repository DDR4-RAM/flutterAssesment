import 'dart:convert';

import 'package:flutter_test_project/services/pokemon/pokemon_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;

class PokemonBottomSheet extends StatefulWidget {
  final String name;
  final String url;

  PokemonBottomSheet({Key key, this.name, this.url});

  @override
  _PokemonBottomSheetState createState() => _PokemonBottomSheetState();
}

class _PokemonBottomSheetState extends State<PokemonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder<http.Response>(
      future: PokemonServices.getData(widget.url),
      builder: (context, data) {
        if (data.hasData) {
          Map<String, dynamic> pokemonData = jsonDecode(data.data.body);
          List<dynamic> types = pokemonData['types'];
          String type = types[0]['type']['name'];
          List<dynamic> stats = pokemonData['stats'];
          print(stats);
          int hp = stats[0]['base_stat'];
          int attack = stats[1]['base_stat'];
          int defense = stats[2]['base_stat'];
          int specialAttack = stats[3]['base_stat'];
          int specialDefense = stats[4]['base_stat'];
          int speed = stats[5]['base_stat'];
          return BottomSheet(
              backgroundColor: PokemonServices.getColorType(type),
              elevation: 10,
              onClosing: () {},
              builder: (context) {
                return Container(
                  height: screenSize.height,
                  width: screenSize.width / 2,
                  margin: EdgeInsets.all(15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 25),
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.name[0].toUpperCase() +
                                            widget.name.substring(1),
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.getFont('Lato')
                                                  .fontFamily,
                                          color: PokemonServices.getColorType(
                                              type),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 50,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 40),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            PokemonServices.getIconType(type),
                                            color: PokemonServices.getColorType(
                                                type),
                                          ),
                                          Text(
                                            type,
                                            style: TextStyle(
                                              fontFamily:
                                                  GoogleFonts.getFont('Lato')
                                                      .fontFamily,
                                              color: Color(0xFFBFBFBF),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                FittedBox(
                                  child: Image.network(
                                    pokemonData['sprites']['other']
                                        ['official-artwork']['front_default'],
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Height",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.getFont('Lato').fontFamily,
                                    color: PokemonServices.getColorType(type),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.getFont('Lato').fontFamily,
                                    color: PokemonServices.getColorType(type),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Base Experience",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.getFont('Lato').fontFamily,
                                    color: PokemonServices.getColorType(type),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Abilities",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.getFont('Lato').fontFamily,
                                    color: PokemonServices.getColorType(type),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  pokemonData["height"].toString() + " inch",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.getFont('Lato').fontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  pokemonData["weight"].toString() + " lbs",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.getFont('Lato').fontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  pokemonData["base_experience"].toString() +
                                      " points",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.getFont('Lato').fontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  pokemonData["abilities"][0]['ability']['name']
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.getFont('Lato').fontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "HP",
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    LinearPercentIndicator(
                                      width: 200.0,
                                      animation: true,
                                      animationDuration: 750,
                                      lineHeight: 20.0,
                                      percent: hp >= 100 ? hp / 1000 : hp / 100,
                                      center: Text((hp).toString() + " points"),
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor:
                                          PokemonServices.getColorType(type),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Attack",
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    LinearPercentIndicator(
                                      width: 200.0,
                                      animation: true,
                                      animationDuration: 750,
                                      lineHeight: 20.0,
                                      percent: attack >= 100
                                          ? attack / 1000
                                          : attack / 100,
                                      center:
                                          Text((attack).toString() + " points"),
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor:
                                          PokemonServices.getColorType(type),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Defense",
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    LinearPercentIndicator(
                                      width: 200.0,
                                      animation: true,
                                      animationDuration: 750,
                                      lineHeight: 20.0,
                                      percent: defense >= 100
                                          ? defense / 1000
                                          : defense / 100,
                                      center: Text(
                                          (defense).toString() + " points"),
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor:
                                          PokemonServices.getColorType(type),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Special Attack",
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    LinearPercentIndicator(
                                      width: 200.0,
                                      animation: true,
                                      animationDuration: 750,
                                      lineHeight: 20.0,
                                      percent: specialAttack >= 100
                                          ? specialAttack / 1000
                                          : specialAttack / 100,
                                      center: Text((specialAttack).toString() +
                                          " points"),
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor:
                                          PokemonServices.getColorType(type),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Special Defense",
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    LinearPercentIndicator(
                                      width: 200.0,
                                      animation: true,
                                      animationDuration: 750,
                                      lineHeight: 20.0,
                                      percent: specialDefense >= 100
                                          ? specialDefense / 1000
                                          : specialDefense / 100,
                                      center: Text((specialDefense).toString() +
                                          " points"),
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor:
                                          PokemonServices.getColorType(type),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Speed",
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.getFont('Lato')
                                            .fontFamily,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    LinearPercentIndicator(
                                      width: 200.0,
                                      animation: true,
                                      animationDuration: 750,
                                      lineHeight: 20.0,
                                      percent: speed >= 100
                                          ? speed / 1000
                                          : speed / 100,
                                      center:
                                          Text((speed).toString() + " points"),
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor:
                                          PokemonServices.getColorType(type),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        } else {
          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            padding: EdgeInsets.all(10),
            height: (3 / 4) * screenSize.height,
            width: screenSize.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              "Cargando...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: GoogleFonts.getFont('Lato').fontFamily,
                color: Color(0xFFBFBFBF),
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          );
        }
      },
    );
  }
}
