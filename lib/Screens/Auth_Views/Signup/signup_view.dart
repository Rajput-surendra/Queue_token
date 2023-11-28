import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Auth_Views/Login/login_view.dart';
import 'package:booknplay/Screens/Auth_Views/Signup/signup_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/extentions.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../Models/HomeModel/signUp_cat_model.dart';
import '../../../Services/api_services/apiConstants.dart';
import '../../../Services/api_services/apiStrings.dart';
import '../../../Widgets/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String selectedOption = "Get Token";
  String? catId;
  SignUpCat? animalCat;
 bool? isUser = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignupController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
             // physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/punbabComman.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          const Text("Sign Up", style: TextStyle(color: AppColors
                              .whit, fontWeight: FontWeight.bold, fontSize: 25),),
                          const SizedBox(height: 40,),
                          Image.asset("assets/images/SIGN UP.png", height: 150,
                            width: 200,),
                          const SizedBox(height: 30,),
                             Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Radio(
                                          value: 'Get Token',
                                          groupValue: selectedOption,
                                          activeColor: AppColors.primary,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption = value.toString();
                                            });
                                          },
                                        ),
                                        const Text('Get Token',style: TextStyle(color: AppColors.whit),),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Row(
                                      children: [
                                        Radio(
                                          value: 'Get Counter',
                                          groupValue: selectedOption,
                                          activeColor: AppColors.primary,
                                          focusColor: AppColors.activeBorder,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption = value.toString();
                                            });
                                          },
                                        ),
                                        const Text('Get Counter',style: TextStyle(color: AppColors.whit),),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                if (selectedOption == 'Get Counter')
                                Column(
                                  children: [
                                    Container(
                                 width: double.maxFinite,
                                 height: 50,
                                     padding: const EdgeInsets.all(5.0),
                                       decoration: CustomBoxDecoration.myCustomDecoration(),
                                     child: TextFormField(
                                       controller: nameController,
                                       decoration: const InputDecoration(
                                           hintText: "Company Name",
                                           contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                         border: InputBorder.none
                                       ),
                                       style: const TextStyle(fontSize: 14),
                                       validator: (val) {
                                         if (val!.isEmpty) {
                                           return "Company name cannot be empty";
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
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        controller: mobileController,
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          hintText: "Mobile Number",
                                          contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                         // prefixIcon: Icon(Icons.call),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Mobile cannot be empty";
                                          } else if (val.length < 10) {
                                            return "Please enter mobile must 10 digit";
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
                                        controller: cityController,
                                        decoration: const InputDecoration(
                                            hintText: "City Name",
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "City cannot be empty";
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
                                        controller: addressController,
                                        decoration: const InputDecoration(
                                            hintText: "Address Name",
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Address cannot be empty";
                                          } else if (val.length < 4) {
                                            return "Please enter must 5 digit";
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),

                          if (selectedOption == 'Get Token')
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
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
                                         return "name cannot be empty";
                                       } else if (val.length < 5) {
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
                                     maxLength: 10,
                                     keyboardType: TextInputType.number,
                                     controller: mobileController,
                                     decoration: const InputDecoration(
                                         counterText: "",
                                         hintText: "Mobile Number",
                                         contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                         // prefixIcon: Icon(Icons.call),
                                         border: InputBorder.none
                                     ),
                                     style: const TextStyle(fontSize: 14),
                                     validator: (val) {
                                       if (val!.isEmpty) {
                                         return "Mobile cannot be empty";
                                       } else if (val.length < 10) {
                                         return "Please enter mobile must 10 digit";
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
                                     controller: cityController,
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
                               ],
                             ),
                           ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: AppButton(
                              title: 'SignUp',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedOption == 'Get Token') {

                                    controller.registerUser(
                                    mobile: mobileController.text,
                                    name: nameController.text,
                                      address: "",
                                      city:cityController.text,
                                      selected: false,
                                    );
                                  } else if (selectedOption == 'Get Counter') {
                                    controller.registerUser(
                                      mobile: mobileController.text,
                                      name: nameController.text,
                                      address: addressController.text,
                                      city: cityController.text,
                                      selected: true,
                                    );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "All field are required");
                                }
                              },
                          ),
                            ),
                             Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(loginScreen);
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: AppColors.whit,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                ),
              ),

            ),
          );
        });


  }
  // reactive(){
  //   return   Obx(
  //         () =>
  //         Padding(
  //             padding: const EdgeInsets.symmetric(
  //                 horizontal: 25),
  //             child: controller.isLoading.value
  //                 ? const Center(
  //               child:
  //               CircularProgressIndicator(),
  //             ) : AppButton(
  //               title: 'Sign Up',
  //               onTap: () {
  //                 if (mobileController.text.isEmpty &&
  //                     nameController.text.isEmpty) {
  //                   Fluttertoast.showToast(
  //                       msg: "All Fields Required");
  //                 } else
  //                 if (mobileController.text.isEmpty ||
  //                     mobileController.text.length <
  //                         10) {
  //                   Fluttertoast.showToast(
  //                       msg: "Please Enter 10 digit number ");
  //                 }
  //
  //                 else {
  //                   controller.registerUser(
  //                       mobile: mobileController.text,
  //                       name: nameController.text,
  //                       referral: referralController
  //                           .text);
  //                 }
  //               },
  //             )),
  //   ),
  //   const SizedBox(
  //   height: 20,
  //   ),
  //
  //   }


  GetCatModel? getCatModel;
  Future<void> getLottery() async {
    apiBaseHelper.postAPICall2(getCatAPI).then((getData) {
      setState(() {
        getCatModel = GetCatModel.fromJson(getData);
      });

      //isLoading.value = false;
    });
  }

}
