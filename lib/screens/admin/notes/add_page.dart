import 'package:flutter/material.dart';
import 'package:shopping_app/services/database_service.dart';

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  TextEditingController titleC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  final formkey = GlobalKey<FormState>();

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD NOTES"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
            key: formkey,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleC,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please Enter Title";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: detailC,
                      maxLines: 10,
                      minLines: 10,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please Enter Details";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Dretail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepPurple),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 40))),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            DatabaseServices.addData(titleC.text.toString(),
                                detailC.text.toString());
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("ADD"))
                  ],
                ))),
      )),
    );
  }
}
