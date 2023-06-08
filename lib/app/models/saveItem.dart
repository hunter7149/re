import 'package:floor/floor.dart';

@entity
class SaveItem {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? saveId;
  String? userId;
  String? status;
  int? totalItem;
  String? dateTime;
  double? lattitude;
  double? longitude;
  double? totalPrice;
  String? beatName;
  String? CustomerName;
  String? CustomerId;

  SaveItem(
      {this.id,
      this.saveId,
      this.userId,
      this.CustomerId,
      this.status,
      this.totalItem,
      this.totalPrice,
      this.dateTime,
      this.lattitude,
      this.longitude,
      this.beatName,
      this.CustomerName});
}
