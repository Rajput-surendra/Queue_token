import 'package:booknplay/Screens/Bookings/my_booking_controller.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/lottery_model.dart';
import '../../Models/HomeModel/my_lottery_model.dart';
import '../../Services/api_services/apiConstants.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key, this.isFrom}) : super(key: key);
final bool? isFrom ;

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  String? userId;
  getUser() async {
    userId = await SharedPre.getStringValue('userId');
    getLottery();
  }
  LotteryModel? lotteryModel;
  Future<void> getLottery() async {
    apiBaseHelper.postAPICall2(getLotteryAPI).then((getData) {
      setState(() {
        lotteryModel = LotteryModel.fromJson(getData);
      });

      //isLoading.value = false;
    });
  }

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
        title: Text("My Token",style: TextStyle(fontSize: 17),),
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
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        //height: MediaQuery.of(context).size.height/1.1,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:lotteryModel?.data?.lotteries?.length ,
                            // itemCount:2,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  if( lotteryModel?.data?.lotteries?[index].active == '0' ){
                                    Fluttertoast.showToast(msg: "Booking not yet to be start");
                                  }else{
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>WinnerScreen(gId:lotteryModel?.data?.lotteries?[index].gameId )));
                                  }

                                  //Get.toNamed(winnerScreen,arguments:lotteryModel?.data?.lotteries?[index].gameId );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                      height: 115,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage("assets/images/lotteryback.png"), fit: BoxFit.fill)),
                                      child:  Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Row(
                                                  children: [
                                                    SizedBox(height: 25,),
                                                    Text("Open:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                    SizedBox(width: 2,),
                                                    Text("${lotteryModel?.data?.lotteries?[index].openTime}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(height: 25,),
                                                    Text("Close:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                    SizedBox(width: 2,),
                                                    Text("${lotteryModel?.data?.lotteries?[index].closeTime}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(height: 35,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text("Dr.Name:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                              SizedBox(width: 2,),
                                                              Text("Surendra",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Text("Available Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                              SizedBox(width: 2,),
                                                              Text("16",style: TextStyle(color: AppColors.fntClr,fontSize: 12),)
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Date :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                    SizedBox(width: 2,),
                                                    Text("${lotteryModel?.data?.lotteries?[index].resultDate}",style: TextStyle(color: AppColors.fntClr,fontSize: 12),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      )
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      )
    ) ;
  }

  // MyLotteryModel? myLotteryModel;
  // Future<void> getLottery() async {
  //   // isLoading.value = true;
  //   var param = {
  //     'user_id':userId
  //   };
  //   apiBaseHelper.postAPICall(getLotteryAPI, param).then((getData) {
  //     String msg = getData['msg'];
  //     myLotteryModel = MyLotteryModel.fromJson(getData);
  //     // Fluttertoast.showToast(msg: msg);
  //
  //     //isLoading.value = false;
  //   });
  // }
}
