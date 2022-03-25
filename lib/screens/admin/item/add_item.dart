import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shopping_app/dto/item_dto.dart';
import 'package:shopping_app/model/item.dart';
import 'package:shopping_app/services/item_service.dart';
import '../../../components/constants.dart';

class AddItemScreen extends StatefulWidget {
  final String title;
  final ItemDTO? itemDTO;
  const AddItemScreen({Key? key, this.title = "", this.itemDTO})
      : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String _imgURL =
      "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=20&m=1222357475&s=170667a&w=0&h=YGycIDbBRAWkZaSvdyUFvotdGfnKhkutJhMOZtIoUKY=";
  String dropdownValue = "100g";
  String dropdownValue0 = "Vegetables";
  String _title = "Add Item";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseStorage storage = FirebaseStorage.instance;
  File? _image;

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemDesController = TextEditingController();

  setImage(String imgPath) async {
    final destination = 'files/' + imgPath;
    final ref = FirebaseStorage.instance.ref(destination).child('image');
    var url = await ref.getDownloadURL();
    setState(() {
      _imgURL = url;
    });
  }

  @override
  initState() {
    if (widget.title != "") {
      _itemNameController.text = widget.itemDTO!.itemName;
      _itemPriceController.text = widget.itemDTO!.itemPrice.toString();
      _itemDesController.text = widget.itemDTO!.itemDescription;
      dropdownValue = widget.itemDTO!.itemAmount;
      dropdownValue0 = widget.itemDTO!.itemcategory;

      setImage(widget.itemDTO!.imgPath);

      setState(() {
        _title = widget.title;
      });
    }
    super.initState();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadFile() async {
    if (_image == null) return;
    final fileName = basename(_image!.path);
    final destination = 'files/$fileName';

    try {
      final ref = storage.ref(destination).child('image');
      await ref.putFile(_image!);
    } catch (e) {
      print('error occured');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  String? _mandatoryValidator(String? text) {
    if (text!.isEmpty) {
      return 'Required field';
    } else {
      return null;
    }
  }

  Future<String> addItem() async {
    if (_image != null) {
      if (_formKey.currentState!.validate()) {
        Item item = Item(
            imgPath: basename(_image!.path),
            itemName: _itemNameController.text,
            itemAmount: dropdownValue,
            itemCategory: dropdownValue0,
            itemDescription: _itemDesController.text,
            itemPrice: double.parse(_itemPriceController.text));
        uploadFile();
        return await ItemService.addItem(item);
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  Future<bool> editItem() async {
    if (_image != null) {
      if (_formKey.currentState!.validate()) {
        Item item = Item(
            imgPath: basename(_image!.path),
            itemName: _itemNameController.text,
            itemAmount: dropdownValue,
            itemCategory: dropdownValue0,
            itemDescription: _itemDesController.text,
            itemPrice: double.parse(_itemPriceController.text));
        uploadFile();
        return await ItemService.editItem(item, widget.itemDTO!.itemId);
      } else {
        return false;
      }
    } else {
       if (_formKey.currentState!.validate()) {
        Item item = Item(
            imgPath: widget.itemDTO!.imgPath,
            itemName: _itemNameController.text,
            itemAmount: dropdownValue,
            itemCategory: dropdownValue0,
            itemDescription: _itemDesController.text,
            itemPrice: double.parse(_itemPriceController.text));
        uploadFile();
        return await ItemService.editItem(item, widget.itemDTO!.itemId);
      } else {
        return false;
      }
    }
  }

  Future<bool> deleteItem() async{
    return await ItemService.deleteItem(widget.itemDTO!.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: kPrimaryColor,
        actions: (widget.title != "Edit Item"? <Widget>[
          IconButton(
            onPressed: () async {
              String result = await addItem();
              if (result != "") {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.done),
          )
        ]: <Widget>[
                    IconButton(
            onPressed: () async {
              bool result = await deleteItem();
              if (result) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () async {
              bool result = await editItem();
              if (result) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.done),
          )
        ]
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Item name',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(
                controller: _itemNameController,
                validator: _mandatoryValidator,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Item price (per unit)',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(
                controller: _itemPriceController,
                validator: _mandatoryValidator,
                keyboardType: TextInputType.number,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Item description',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(
                controller: _itemDesController,
                validator: _mandatoryValidator,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Select category',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue0,
                elevation: 16,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                onChanged: (String? newValue) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    dropdownValue0 = newValue!;
                  });
                },
                items: (categoryStringList).map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
                items: (<String>[
                  "None",
                  "100g",
                  "200g",
                  "500g",
                  "1Kg",
                  "100mL",
                  "200mL",
                  "500mL",
                  "1L"
                ]).map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 10),
                child: Text(
                  'Select item image',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Container(
                color: kSecondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _image != null
                          ? SizedBox(
                              width: 160,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(_image!, fit: BoxFit.fill,),
                              ))
                          : SizedBox(
                              width: 160,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(_imgURL, fit: BoxFit.fill,),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(right: 32.0, bottom: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                color: kPrimaryColor,
                                icon: const Icon(
                                  Icons.add_photo_alternate,
                                  size: 35,
                                ),
                                onPressed: () async {
                                  await pickImage();
                                }),
                            IconButton(
                                color: kPrimaryColor,
                                icon: const Icon(Icons.add_a_photo, size: 35),
                                onPressed: () {
                                  pickImageC();
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
