import 'dart:convert';

import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Dashboard/dashboard_view.dart';
import 'package:booknplay/Screens/Home/HomeController.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Models/HomeModel/get_result_model.dart';
import '../../Models/HomeModel/get_slider_model.dart';
import '../../Models/HomeModel/lottery_model.dart';
import '../../Models/get_counter_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../Counter/counter_view.dart';
import '../Notification/notification_view.dart';
import '../Search/search_view.dart';
import '../Winner/winner_view.dart';
import 'package:http/http.dart'as http;

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key,this.nameC,this.cityC,this.catId,this.counterId}) : super(key: key);
  String? nameC,cityC,catId,counterId;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSlider();
    getFilterApi();
    print('____userName______${userName}_________');

  }

  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          automaticallyImplyLeading: false,

          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
            ),),
          toolbarHeight: 60,
          title: const Text("QUEUE TOKEN",style: TextStyle(fontSize: 17),),
          actions: [
            Icon(Icons.search),
            SizedBox(width: 15,),
            Padding(
              padding: const EdgeInsets.only(right: 10
              ),
              child: InkWell(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                },
                  child: Image.asset("assets/images/notification.png",height: 15,width:20,color: AppColors.whit,)),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
              gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.9,
                  colors: <Color>[AppColors.primary, AppColors.secondary]),
            ),
          ),
        ),

        body:getSliderModel == null ?Center(child: CircularProgressIndicator()) :RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2),(){
              getSlider();
              getFilterApi();

            });
          },
          child: ListView.builder(
            itemCount: 1,
              itemBuilder: (context,i){
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Welcome To Queue Token',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                        items: getSliderModel?.sliderdata!
                            .map(
                              (item) => Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  "${item.sliderImage}",
                                                ),
                                                fit: BoxFit.fill)),
                                      )
                                  ),
                                ),
                              ]),
                        )
                            .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                            height: 150,
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 1.8,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentPost = index ;
                              });

                            })),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildDots(),),
                    // sliderPointers (items , currentIndex),

                  ],),

                // getCatListView(controller),
                //sliderPointers (controller.catList , controller.catCurrentIndex.value ),
                const SizedBox(height: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.lotteryColor,
                      height: 160,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today's Token",
                              style: TextStyle(
                                  color: AppColors.fntClr,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            InkWell(
                              onTap: (){
                                // Get.toNamed(winnerScreen);
                              },
                              child: Container(
                                height: 110,
                                child:getCounterModel == null ?Center(child: CircularProgressIndicator()): ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:getCounterModel!.todaysTokens![0].todayTokens!.length ,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CounterScreen(cId:
                                          getCounterModel!.todaysTokens![0].todayTokens![index].counterId,
                                            tokenId: getCounterModel!.todaysTokens![0].todayTokens![index].id,
                                            date:getCounterModel!.todaysTokens![0].todayTokens![index].date ,
                                            fTime: getCounterModel!.todaysTokens![0].todayTokens![index].fromTime,
                                            toTime: getCounterModel!.todaysTokens![0].todayTokens![index].toTime,
                                          tTotal: getCounterModel!.todaysTokens![0].todayTokens![index].totalToken,)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                              height: 100,
                                              width: 280,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage("assets/images/lotteryback.png"), fit: BoxFit.fill)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10,top: 6),
                                                        child: Row(
                                                          children: [
                                                            Text("Time:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                            SizedBox(width: 2,),
                                                            Row(
                                                              children: [
                                                                Text("${getCounterModel!.todaysTokens![0].todayTokens![index].fromTime}",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                                Text(" to ${getCounterModel!.todaysTokens![0].todayTokens![index].toTime}",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 8,top: 6),
                                                        child: Row(
                                                          children: [

                                                            Text("Date:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                            SizedBox(width: 2,),
                                                            Text("${getCounterModel!.todaysTokens![0].todayTokens![index].date!}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 5,right: 10,top: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                         Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(height: 2,),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text("Company Name:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                      SizedBox(width: 2,),
                                                                      Text("${getCounterModel!.todaysTokens![0].compnyName}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(height: 10,),
                                                                      Text("Name :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                      SizedBox(width: 2,),
                                                                      Text("${getCounterModel!.todaysTokens![0].todayTokens![index].userName!}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),)
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(height: 10,),
                                                                      Text("Available Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                      SizedBox(width: 2,),
                                                                      Text("${getCounterModel!.todaysTokens![0].todayTokens![index].availableToken!}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),)
                                                                    ],
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                         Row(
                                                          children: [
                                                           Column(
                                                             crossAxisAlignment: CrossAxisAlignment.end,
                                                             children: [
                                                               Row(
                                                                 children: [
                                                                   Text("All Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                   SizedBox(width: 2,),
                                                                   Text("${getCounterModel!.todaysTokens![0].todayTokens![index].totalToken}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                                                 ],
                                                               ),
                                                             Row(
                                                               children: [
                                                                 Text("Current Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                 SizedBox(width: 2,),
                                                                 Text("${getCounterModel!.todaysTokens![0].todayTokens![index].currentToken}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                                               ],
                                                             ),
                                                               SizedBox(height: 2,),
                                                               Row(
                                                                 children: [
                                                                   Text("Next Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                   SizedBox(width: 2,),
                                                                   Text("${getCounterModel!.todaysTokens![0].todayTokens![index].nextToken}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                                                 ],
                                                               ),

                                                             ],
                                                           )
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Upcoming Token",
                              style: TextStyle(
                                  color: AppColors.fntClr,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: (){
                              // Get.toNamed(winnerScreen);
                            },
                            child: Container(
                              child:getCounterModel == null ?Center(child: CircularProgressIndicator()): ListView.builder(
                                  itemCount:getCounterModel!.upcomingTokens![0].nextDayTokens!.length ,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        //Get.toNamed(winnerScreen,arguments:lotteryModel?.data?.lotteries?[index].gameId );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                            height: 100,
                                            width: 280,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("assets/images/lotteryback.png"), fit: BoxFit.fill)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10,top: 6),
                                                      child: Row(
                                                        children: [
                                                          Text("Time:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                          SizedBox(width: 2,),
                                                          Row(
                                                            children: [
                                                              Text("${getCounterModel!.upcomingTokens![0].nextDayTokens![index].fromTime}",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                              Text(" to ${getCounterModel!.upcomingTokens![0].nextDayTokens![index].toTime}",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 8,top: 6),
                                                      child: Row(
                                                        children: [

                                                          Text("Date:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                                          SizedBox(width: 2,),
                                                          Text("${getCounterModel!.upcomingTokens![0].nextDayTokens![index].date!}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5,right: 10,top: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(height: 2,),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text("Company Name:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                    SizedBox(width: 2,),
                                                                    Text("${getCounterModel!.upcomingTokens![0].compnyName}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(height: 10,),
                                                                    Text("Name :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                    SizedBox(width: 2,),
                                                                    Text("${getCounterModel!.upcomingTokens![0].nextDayTokens![index].userName!}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),)
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(height: 10,),
                                                                    Text("Available Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                    SizedBox(width: 2,),
                                                                    Text("${getCounterModel!.upcomingTokens![0].nextDayTokens![index].availableToken!}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),)
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text("All Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                  SizedBox(width: 2,),
                                                                  Text("${getCounterModel!.upcomingTokens![0].nextDayTokens![index].totalToken}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("Current Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                  SizedBox(width: 2,),
                                                                  Text("${getCounterModel!.upcomingTokens![0].nextDayTokens![index].currentToken}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                                                ],
                                                              ),
                                                              SizedBox(height: 2,),
                                                              Row(
                                                                children: [
                                                                  Text("Next Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                                                  SizedBox(width: 2,),
                                                                  Text("${getCounterModel!.upcomingTokens![0].nextDayTokens![index].nextToken}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                                                ],
                                                              ),

                                                            ],
                                                          )
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
                    SizedBox(height: 20,)
                  ],
                )

              ],
            );
          }),
        ),
      ),
    );
  }

  Widget sliderPointers (List doteList , int currentIndex ) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        doteList
            .asMap()
            .entries
            .map((entry) {
          return GestureDetector(
            // onTap:()=> controller.carouselController.animateToPage(entry.key),
            child: Container(
              width: currentIndex == entry.key ? 8 : 8,
              height: 8.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 3.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: currentIndex == entry.key
                      ? AppColors.primary
                      : Colors.black
              ),
            ),
          );
        }).toList());
  }
  int _currentPost = 0;
   _buildDots() {
    List<Widget> dots = [];
    if (getSliderModel == null) {
    } else {
      for (int i = 0; i < getSliderModel!.sliderdata!.length; i++) {
        dots.add(
          Container(
            margin: EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ?  AppColors.profileColor : AppColors.secondary,
            ),
          ),
        );
      }
    }
    return dots;
  }

  GetSliderModel? getSliderModel;
  Future<void> getSlider() async {
    // isLoading.value = true;
    var param = {
      'app_key': ""
    };
    apiBaseHelper.postAPICall(getSliderAPI, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if (status == true) {
        getSliderModel = GetSliderModel.fromJson(getData);
      } else {
        // Fluttertoast.showToast(msg: msg);
      }
      //isLoading.value = false;
    });
  }


  GetCounterModel? getCounterModel;
  getFilterApi() async {
    var headers = {
      'Cookie': 'ci_session=052f7198d39c07d7c57fb2fed6a242b3b8aaa2de'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/queue_token/Apicontroller/counters'));
    request.fields.addAll({
      userName!.isEmpty ? "" : 'counter_name': userName.toString(),
      cityName!.isEmpty ? "" : 'counter_city': cityName.toString(),
      catNewId == null ? "" : 'counter_category': catNewId.toString(),
      cId!.isEmpty ? "" : 'counter_id': cId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult  = GetCounterModel.fromJson(jsonDecode(result));
      setState(() {
        getCounterModel =  finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.message}");

    }
    else {
      print(response.reasonPhrase);
    }

  }


}
