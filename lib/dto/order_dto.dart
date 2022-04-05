class OrderDTO{
  final String orderId;
  final String orderNo;
  final String userId;
  final String orderDes;
  final String status;
  final DateTime dateTime;
  final double total;

  const OrderDTO({required this.orderId, required this.orderNo, required this.userId, required this.orderDes, required this.status, required this.dateTime,required this.total});

}