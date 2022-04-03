class Order{
  final String orderNo;
  final String userId;
  final String orderDes;
  final String status;
  final DateTime dateTime;
  final double total;

  const Order({required this.orderNo, required this.userId, required this.orderDes, required this.status, required this.dateTime,required this.total});

}