import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarCard extends StatefulWidget {
  final DateTime date;
  final String type;
  final String name;

  CalendarCard({Key key, this.date, this.type, this.name});

  @override
  _CalendarCardState createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      elevation: 7.5,
      child: Container(
        height: 100,
        padding: EdgeInsets.all(10),
        width: screenSize.width,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.type[0].toUpperCase()+widget.type.substring(1),
                style: TextStyle(
                  fontFamily: GoogleFonts.getFont('Lato').fontFamily,
                  color: getColorDate(widget.type),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                widget.date.toString(),
                style: TextStyle(
                  fontFamily: GoogleFonts.getFont('Lato').fontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          subtitle: Text(
            widget.name,
            style: TextStyle(
              fontFamily: GoogleFonts.getFont('Lato').fontFamily,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  Color getColorDate(String type){
    if (type == 'holiday') {
      return Colors.red;
    } else if (type == 'event') {
      return Colors.yellow;
    } else if (type == 'test') {
      return Colors.green;
    }else{
      return Colors.black;
    }
  }
}
