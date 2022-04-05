import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import 'package:shopping_app/services/order_service.dart';

class EditOrderModel extends StatefulWidget {
  final Future<void> Function(String, String) callBack;
  final String orderId;
  final String status;
  const EditOrderModel({ Key? key, required this.callBack, required this.orderId, required this.status }) : super(key: key);

  @override
  State<EditOrderModel> createState() => _EditOrderModelState();
}

class _EditOrderModelState extends State<EditOrderModel> {
  String dropdownValue = "Pending";

  @override
  void initState() {
    dropdownValue = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Edit Order',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content:Container(
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Order Status : "), 
             DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                elevation: 16,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                onChanged: (String? newValue) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: (<String>[
                  "Pending",
                  "Prepared",
                  "Delivered",
                  "Completed"
                ]).map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
          ],
        )
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.callBack(dropdownValue, widget.orderId);
            Navigator.pop(context, false);
          },
          child: const Text('OK', style: TextStyle(color: kPrimaryColor),),
        ),
        TextButton(
          onPressed: () => (Navigator.pop(context, false)),
          child: const Text('CANCEL', style: TextStyle(color: kPrimaryColor),),
        ),
      ],
    );
  }
}