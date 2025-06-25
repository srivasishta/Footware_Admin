import 'package:flutter/material.dart';
import 'package:footware/controller/home_controller.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../widget/drop_down_button.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ADD Product'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Add New Product',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.indigoAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: ctrl.productNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('Product Name'),
                    hintText: 'Enter Your product Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrl.productDecriptionCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('Description'),
                    hintText: 'Enter Your product Description',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ctrl.productImgCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('Image URL'),
                    hintText: 'Enter Your Image URL',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('Product Price'),
                    hintText: 'Enter Product Price',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropDownButton(
                        items: const ['Boots', 'Shoe', 'Beach Shoes','High heels','Loafers'],
                        selectedItemText: ctrl.category,
                        Onselected: (selectedValue) {
                          ctrl.category = selectedValue ?? 'general';
                          ctrl.update();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropDownButton(
                        items: const ['Puma', 'Nike', 'sketchers','Reebok'],
                        selectedItemText:  ctrl.brand,
                        Onselected: (selectedValue) {
                          ctrl.brand = selectedValue ?? 'un branded';
                          ctrl.update();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Offer Product?'),
                const SizedBox(height: 10),
                DropDownButton(
                  items: const ['True', 'False'],
                  selectedItemText: ctrl.offer.toString(),
                  Onselected: (selectedValue) {
                    ctrl.offer = bool.tryParse(selectedValue ?? 'false') ?? false;
                    ctrl.update();
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  onPressed: () {
                  ctrl.addProduct();
                  },
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}