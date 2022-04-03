import 'package:flutter/material.dart';
import '../../../components/order_card.dart';
import '../../../components/order_edit_card.dart';
import '../../../dto/order_dto.dart';
import '../../../services/order_service.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({ Key? key }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  void refresh(){
    setState(() {
      
    });
  }

  Future<List<OrderDTO>> getAllOrders() async{
    return await OrderService.getAllOrders();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder(
            future: getAllOrders(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                int length = snapshot.data!.length;

                if (snapshot.hasData) {
                  return ListView(
                    shrinkWrap: true,
                    children: List.generate(length, (index) {
                      return Center(
                          child: OrderEditCard(orderDTO: snapshot.data!.elementAt(index), callBack: refresh,));
                    }),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })
      ),
    );
  }
}