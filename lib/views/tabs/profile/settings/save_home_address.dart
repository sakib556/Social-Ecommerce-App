import 'package:flutter/material.dart';

import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';

class SaveHomeAddress extends StatelessWidget {
  final Function(String house, String street, String area, BuildContext context)
      onSave;
  final String house;
  final String street;
  final String area;
  const SaveHomeAddress({
    Key? key,
    required this.onSave,
    this.house = "",
    this.street = "",
    this.area = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _houseNumberController = TextEditingController();
    final _streetController = TextEditingController();
    final _areaController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    _streetController.text = street;
    _houseNumberController.text = house;
    _areaController.text = area;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height - 120,
                child: Form(
                  // key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Home Address",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(height: 48),
                      TextFormField(
                        initialValue: house,
                        autofocus: true,
                        onChanged: (value) {
                          _houseNumberController.text=value;
                        } ,
                        // validator: (value) {
                        //   if (value==null) {
                        //     return "House number is required";
                        //   }
                        //   return null;
                        // },
                        decoration: const InputDecoration(
                            labelText: "House number, Apt",
                            hintText: "house 175, apt A2"),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: street,
                        onChanged: (value) {
                          _streetController.text=value;
                        } ,
                        // validator: (value) {
                        //   if (value==null) {
                        //     return "Street is required";
                        //   }
                        //   return null;
                        // },
                        decoration: const InputDecoration(
                            labelText: "Road, Block",
                            hintText: "Block I, road 9"),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: area,
                        onChanged: (value) {
                          _areaController.text=value;
                        } ,
                        // validator: (value) {
                        //   if (value==null) {
                        //     return "Area is required";
                        //   }
                        //   return null;
                        // },
                        decoration: const InputDecoration(
                            labelText: "Area", hintText: "Bashundhara R/A"),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: house.isEmpty ? "Next" : "Submit",
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                  onSave(_houseNumberController.text, _streetController.text,
                      _areaController.text, context);
             //   }
              },
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
