import 'dart:convert';

import 'package:flutter_test_project/models/pokemon.dart';
import 'package:flutter_test_project/screens/pokemos_components/pokemon_bottom_sheet.dart';
import 'package:flutter_test_project/screens/pokemos_components/pokemon_card.dart';
import 'package:flutter_test_project/services/pokemon/pokemon_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFFf5f5f5),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 50),
            child: Text(
              "CHOOSE YOUR POKEMON",
              style: TextStyle(
                fontFamily: GoogleFonts.getFont('Lato').fontFamily,
                color: Color(0xFFBFBFBF),
                fontWeight: FontWeight.w400,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder<http.Response>(
              future:
                  PokemonServices.getData('https://pokeapi.co/api/v2/pokemon'),
              builder: (context, data) {
                if (data.hasData) {
                  Map<String, dynamic> pokemonData = jsonDecode(data.data.body);
                  List<dynamic> pokemonList = (pokemonData['results'] as List);
                  return Container(
                    width: screenSize.width,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pokemonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Pokemon pokemon = Pokemon.fromJson(pokemonList[index]);
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return PokemonBottomSheet(
                                    name: pokemon.name,
                                    url: pokemon.url,
                                  );
                                });
                          },
                          child: PokemonCard(
                            name: pokemon.name,
                            url: pokemon.url,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    width: screenSize.width,
                    child: Text(
                      "Recuperando Informacion",
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
            ),
          ),
        ],
      ),
    );
  }
}
