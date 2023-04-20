import 'package:floor/floor.dart';
import 'package:get/get.dart';
import 'package:red_tail/app/api/repository/repository.dart';

class ProductbController extends GetxController {
  final count = 0.0.obs;
  RxList<dynamic> products = <dynamic>[
    {
      "id": 1,
      "name": "Lipstick",
      "description": "This is product of remark HB",
      "usp": "200",
      "sku": "200ml,300ml,400ml",
      "variant": "rose,velvet",
      "quantity": 15,
      "image":
          "https://www.kablewala.com.bd/images/detailed/229/3fc5d8bd56e8f5555dc7064be8d031f3.jpg"
    },
    {
      "id": 2,
      "name": "Face powder",
      "description": "This is product of remark HB",
      "usp": "200",
      "sku": "200ml,300ml,400ml",
      "variant": "rose,velvet",
      "quantity": 15,
      "image": "https://cf.shopee.com.my/file/05d165b44af0947e6c1293e942581d48"
    },
    {
      "id": 3,
      "name": "Body Lotion",
      "description": "This is product of remark HB",
      "usp": "200",
      "sku": "200ml,300ml,400ml",
      "variant": "rose,velvet",
      "quantity": 15,
      "image":
          "http://www.guestcomfort.com/storage/199A20B877506F6C5E7B3A27E059E0711C32FA124520522C12F2C3FB3A2AC7C0/87953891361949899c780fdfb13d19c6/500-500-0-jpg.Jpeg/media/1b044a7a84d744039aa911b5b8ddd72c/Noir_30%20ml%20Body%20Lotion%20web_600x600px.jpeg"
    },
  ].obs;
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  dataSetter(dynamic es) {
    data.value = es as Map<String, dynamic>;
    Update();
    print(data);
    requestItemCount();
  }

  RxBool isItemCountLoading = false.obs;
  requestItemCount() async {
    isItemCountLoading.value = true;
    Update();
    await Repository()
        .getBrandItemCount(body: {"brand": data['brand']}).then((value) {
      products.clear();
      products.value = value['value'];
      products.refresh();
      isItemCountLoading.value = false;

      Update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    // dataSetter(data);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
