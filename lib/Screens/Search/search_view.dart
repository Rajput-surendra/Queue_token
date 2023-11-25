import 'dart:convert';

import 'package:booknplay/Constants.dart';
import 'package:booknplay/Screens/Profile/profile_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/custom_clip_path.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Models/HomeModel/signUp_cat_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';
import '../Counter/counter_view.dart';
import '../Dashboard/dashboard_view.dart';
import 'package:http/http.dart'as http;
String? catNewId,userName,cityName,cId;
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.isFrom}) : super(key: key);
  final bool? isFrom;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? catId;
  SignUpCat? animalCat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCateApi();
  }

  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final counterIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          automaticallyImplyLeading: false,

          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
            ),),
          toolbarHeight: 60,
          centerTitle: true,
          title: Text("Search Token",style: TextStyle(fontSize: 17),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius:   BorderRadius.only(
                bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
              gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: <Color>[AppColors.primary, AppColors.secondary]),
            ),
          ),
        ),
        body:  SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Container(
                  width: double.maxFinite,
                  height: 50,
                  padding: const EdgeInsets.all(5.0),
                  decoration: CustomBoxDecoration.myCustomDecoration(),
                  child: TextFormField(
                    controller:cityController,
                    decoration: const InputDecoration(
                        hintText: "City Name",
                        contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                        border: InputBorder.none
                    ),
                    style: const TextStyle(fontSize: 14),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "City cannot be empty";
                      } else if (val.length < 5) {
                        return "Please enter must 5 digit";
                      }
                    },
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  width: double.maxFinite,
                  height: 50,
                  padding: const EdgeInsets.all(5.0),
                  decoration: CustomBoxDecoration.myCustomDecoration(),
                  child: TextFormField(
                    controller:nameController,
                    decoration: const InputDecoration(
                        hintText: "Enter Name",
                        contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                        border: InputBorder.none
                    ),
                    style: const TextStyle(fontSize: 14),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Name cannot be empty";
                      } else if (val.length < 5) {
                        return "Please enter must 5 digit";
                      }
                    },
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  width: double.maxFinite,
                  height: 50,
                  padding: const EdgeInsets.all(5.0),
                  decoration: CustomBoxDecoration.myCustomDecoration(),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    controller:counterIdController,
                    decoration: const InputDecoration(
                      counterText: "",
                        hintText: "Enter Counter Id",
                        contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                        border: InputBorder.none
                    ),
                    style: const TextStyle(fontSize: 14),

                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<SignUpCat>(
                          hint:  const Text("Select Category",
                            style: TextStyle(
                                color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:15
                            ),),
                          value: animalCat,
                          icon:  Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.secondary,size: 30,),
                          style:  const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),
                          underline: Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Container(
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
                                          child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color: AppColors.fntClr),),
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
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AppButton(
                    title: 'Get Token',
                    onTap: () {
                      getFilterApi();
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    ) ;
  }
  getFilterApi() async {
  var headers = {
    'Cookie': 'ci_session=052f7198d39c07d7c57fb2fed6a242b3b8aaa2de'
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/queue_token/Apicontroller/counters'));
  request.fields.addAll({
    nameController.text.isEmpty ? "" :  'counter_name':nameController.text,
    cityController.text.isEmpty? "": 'counter_city':cityController.text,
    catId == null ? "" : 'counter_category':  catId.toString(),
    counterIdController.text.isEmpty ? "" :   'counter_id':counterIdController.text
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult =  jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      setState(() {
        userName = nameController.text;
        catNewId = catId;
        cId = counterIdController.text;
        cityName = cityController.text;

      });
     Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));

  }
  else {
  print(response.reasonPhrase);
  }

}

  // Future<void> getFilterApi() async {
  //   // isLoading.value = true;
  //   var param = {
  //     'counter_name':nameController.text,
  //     'counter_city':cityController.text,
  //     //'counter_category':catId,
  //     'counter_id':counterIdController.text
  //   };
  //   apiBaseHelper.postAPICall(getCounterAPI, param).then((getData) {
  //     print('_____getData_____${getData}_________');
  //     bool status = getData['status'];
  //     String msg = getData['msg'];
  //      if(status ==  false){
  //        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen(nameC: nameController.text,cityC: cityController.text,catId: catId,counterId:counterIdController.text,)));
  //      }else{
  //        Fluttertoast.showToast(msg: msg);
  //      }
  //     //isLoading.value = false;
  //   });
  // }
  GetCatModel? getCatModel;
  Future<void> getCateApi() async {
    apiBaseHelper.postAPICall2(getCatAPI).then((getData) {
      getCatModel = GetCatModel.fromJson(getData);
     setState(() {});
      //isLoading.value = false;
    });
  }

}
