import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../components/constants.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String dropdownValue = "100g";
  String _title = "Add Item";

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Item name',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Item price (per unit)',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Item description',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Select amount per unit',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
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
                items: (<String>["None","100g", "200g", "500g", "1Kg", "100mL", "200mL","500mL","1L"])
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 10),
                child: Text(
                  'Select image',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  image != null
                      ? SizedBox(
                        width: 200,
                        height: 150,
                        child: Image.file(image!))
                      : SizedBox(
                        width: 200,
                        height: 150,
                        child: Image.asset("assets/images/imgP.png"),
                        ),
                 Padding(
                   padding: const EdgeInsets.only(right: 32.0, bottom: 16),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                        IconButton(
                        color: kPrimaryColor,
                        icon: const Icon(Icons.add_photo_alternate, size: 40,),
                        onPressed: () async{
                          await pickImage();
                        }),
                    IconButton(
                        color: kPrimaryColor,
                        icon: const Icon(Icons.add_a_photo,  size: 40),
                        onPressed: () {
                          pickImageC();
                        }),
                     ],
                   ),
                 )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
