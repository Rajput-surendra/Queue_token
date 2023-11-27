import 'dart:convert';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';

import 'package:http/http.dart' as http;

import '../../Models/get_counter_model.dart';
import '../../Models/get_sub_plan_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';
import 'add_create_token_view.dart';

class CreateTokenScreen extends StatefulWidget {
  CreateTokenScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateTokenScreen> createState() => _CreateTokenScreenState();
}

class _CreateTokenScreenState extends State<CreateTokenScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  String? userId;

  getUserId() async {
    userId = await SharedPre.getStringValue('userId');

    setState(() {});
  }

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
   String? pId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:  FloatingActionButton(
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCreateTokenScreen()));
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50),
            ),
          ),
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text(
            "Create Token",
            style: TextStyle(fontSize: 17),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10),
              ),
              gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: <Color>[AppColors.primary, AppColors.secondary]),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child:Column(
              children: [
                Text("data")
              ],
            )
        ));
  }

  GetSubscriptionModel? getSubscriptionModel;
  addSubPlan(String pId) async {
    var headers = {
      'Cookie': 'ci_session=3c92729c33e9e6a6b76655065e1d039d1143a7a9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/add_subscription'));

    request.fields.addAll({
      'user_id': userId.toString(),
      'plan_id':pId,
    });
    print('_____request.fields_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      Navigator.pop(context);
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
