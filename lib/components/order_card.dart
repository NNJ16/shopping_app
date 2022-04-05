import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/components/yse_no_model.dart';
import 'package:shopping_app/dto/order_dto.dart';

import '../services/order_service.dart';

class OrderCard extends StatelessWidget {
  final void Function() callBack;
  const OrderCard({Key? key, required this.orderDTO, required this.callBack}) : super(key: key);
  final OrderDTO orderDTO;

  Future<void> _deleteItem(BuildContext context) async {
    await OrderService.deleteOrder(orderDTO.orderId);
    callBack();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order No. " + orderDTO.orderNo,
                    style: const TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.black45,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext buildContext) => (YesNoModel(
                            buildContext: context,
                            msg: "Are you sure you want to cancel order " +
                                orderDTO.orderNo +
                                "?",
                            callBack: _deleteItem)),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Order Date"),
                  Text("Total"),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMd()
                        .format(orderDTO.dateTime.toLocal())
                        .toString(),
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    "Rs." + orderDTO.total.toString(),
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Order Description"),
                  Text("Status"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    orderDTO.orderDes,
                    style: const TextStyle(color: Colors.black54),
                  )),
                  Text(
                    orderDTO.status,
                    style: TextStyle(
                        color: orderDTO.status == "Completed"
                            ? Colors.blue
                            : kPrimaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
