import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/info_item.dart';
import '../widgets/app_drawer.dart';
import '../providers/info.dart' show Info;
import 'add_new_item_screen.dart';
import '../providers/change_day.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _initValue = true;
  List<String> weekDays = [
    '',
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_initValue) Provider.of<Info>(context).fetchAndSetTimeTable();
    _initValue = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedDay = Provider.of<ChangeDay>(context);
    final _information = Provider.of<Info>(context).getInfo(_selectedDay.day);
    return Scaffold(
      appBar: AppBar(
        title: Text(weekDays[_selectedDay.day]),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddNewItem.routeName,
                arguments: _selectedDay.day,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _information == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _information.length == null ? 0 : _information.length,
              itemBuilder: (_, i) => InfoItem(
                day: _selectedDay.day,
                id: _information[i].id,
                title: _information[i].title,
                info: _information[i].description,
                startTime: _information[i].startTime,
                endTime: _information[i].endTime,
              ),
            ),
    );
  }
}
