import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../app_colors.dart';
import 'user.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
      icon: Icon(Icons.arrow_back, color: AppColors.black),
      onPressed: () => Navigator.of(context).pop(),
    ), 
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text('유저', 
      style: TextStyle(
        color: AppColors.black,
        fontFamily: 'Noto_Serif_KR',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0.0,
    ),
    extendBodyBehindAppBar: true,
    body: StreamBuilder<List<User>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          //Firebase에서 데이터를 로드할 때 잘못되는 경우 에러 표시
          return Text('Something went worng! ${snapshot.error}');
        } else if (snapshot.hasData){
          final users = snapshot.data!;
          return ListView(
            children: users.map(buildUser).toList()
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    ),
   );
   
  Widget buildUser(User user) => Container(
    margin: const EdgeInsets.all(2),
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(0xffb3b9ed),
        width: 2,
        ),
      borderRadius: BorderRadius.circular(7),
      
    ),
    child: Column(
      children: [
      Text("일정 제목 : ${user.title}",
      style: TextStyle(
        fontFamily: 'Noto_Serif_KR',
        color: AppColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      ),
      Text("시작 날짜 : ${user.startDate.toIso8601String()}",
      style: TextStyle(
        fontFamily: 'Noto_Serif_KR',
        color: AppColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      ),
      Text("종료 날짜 ${user.endDate.toIso8601String()}",
      style: TextStyle(
        fontFamily: 'Noto_Serif_KR',
        color: AppColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      ),
      Text("시작 시간 : ${user.startTime.toIso8601String()}",
      style: TextStyle(
        fontFamily: 'Noto_Serif_KR',
        color: AppColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      ),
      Text("종료 시간 : ${user.endTime.toIso8601String()}",
      style: TextStyle(
        fontFamily: 'Noto_Serif_KR',
        color: AppColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      ),
      Text("세부사항 : ${user.description}",
      style: TextStyle(
        fontFamily: 'Noto_Serif_KR',
        color: AppColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      ),
      SizedBox(height: 10,)
      ],
    ),
  );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
     .collection('${fauth.FirebaseAuth.instance.currentUser?.uid}')
     .snapshots()
     .map((snapshot) => 
         snapshot.docs.map((doc) => User.fromJson(doc.data())).toList()); 
}