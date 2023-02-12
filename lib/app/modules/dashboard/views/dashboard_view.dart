import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                // const TextField(
                //   decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 16),
                //       hintText: 'Search Customer',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(32.0),
                //         ),
                //       )),
                //   style: TextStyle(color: Colors.black),
                // ),

                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        offerItem(
                            dataLink:
                                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Dreamy-Glow-Brightening-Cream-2.jpg"),
                        offerItem(
                            dataLink:
                                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Dreamy-Glow-Brightening-Cream-2.jpg"),
                        offerItem(
                            dataLink:
                                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Dreamy-Glow-Brightening-Cream-2.jpg"),
                        offerItem(
                            dataLink:
                                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Dreamy-Glow-Brightening-Cream-2.jpg"),
                        offerItem(
                            dataLink:
                                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Dreamy-Glow-Brightening-Cream-2.jpg")
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        "Dashboard",
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Container(
                    // height: MediaQuery.of(context).size.height / 1.5,
                    child: GridView.count(
                        //scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        childAspectRatio: (0.88),
                        shrinkWrap: true,
                        children: [
                          menuItem(
                              icon: Icons.shopping_cart_checkout,
                              color: Colors.blue,
                              title: "Order Management",
                              function: () {
                                Get.toNamed(Routes.ORDERHOME,
                                    id: Constants.nestedNavigationNavigatorId);
                              }),
                          menuItem(
                              icon: Icons.list,
                              color: Colors.deepOrange,
                              title: "Product Catalogue",
                              function: () async {
                                var result;
                                result = await Get.toNamed(Routes.PRODUCT,
                                    arguments:
                                        controller.argumentToDetailPage.value,
                                    id: Constants.nestedNavigationNavigatorId);
                                controller.argumentFromDetailPage.value =
                                    result == null
                                        ? 'No argument'
                                        : (result as double).toStringAsFixed(0);
                              }),
                          menuItem(
                              icon: Icons.discount,
                              color: Colors.pink,
                              title: "Offers",
                              function: () {
                                Get.toNamed(Routes.OFFERINFO,
                                    id: Constants.nestedNavigationNavigatorId);
                              }),
                          menuItem(
                              icon: Icons.tv,
                              color: Colors.green,
                              title: "Promotionals",
                              function: () {
                                Get.toNamed(Routes.PROMOTIONALADS,
                                    id: Constants.nestedNavigationNavigatorId);
                              }),
                          menuItem(
                              icon: FontAwesomeIcons.lineChart,
                              color: Colors.teal,
                              title: "Statistics",
                              function: () {
                                Get.toNamed(Routes.STATISTICSPAGE,
                                    id: Constants.nestedNavigationNavigatorId);
                              }),
                          menuItem(
                              icon: Icons.list,
                              color: Colors.deepPurple,
                              title: "Leadership Board",
                              function: () {
                                Get.toNamed(Routes.LEADERSHIPPAGE,
                                    id: Constants.nestedNavigationNavigatorId);
                              })
                        ]
                        //-----------------------------New system with dynamic data-----------------//
                        //  controller.data
                        //     .map((element) => Container(
                        //           height: 50,
                        //           width: 50,
                        //           color: Colors.red,
                        //         ))
                        //     .toList(),
                        //-----------------------------Previous system with dynamic data-----------------//
                        //   List.generate(6,(index){
                        //    return GestureDetector(
                        //      onTap: () async {
                        //        // print("Tapped a Container");
                        //        //     Fluttertoast.showToast(
                        //        //         msg: "This is Center Short Toast ${index} ",
                        //        //         toastLength: Toast.LENGTH_SHORT,
                        //        //         gravity: ToastGravity.CENTER,
                        //        //         timeInSecForIosWeb: 1,
                        //        //         backgroundColor: Colors.red,
                        //        //         textColor: Colors.white,
                        //        //         fontSize: 16.0
                        //        //     );
                        //        //Navigator.of(context).pushNamed('/product');
                        //        // Get.toNamed('/product');
                        //        controller.goToDetailPage(index);

                        //      },
                        //      child:Container(
                        //         width: 100,
                        //        height: 100,
                        //        child: Card(
                        //          shape: RoundedRectangleBorder(
                        //            borderRadius: BorderRadius.circular(15.0),
                        //          ),
                        //          color: Colors.white,
                        //          child:
                        //          // Text("Item ${index}"),
                        //          Image(
                        //            image:AssetImage("assets/images/${index}.jpg") ,
                        //          ),
                        //        ),
                        //      ),);
                        //  }),
                        ),
                  ),
                ),

                //const SizedBox(height: 80),
              ],
            ),
          ),
        ));
  }

  static menuItem(
      {required IconData icon,
      required MaterialColor color,
      required String title,
      required VoidCallback function}) {
    return ZoomTapAnimation(
      onTap: function,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        // EdgeInsets.only(
        //                             left: index % 2 == 0
        //                                 ? 8
        //                                 : 0,
        //                             right: index % 2 != 0
        //                                 ? 8
        //                                 : 0),
        decoration: BoxDecoration(
            color: color.shade100, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: color.shade200,
                  borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.all(15),
              child: Icon(
                icon,
                size: 50,
                color: color.shade500,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: color.shade500,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  static offerItem({required String dataLink}) {
    return Container(
      margin: EdgeInsets.all(10),
      // height: 175,
      width: 175,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          dataLink,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
