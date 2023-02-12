import 'package:red_tail/app/modules/account/views/account_view.dart';
import 'package:red_tail/app/modules/cart/views/cart_view.dart';
import 'package:red_tail/app/modules/home/views/home_view.dart';
import 'package:red_tail/app/modules/product/views/product_view.dart';
import 'package:red_tail/app/modules/services/views/services_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../modules/dashboard/views/dashboard_view.dart';


class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: DashboardView(),
      ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.onSurface,
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          showUnselectedLabels: true,
          currentIndex: 0,
          onTap: (value) {
            //controller.currentIndex.value = value;
            Fluttertoast.showToast(
                msg: "This is Center Short Toast${value} ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Services'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                ),
                label: 'Activity'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_box,
                ),
                label: 'Account'),

          ],
        ),

    );
  }
  // Widget getCurrentPage() {
  //   switch (_getxController.currentIndex.value) {
  //     case 0:
  //       return const DashboardView();
  //     case 1:
  //       return const ServicesView();
  //     case 2:
  //       return const CartView();
  //     case 3:
  //       return const AccountView();
  //     case 4:
  //       return  const ProductView();
  //     default:
  //       return const HomeView();
  //   }
  // }
}
