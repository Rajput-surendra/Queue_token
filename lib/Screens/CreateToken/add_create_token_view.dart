import 'dart:convert';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';
import 'package:http/http.dart' as http;
import '../../Models/get_sub_plan_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';
import 'package:table_calendar/table_calendar.dart';


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
         bottomSheet:AppButton1(
   title: "Create Token",
   onTap: (){
     createToken();
   },
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
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                children: [

                  SizedBox(height: 20),
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.maxFinite,
                      height: 50,
                      padding: const EdgeInsets.all(5.0),
                      decoration: CustomBoxDecoration.myCustomDecoration(),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("From Time",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 5,),
                            morningShift(),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("To Time",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 5,),
                            eveningShift(),
                          ],
                        )

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 2,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        icon:  const Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.fntClr,size: 25,),
                        hint:  const Text('Select Days',
                          style: TextStyle(
                              color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:12
                          ),),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.fntClr,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },

                      ),
                    ),
                  ),

                ],
              ),
            )));
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
      'from_time':"${_selectedTime!.format(context)}",
      'to_time':"${_selectedTime1!.format(context)}",
      'user_name':nameController.text,
      'date':selectedValue.toString(),
    });
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
  TimeOfDay? _selectedTime ;
  TimeOfDay? _selectedTime1;
  Widget morningShift() {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime != null
                  ? '${_selectedTime!.format(context)}'
                  : 'From Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget eveningShift() {
    return  InkWell(
      onTap: () {
        _chooseTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime1 != null
                  ? '${_selectedTime1!.format(context)}'
                  : 'To Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime) {

      setState(() {
        _selectedTime = pickedTime;
      });
    }

  }
  Future<void> _chooseTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime1 ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime1) {
      setState(() {
        _selectedTime1 = pickedTime;
      });
    }
  }

  final List<String> items = [
    'Today',
    'Tomorrow',
  ];
  String? selectedValue;
}
