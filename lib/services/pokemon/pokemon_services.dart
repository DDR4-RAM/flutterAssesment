
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PokemonServices {

  static Future<Response> getData(String url) {
    return http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
  }

  static Color getColorType(String type) {
    switch (type) {
      case 'grass':
        return Colors.green;
        break;
      case 'fire':
        return Colors.red;
        break;
      case 'water':
        return Colors.blue;
        break;
      case 'bug':
        return Colors.lightGreenAccent;
        break;
      case 'normal':
        return Colors.grey;
        break;
      case 'electric':
        return Colors.yellow;
        break;
      default:
        return Colors.black;
        break;
    }
  }

  static IconData getIconType(String type) {
    switch (type) {
      case 'grass':
        return Icons.grass;
        break;
      case 'fire':
        return Icons.local_fire_department;
        break;
      case 'water':
        return Icons.fireplace;
        break;
      case 'bug':
        return Icons.bug_report;
        break;
      case 'normal':
        return Icons.accessibility;
        break;
      case 'electric':
        return Icons.electrical_services;
        break;
      default:
        return Icons.error;
        break;
    }
  }

}