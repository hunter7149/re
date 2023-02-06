import 'package:get/get.dart';

class OrderHomeController extends GetxController {
  final count = 0.0.obs;
//-------------------Beat and customer dummy list-------------//
  final RxList<Map<String, dynamic>> beatCustomer = <Map<String, dynamic>>[
    // {
    //   "beatname": "beat-1",
    //   "customers": ["Customer-1", "Customer-2"]
    // },
    // {
    //   "beatname": "beat-2",
    //   "customers": ["Customer-3", "Customer-4"]
    // },
    // {
    //   "beatname": "beat-3",
    //   "customers": ["Customer-5", "Customer-6"]
    // }
  ].obs;

  //-------------------------Beat Dropdown menu--------------------//

  RxString dropdownBeatValue = 'Beat-1'.obs;
  RxList<String> beatList = <String>[
    'Beat-1',
    'Beat-2',
    'Beat-3',
    'Beat-4',
    'Beat-5',
    'Beat-6',
    'Beat-7'
  ].obs;
  DropdownBeatValueUpdater(String type) {
    dropdownBeatValue.value = type;
    customerList.clear();
    beatCustomer.refresh();
    beatCustomer.forEach((element) {
      if (element["beatname"] == type) {
        customerList.value = (element["customers"]);
      }
    });
    customerList.refresh();

    dropdownCustomerValue.value = customerList[0];

    update();
  }

  //---------------------------Customer dropdown value--------------------//
  RxString dropdownCustomerValue = 'Shop-123'.obs;
  RxList<String> customerList = <String>[
    'Shop-123',
    'Shop-452',
    'Shop-875',
    'Shop-356',
    'Shop-485',
    'Shop-149',
    'Shop-258'
  ].obs;
  DropdownCustomerValueUpdater(String type) {
    dropdownCustomerValue.value = type;

    update();
  }

  initialDropdownValue() {
    beatList.clear();
    beatCustomer.forEach((element) {
      beatList.add(element['beatname']);
    });
    beatList.refresh();

    dropdownBeatValue.value = beatCustomer[0]["beatname"];
    // DropdownCustomerValueUpdater(beatCustomer[0]["beatname"]);

    customerList.clear();
    beatCustomer.forEach((element) {
      if (element["beatname"] == beatCustomer[0]["beatname"]) {
        customerList.value = (element["customers"]);
      }
    });
    customerList.refresh();
    dropdownCustomerValue.value = customerList[0];

    update();
  }

//----------------Previous order dummy data------------------//
  RxList<Map<String, dynamic>> previousOrder = <Map<String, dynamic>>[
    {
      "user_id": 1,
      "products": <Map<String, dynamic>>[
        {
          "img":
              "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
          "id": 101,
          "name": "Tylox",
          "catagory": "Toilet Cleaner",
          "unit": "pcs",
          "price": 99.5,
          "brand": "Remark"
        },
        {
          "img":
              "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
          "id": 101,
          "name": "Nior Lipgel",
          "catagory": "Lip care",
          "unit": "pcs",
          "price": 120,
          "brand": "Remark"
        },
        {
          "img":
              "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
          "id": 101,
          "name": "Blazor cream",
          "catagory": "Face care",
          "unit": "pcs",
          "price": 599.5,
          "brand": "Remark"
        }
      ]
    }
  ].obs;
  beatCustomerValueSet() {
    beatCustomer.clear();
    beatCustomer.value = [
      {
        "beatname": "beat-1",
        "customers": ["Customer-1", "Customer-2"]
      },
      {
        "beatname": "beat-2",
        "customers": ["Customer-3", "Customer-4"]
      },
      {
        "beatname": "beat-3",
        "customers": ["Customer-5", "Customer-6"]
      }
    ];
    beatCustomer.refresh();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    beatCustomerValueSet();
    initialDropdownValue();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
