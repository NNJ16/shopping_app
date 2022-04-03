import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/model/order.dart';

import '../dto/order_dto.dart';

class OrderService {
  static CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  static Future<String> addItem(Order order) {
    return orders.add({
      'orderNo': order.orderNo,
      'userId': order.userId,
      'orderDes': order.orderDes,
      'status': order.status,
      'dateTime': order.dateTime,
      'total': order.total
    }).then((value) {
      return value.id;
    }).catchError((error) => "");
  }

  static Future<List<OrderDTO>> getOrdersById(String userId) async {
    List<OrderDTO> orderList = [];
    await orders
        .where("userId", isEqualTo: userId)
        .orderBy("dateTime", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        OrderDTO order = OrderDTO(
          orderId: doc.id,
          userId: doc["userId"],
          orderNo: doc["orderNo"],
          orderDes: doc["orderDes"],
          status: doc["status"],
          dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
          total: doc["total"],
        );
        orderList.add(order);
      }
    }).catchError((error) {
      print(error);
    });
    return orderList;
  }

  static Future<List<OrderDTO>> getAllOrders() async {
    List<OrderDTO> orderList = [];
    await orders
        .orderBy("dateTime", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        OrderDTO order = OrderDTO(
          orderId: doc.id,
          userId: doc["userId"],
          orderNo: doc["orderNo"],
          orderDes: doc["orderDes"],
          status: doc["status"],
          dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
          total: doc["total"],
        );
        orderList.add(order);
      }
    }).catchError((error) {
      print(error);
    });
    return orderList;
  }

  static Future<bool> editOrder(String status, String id) {
    return orders.doc(id).update({
      'status': status,
    }).then((value) {
      return true;
    }).catchError((error) => false);
  }

  static Future<bool> deleteOrder(String id) {
    return orders
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}
