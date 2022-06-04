import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../extension.dart';
import '../scroll.dart';
import '../widgets/add_event_widget.dart';


class CreateEventPage extends StatefulWidget {
  final bool withDuration;
  final PushingData? pushingData;

  const CreateEventPage({Key? key, this.withDuration = false, this.pushingData})
      : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
        title: Text(
          '경기일정',
          style: TextStyle(
            fontFamily: 'Noto_Serif_KR',
            color: AppColors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: AddEventWidget(
          onEventAdd: context.pop,
          pushingData: widget.pushingData,
        ),
      ),
    );
  }
}
