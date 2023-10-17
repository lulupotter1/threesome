import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:threescreens/features/weather_screen/presentation/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

@RoutePage()
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController textController = TextEditingController();
  TextEditingController obscureController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Uint8List? selectedImage;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "First Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomTextField(
                controller: textController,
                labelTitle: "text",
                hintText: "text",
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: obscureController,
                      labelTitle: "obscure",
                      hintText: "obscure",
                      isObscure: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      controller: numberController,
                      labelTitle: "number",
                      keyboardType: TextInputType.number,
                      hintText: "number",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: dateController,
                      labelTitle: "date",
                      hintText: "date",
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      } else {}
                    },
                    child: const Text(
                      "Select Date",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      _takeImage(ImageSource.gallery, context);
                    },
                    child: const Text(
                      "Select Image",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (selectedImage != null) {
                        setState(() {
                          selectedImage = null;
                        });
                      }
                    },
                    child: const Text(
                      "Delete Image",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              if (selectedImage != null) ...[
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                    image: DecorationImage(
                      image: MemoryImage(selectedImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && selectedImage != null) {
                      const snackBar = SnackBar(
                        content: Text("All correct"),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      const snackBar = SnackBar(
                        content: Text("Some field are empty or image wasnt selected"),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(fontSize: 20),
                  )),
              const Spacer(),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).replaceNamed("/calculatorScreen");
                },
                child: const Text(
                  "Calculator Screen",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  Future _takeImage(ImageSource type, BuildContext context) async {
    PermissionStatus camera = await Permission.camera.request();
    bool isGranted = camera == PermissionStatus.granted;
    if (isGranted) {
      var image = await ImagePicker().pickImage(source: type);
      if (image != null) {
        File imageFile = File(image.path);
        Uint8List imageRaw = imageFile.readAsBytesSync();
        selectedImage = imageRaw;
        setState(() {});
      } else {
        const snackBar = SnackBar(
          content: Text("Uncorrect image"),
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(
        content: Text("No Permission"),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
