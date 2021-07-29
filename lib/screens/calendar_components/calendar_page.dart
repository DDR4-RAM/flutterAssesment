import 'package:flutter/cupertino.dart';
import 'package:flutter_test_project/screens/calendar_components/calendar_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Map<String, dynamic>> allDates = [];
  List<Map<String, dynamic>> filteredDates = [];

  String filter = 'all';

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    List<Map<String, dynamic>> dayEvents = [];
    for (int i = 0; i < allDates.length; i++) {
      Map<String, dynamic> event = allDates[i];
      if (event['date'] == day) {
        dayEvents.add(event);
      }
    }
    return dayEvents;
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      getEventsByDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFf5f5f5),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 15,top: 30),
            child: Text(
              "Para agregar mantenga presionado un día y para filtrar presione el card o el dia deseado.",
              style: TextStyle(
                fontFamily: GoogleFonts.getFont('Lato').fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              if (isSameDay(_selectedDay, day)) {
                return true;
              }
              return false;
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            rangeSelectionMode: _rangeSelectionMode,
            onDisabledDayTapped: (DateTime selectedDay) {
              showDialogEventSelection(context, selectedDay);
            },
            onDayLongPressed: (DateTime selectedDay, DateTime focusedDay) {
              showDialogEventSelection(context, selectedDay);
            },
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        filter = 'holiday';
                        _focusedDay = DateTime.now();
                        _selectedDay = DateTime.now();
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                        ),
                        Text('Holiday')
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        filter = 'event';
                        _focusedDay = DateTime.now();
                        _selectedDay = DateTime.now();
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.yellow,
                        ),
                        Text('Event')
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        filter = 'test';
                        _focusedDay = DateTime.now();
                        _selectedDay = DateTime.now();
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                        ),
                        Text('Test')
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        filter = 'all';
                        _focusedDay = DateTime.now();
                        _selectedDay = DateTime.now();
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        Text('Clear')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: filter == 'all'
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: allDates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CalendarCard(
                        date: allDates[index]['date'],
                        type: allDates[index]['type'],
                        name: allDates[index]['name'],
                      );
                    },
                  )
                : filter == 'holiday'
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: allDates.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (allDates[index]['type'] == 'holiday') {
                            return CalendarCard(
                              date: allDates[index]['date'],
                              type: allDates[index]['type'],
                              name: allDates[index]['name'],
                            );
                          }
                          return Text(' ');
                        },
                      )
                    : filter == 'event'
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: allDates.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (allDates[index]['type'] == 'event') {
                                return CalendarCard(
                                  date: allDates[index]['date'],
                                  type: allDates[index]['type'],
                                  name: allDates[index]['name'],
                                );
                              }
                              return Text(' ');
                            },
                          )
                        : filter == 'test'
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: allDates.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (allDates[index]['type'] == 'test') {
                                    return CalendarCard(
                                      date: allDates[index]['date'],
                                      type: allDates[index]['type'],
                                      name: allDates[index]['name'],
                                    );
                                  }
                                  return Text(' ');
                                },
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredDates.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CalendarCard(
                                    date: filteredDates[index]['date'],
                                    type: filteredDates[index]['type'],
                                    name: filteredDates[index]['name'],
                                  );
                                },
                              ),
          ),
        ],
      ),
    );
  }

  getEventsByDay(DateTime day) {
    filteredDates.clear();
    List<Map<String, dynamic>> newDates = [];
    for (int i = 0; i < allDates.length; i++) {
      Map<String, dynamic> event = allDates[i];
      if (event['date'] == day) {
        newDates.add(event);
      }
    }
    setState(() {
      filteredDates = newDates;
      filter = ' ';
    });
  }

  showDialogEventSelection(BuildContext context, DateTime selectedDate) {
    String name = '';
    AlertDialog alert = AlertDialog(
      title: Column(
        children: [
          Text("Elige el tipo de evento: "),
          TextFormField(
            onChanged: (value) {
              name = value.trim();
            },
          ),
        ],
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                if (name.isEmpty || name == ' ') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Ponle un nombre al evento.'),
                  ));
                } else {
                  setState(() {
                    allDates.add({
                      'date': selectedDate,
                      'type': "holiday",
                      'name': name
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text("Holiday")),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                setState(() {
                  if (name.isEmpty || name == ' ') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Ponle un nombre al evento.'),
                    ));
                  } else {
                    allDates.add(
                        {'date': selectedDate, 'type': "event", 'name': name});
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text("Event")),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                setState(() {
                  if (name.isEmpty || name == ' ') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Ponle un nombre al evento.'),
                    ));
                  } else {
                    allDates.add(
                        {'date': selectedDate, 'type': "test", 'name': name});
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text("Test"))
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
