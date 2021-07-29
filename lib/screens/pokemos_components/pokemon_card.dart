import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/services/pokemon/pokemon_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PokemonCard extends StatefulWidget {
  final String name;
  final String url;

  PokemonCard({Key key, this.name, this.url});

  @override
  _PokemonCardState createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
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
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            elevation: 7.5,
            child: Container(
              height: 125,
              padding: EdgeInsets.all(10),
              width: screenSize.width,
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
                            fontFamily: GoogleFonts.getFont('Lato').fontFamily,
                            color: PokemonServices.getColorType(type),
                            fontWeight: FontWeight.w900,
                            fontSize: 50,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                            PokemonServices.getIconType(type),
                              color: PokemonServices.getColorType(type),
                            ),
                            Text(
                              type,
                              style: TextStyle(
                                fontFamily:
                                    GoogleFonts.getFont('Lato').fontFamily,
                                color: Color(0xFFBFBFBF),
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FittedBox(
                    child: Image.network(
                      pokemonData['sprites']['other']['official-artwork']
                          ['front_default'],
                      height: 120,
                      width: 120,
                    ),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            padding: EdgeInsets.all(10),
            width: screenSize.width,
            height: 125,
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
