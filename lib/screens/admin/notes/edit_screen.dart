import 'package:flutter/material.dart';
import 'package:shopping_app/services/database_service.dart';

class EditData extends StatefulWidget {
  String? title;
  String? detail;
  String? id;

  EditData({Key? key, this.id, this.title, this.detail}) : super(key: key);

  // navigation(BuildContext context, Widget next) {
  //   Navigator.push(context, MaterialPageRoute(builder: (_) => next));
  // }

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController titleC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    titleC.text = widget.title!;
    detailC.text = widget.detail!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTES UPDATE"),
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
                          labelText: "Title",
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
                          labelText: "Detail",
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
                            DatabaseServices.updateData(
                                widget.id!, titleC.text, detailC.text);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("UPDATE"))
                  ],
                ))),
      )),
    );
  }
}


// class EditData extends StatelessWidget {
//   String? title;
//   String? detail;
//   String? id;

//   EditData({Key? key, this.id, this.title, this.detail}) : super(key: key);

//   TextEditingController titleC = TextEditingController();
//   TextEditingController detailC = TextEditingController();
//   final formkey = GlobalKey<FormState>();

//   // get onPressed => null;



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("NOTES UPDATE"),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Form(
//             key: formkey,
//             child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: titleC,
//                       validator: (v) {
//                         if (v!.isEmpty) {
//                           return "Please Enter Title";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                           labelText: "Title",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10))),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       controller: detailC,
//                       maxLines: 7,
//                       minLines: 3,
//                       validator: (v) {
//                         if (v!.isEmpty) {
//                           return "Please Enter Details";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                           labelText: "Detail",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10))),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.deepPurple),
//                             minimumSize: MaterialStateProperty.all(
//                                 const Size(double.infinity, 40))),
//                         onPressed: () {
//                           if (formkey.currentState!.validate()) {
//                             DatabaseServices.updateData(
//                                 id!, titleC.text, detailC.text);
//                           }
//                         },
//                         child: const Text("UPDATE"))
//                   ],
//                 ))),
//       )),
//     );
//   }
// }
