import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shopping_app/dto/supplier_dto.dart';
import 'package:shopping_app/model/supplier.dart';
import 'package:shopping_app/services/supplier_service.dart';
import '../../../components/constants.dart';

class AddSupplierScreen extends StatefulWidget {
  final String title;
  final SupplierDTO? supplierDTO;
  const AddSupplierScreen({Key? key, this.title = "", this.supplierDTO})
      : super(key: key);

  @override
  State<AddSupplierScreen> createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  String _imgURL =
      "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=20&m=1222357475&s=170667a&w=0&h=YGycIDbBRAWkZaSvdyUFvotdGfnKhkutJhMOZtIoUKY=";
  String _title = "Add Supplier";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseStorage storage = FirebaseStorage.instance;
  File? _image;

  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _supplierItemController = TextEditingController();
  final TextEditingController _supplierQuantityController = TextEditingController();
  final TextEditingController _supplierAddressController = TextEditingController();

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
      _supplierNameController.text = widget.supplierDTO!.supplierName;
      _supplierItemController.text = widget.supplierDTO!.supplierItem;
      _supplierQuantityController.text = widget.supplierDTO!.supplierQuantity.toString();
      _supplierAddressController.text = widget.supplierDTO!.supplierAddress;


      setImage(widget.supplierDTO!.imgPath);

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

  Future<String> addSupplier() async {
    if (_image != null) {
      if (_formKey.currentState!.validate()) {
        Supplier supplier = Supplier(
            imgPath: basename(_image!.path),
            supplierName: _supplierNameController.text,
            supplierAddress: _supplierAddressController.text,
            supplierItem: _supplierItemController.text,
            supplierQuantity: _supplierQuantityController.text);
        uploadFile();
        return await SupplierService.addSupplier(supplier);
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  Future<bool> editSupplier() async {
    if (_image != null) {
      if (_formKey.currentState!.validate()) {
        Supplier supplier = Supplier(
            imgPath: basename(_image!.path),
            supplierName: _supplierNameController.text,
            supplierAddress: _supplierAddressController.text,
            supplierItem: _supplierItemController.text,
            supplierQuantity: _supplierQuantityController.text);
        uploadFile();
        return await SupplierService.editSupplier(supplier, widget.supplierDTO!.supplierId);
      } else {
        return false;
      }
    } else {
       if (_formKey.currentState!.validate()) {
        Supplier supplier = Supplier(
            imgPath: widget.supplierDTO!.imgPath,
            supplierName: _supplierNameController.text,
            supplierAddress: _supplierAddressController.text,
            supplierItem: _supplierItemController.text,
            supplierQuantity: _supplierQuantityController.text);
        uploadFile();
        return await SupplierService.editSupplier(supplier, widget.supplierDTO!.supplierId);
      } else {
        return false;
      }
    }
  }

  Future<bool> deleteSupplier() async{
    return await SupplierService.deleteSupplier(widget.supplierDTO!.supplierId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: kPrimaryColor,
        actions: (widget.title != "Edit Supplier"? <Widget>[
          IconButton(
            onPressed: () async {
              String result = await addSupplier();
              if (result != "") {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.done),
          )
        ]: <Widget>[
                    IconButton(
            onPressed: () async {
              bool result = await deleteSupplier();
              if (result) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () async {
              bool result = await editSupplier();
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
                  'Supplier name',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(
                controller: _supplierNameController,
                validator: _mandatoryValidator,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Supplier address',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(
                controller: _supplierAddressController,
                validator: _mandatoryValidator,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Supplier Item',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(
                controller: _supplierItemController,
                validator: _mandatoryValidator,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Supplier Quantity',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(
                controller: _supplierQuantityController,
                validator: _mandatoryValidator,
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
