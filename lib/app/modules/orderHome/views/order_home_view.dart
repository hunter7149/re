import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../components/custom_dropdown.dart';
import '../../../config/app_assets.dart';
import '../../../data/menus.dart';
import '../../../models/menu.dart';
import '../../../routes/app_pages.dart';
import '../controllers/order_home_controller.dart';




class OrderHomeView extends GetView<OrderHomeController> {
  const OrderHomeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final items=["item 1","item 2","item 3"];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final List<String> ditems = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
      'Item5',
      'Item6',
      'Item7',
      'Item8',
    ];
    String? selectedValue;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 50.0,
        bottomOpacity: 0.0,
        elevation: 0.0,
        titleTextStyle: TextStyle(color: Colors.black87),
        title: Image.asset("assets/logo/login_logo_hb.png",width: 150,
            height: 30,
            fit:BoxFit.fill),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.arrow_back),
            // Image.asset("assets/images/back_arrow.jpg"),
            color: Colors.black87,
            tooltip: 'Comment Icon',
            onPressed: () => Get.back(
              result: controller.count.value,
              id: Constants.nestedNavigationNavigatorId,
            ),
          ), //IconButton
          //IconButton
        ], //<Widget>[]
        // backgroundColor: Colors.greenAccent[400],
        // elevation: 50.0,
        leading: IconButton(
          icon: new  Image.asset("assets/logo/main-menu.png",
              fit:BoxFit.fill),
          tooltip: 'Menu Icon',
          color: Colors.black87,
          onPressed: () {},
        ),
      ),
        body: SafeArea(

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                // const Padding(height: 1,color:Colors.grey ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border(
                //       right: BorderSide( //                   <--- right side
                //         color: Colors.grey,
                //         width: 3.0,
                //       ),
                //         left: BorderSide( //                   <--- right side
                //           color: Colors.grey,
                //           width: 3.0,
                //         ),
                //         top: BorderSide( //                   <--- right side
                //           color: Colors.grey,
                //           width: 1.0,
                //         ),
                //         bottom: BorderSide( //                   <--- right side
                //           color: Colors.grey,
                //           width: 1.0,
                //         ),),
                //     shape: BoxShape.rectangle,
                //   ),
                //   child: Row(
                //       children: [
                        // Text("Beat",),
                    const    TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 16),
                              hintText: 'Search Beat',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              )),
                          style: TextStyle(color: Colors.black),
                        ),
                      // ],

                    // ),
                  // ),
                const SizedBox(height: 3),
                const    TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16),
                      hintText: 'Search Customer',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      )),
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Last order',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(20))),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isPhone
                          ? 2
                          : context.isSmallTablet
                          ? 3
                          : 4,
                      childAspectRatio: 4 / 2.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 4,
                          child: Padding(

                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AppAssets.ASSET_BOTTLE_IMAGE,
                                  height: 64,
                                  width: 32,
                                  fit: BoxFit.fitHeight,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Tylox 122',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text('Toilet Cleaner',
                                          style: TextStyle(fontSize: 10)),
                                      Text('Freash Aqua',
                                          style: TextStyle(fontSize: 10)),
                                      Text(
                                        'Unit Tk. 99',
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 300,
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 2 ,
                    children: List.generate(10,(index){
                      return GestureDetector(

                        onTap: () {
                          // print("Tapped a Container");
                          //     Fluttertoast.showToast(
                          //         msg: "This is Center Short Toast ${index} ",
                          //         toastLength: Toast.LENGTH_SHORT,
                          //         gravity: ToastGravity.CENTER,
                          //         timeInSecForIosWeb: 1,
                          //         backgroundColor: Colors.red,
                          //         textColor: Colors.white,
                          //         fontSize: 16.0
                          //     );
                          Get.toNamed(
                              Routes.PRODUCTC,
                              arguments: index.toString(),
                              id: Constants.nestedNavigationNavigatorId);
                        },
                        child:Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            child:
                            // Text("Item ${index}"),
                            Image(
                              image:AssetImage("assets/images/${index}.png") ,
                            ),
                          ),
                        ),);
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: menus.length,
                  itemBuilder: (BuildContext context, int index) {
                    MenuModel menu = menus[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        color: menu.color,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                menu.tittle ?? '',
                                style: const TextStyle(fontSize: 24),
                              ),
                              Image.asset(
                                menu.image ?? AppAssets.ASSET_EMPTY_IMAGE,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    AppAssets.ASSET_BRAND_IMAGE,
                                    height: 40,
                                  );
                                },
                                height: 64,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
