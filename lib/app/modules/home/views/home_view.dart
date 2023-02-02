import '../../../config/app_assets.dart';
import '../../../data/menus.dart';
import '../../../models/menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16),
                      hintText: 'Search Customer',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.0),
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
                                        'Taka.99 Unit Taka 99',
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
                SizedBox(
                  height: 200,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isPhone
                          ? 2
                          : context.isSmallTablet
                              ? 3
                              : 4,
                      childAspectRatio: 4 / 6,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          shape: const RoundedRectangleBorder(
                            //<-- SEE HERE
                            side: BorderSide(
                              color: Colors.greenAccent,
                            ),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(AppAssets.ASSET_BRAND_IMAGE),
                          ));
                    },
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
        ));
  }
}
