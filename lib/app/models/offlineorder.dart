import 'package:floor/floor.dart';

@entity
class OfflineOrder {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? orderId;

  String? status;

  OfflineOrder({
    this.id,
    this.orderId,
    this.status,
  });
}
