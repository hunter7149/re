import '../../../config/app_assets.dart';
import '../../../config/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Cart',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: AppThemes.PrimaryLightColor,
              child: Row(
                children: const [
                  Icon(Icons.location_on),
                  SizedBox(width: 10),
                  Text('Deliver to Shariar - Rochester 14404')
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                            children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, -7.0),
                                  child: const Text(
                                    '\$',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const TextSpan(
                                text: '29',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, -7.0),
                                  child: const Text(
                                    '99',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          //foregroundColor: Colors.white,
                          backgroundColor: Colors.yellow[700]),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Proceed to checkout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  AppAssets.ASSET_BEAUTY_PRODUCT_IMAGE,
                                  height: 96,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.remove)),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(0),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.blue))),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller:
                                            TextEditingController(text: '2'),
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.add)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'SHCKE Bubble Machine 69 Holes Rocket Launcher Bubble Machine...'),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 16),
                                    children: [
                                      WidgetSpan(
                                        child: Transform.translate(
                                          offset: const Offset(0.0, -7.0),
                                          child: const Text(
                                            '\$',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '29',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      WidgetSpan(
                                        child: Transform.translate(
                                          offset: const Offset(0.0, -7.0),
                                          child: const Text(
                                            '99',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Exclucive Prime Price',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.yellow[800],
                                    ),
                                    const Text(
                                      'prime',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 185, 246),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      ' & ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'FREE RETURNS',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 185, 246),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const Text('In Stock',
                                    style: TextStyle(color: Colors.green)),
                                Row(
                                  children: const [
                                    Text(
                                      'Size: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('on size'),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      'Color: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('[Pink]'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          color: Colors.grey[200],
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Delete'),
                                          ),
                                        )),
                                    TextButton(
                                        onPressed: () {},
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          color: Colors.grey[200],
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Save for later'),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
