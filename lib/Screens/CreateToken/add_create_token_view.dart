import 'dart:convert';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';
import 'package:http/http.dart' as http;
import '../../Models/get_sub_plan_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';


class AddCreateTokenScreen extends StatefulWidget {
  AddCreateTokenScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCreateTokenScreen> createState() => _AddCreateTokenScreenState();
}

class _AddCreateTokenScreenState extends State<AddCreateTokenScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    getCat();
  }

  String? userId;

  getUserId() async {
    userId = await SharedPre.getStringValue('userId');
    setState(() {});
  }

  final nameController = TextEditingController();
  final timeController = TextEditingController();
   String? pId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    child: Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<SignUpCat>(
                            hint:  const Text('Select Category',
                              style: TextStyle(
                                  color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:12
                              ),),
                            value: animalCat,
                            isExpanded: true,
                            icon:  const Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.fntClr,size: 25,),
                            style:  const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),
                            underline: Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Container(

                                // height: 2,
                                color:  AppColors.whit,
                              ),
                            ),
                            onChanged: (SignUpCat? value) {
                              setState(() {
                                animalCat = value!;
                                catId =  animalCat?.id;
                              });
                            },
                            items: getCatModel?.data?.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Container(

                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 0),
                                            child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:AppColors.fntClr),),
                                          )),
                                    ),

                                  ],
                                ),
                              );
                            })
                                .toList(),
                          ),

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    padding: const EdgeInsets.all(5.0),
                    decoration: CustomBoxDecoration.myCustomDecoration(),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: "Name",
                          contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                          border: InputBorder.none
                      ),
                      style: const TextStyle(fontSize: 14),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Name cannot be empty";
                        } else if (val.length < 4) {
                          return "Please enter must 5 digit";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    padding: const EdgeInsets.all(5.0),
                    decoration: CustomBoxDecoration.myCustomDecoration(),
                    child: TextFormField(
                      controller: timeController,
                      decoration: const InputDecoration(
                          hintText: "Token Time ",
                          contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                          border: InputBorder.none
                      ),
                      style: const TextStyle(fontSize: 14),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Token cannot be empty";
                        } else if (val.length < 4) {
                          return "Please enter must 5 digit";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                   AppButton1(
                    title: "Create Token",
                    onTap: (){
                      createToken();
                    },
                  )
                ],
              ),
            )
        ));
  }
  String? catId;
  SignUpCat? animalCat;
  GetCatModel ? getCatModel;
  Future<void> getCat() async {
    var param = {
      'app_key': ""
    };
    apiBaseHelper.postAPICall(getCatAPI, param).then((getData) {
      String msg = getData['message'];
      getCatModel = GetCatModel.fromJson(getData);
       setState(() {
         Fluttertoast.showToast(msg: msg);
       });
    });
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
  
  
  
  
  
  createToken() async {
    var headers = {
      'Cookie': 'ci_session=a3f6c3c57d246096cf641e253ca83fd18f2258a9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/create_token'));
    request.fields.addAll({
      'user_id':userId.toString(),
      'category': catId.toString(),
      'time_per_client':timeController.text,
      'from_time': '10 am',
      'to_time': '01 pm',
      'user_name':nameController.text
    });
   print('_____request.fields_____${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult  = jsonDecode(result);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
