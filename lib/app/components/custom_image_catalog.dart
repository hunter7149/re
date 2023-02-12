import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CustomImageCatalog extends StatelessWidget {
  const CustomImageCatalog(
      {Key? key,this.validationText,
      this.label})
      : super(key: key);
  final String? validationText;
  final String? label;
  final String text = 'Dart,Flutter,Programming';

  @override
  Widget build(BuildContext context) {
    List<String> str = text.split(',');
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child:Column(
        children: [
          Container(
      width: 400,
      decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.rectangle),
      padding: EdgeInsets.only(left: 1,right: 1,bottom: 10),
      child: Card(
        child: Wrap(
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child:  Image.asset('assets/images/${validationText}.png',
                  height: 100,
                  width:46,
                  fit:BoxFit.fill),
              ),
            ],
          ),
        const SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child:  Image.asset(label ?? '',
                      height: 189.7,
                      width:200,
                      fit:BoxFit.fill),
                ),


              ],
            ),
           Card(
             elevation: 0,
             child:Container(
               padding: EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children :[
                      Text("   Nior Aloe vera 100% Moisture Soothing Gel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    Text("   ওজন:৩০০ মি.লি.",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.circle,color: Colors.red,size: 10.0,),
                          ),
                          TextSpan(
                            text: 'খুচরা মূল্য:৭০০ টাকা',style: TextStyle(fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.circle,color: Colors.red,size: 10.0,),
                          ),
                             TextSpan(
                            text: 'Offer.',
                          ),
                          WidgetSpan(
                            child: SizedBox(width: MediaQuery.of(context).size.width/3),
                          ),
                          TextSpan(
                            text: 'Add To Cart',
                            style: TextStyle(
                              fontFamily: 'HelveticaNeueRegular',
                              color: Theme.of(context).primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(() => MerchantSignupPage());
                                Fluttertoast.showToast(
                                            msg: "This is Center Short Toast",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          ),
        const SizedBox(height: 100,),
            Card(
              elevation: 0,
              child:Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children :[
                    Text("About Nior Aloe vera 100% Moisture Soothing Gel ?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 7,),
                    Text("NIOR Aloe Vera 100% Moisture Soothing Gel contains aloe barbadensis leaf extract, rosemary leaf extract, licorice root extract, allantoin and other plant extracts to keep the skin all day long moisturied.",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 120,),
            Card(
              elevation: 0,
              child:Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children :[
                    Text("Active Ingredient:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),


                  ],
                ),
              ),
            ),
        const SizedBox(height: 10,),
         ListView.builder(
                shrinkWrap: true,
                itemCount: str.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // color: Colors.blue,
                    // margin: EdgeInsets.all(10),
                     padding: EdgeInsets.only(left: 34),
                    alignment: Alignment.topLeft,

                    child:
                    // Text(
                    //   str[index],
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //   ),
                    // ),

                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.circle,color: Colors.black87,size: 10.0,),
                          ),
                          TextSpan(
                            text: str[index],
                          )
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 70,),
            Card(
              elevation: 0,
              child:Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children :[
                    Text("Special Claims:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),


                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ListView.builder(
                shrinkWrap: true,
                itemCount: str.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // color: Colors.blue,
                    // margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 34),
                    alignment: Alignment.topLeft,

                    child:
                    // Text(
                    //   str[index],
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //   ),
                    // ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.circle,color: Colors.black87,size: 10.0,),
                          ),
                          TextSpan(
                            text: str[index],
                          )
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 70,),
            Card(
              elevation: 0,
              child:Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children :[
                    Text("Certifications:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("(Include Symbols)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ListView.builder(
                shrinkWrap: true,
                itemCount: str.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // color: Colors.blue,
                    // margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 34),
                    alignment: Alignment.topLeft,

                    child:
                    // Text(
                    //   str[index],
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //   ),
                    // ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.circle,color: Colors.black87,size: 10.0,),
                          ),
                          TextSpan(
                            text: str[index],
                          )
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 70,),
            Card(
              elevation: 0,
              child:Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children :[
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.circle,color: Colors.red,size: 10.0,),
                          ),
                          TextSpan(
                            text: 'Video:',
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(4),
        ),
      ),
    )
  ]));
  }
}
