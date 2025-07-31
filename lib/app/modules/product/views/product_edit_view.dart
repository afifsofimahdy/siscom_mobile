import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siscom_mobile/app/modules/product/controllers/product_edit_controller.dart';

class ProductEditView extends GetView<ProductEditController> {
  const ProductEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoadingCategories.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final numericValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
                      if (numericValue.isEmpty) return newValue;
                      final number = int.parse(numericValue);
                      final formatter = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      );
                      final result = formatter.format(number);
                      
                      return TextEditingValue(
                        text: result,
                        selection: TextSelection.collapsed(offset: result.length),
                      );
                    }),
                  ],
                  controller: controller.priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                    if (numericValue.isEmpty || int.tryParse(numericValue) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.stockController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter stock';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.imageController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter image URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(() => DropdownButtonFormField<int>(
                  value: controller.selectedCategoryId.value == 0 ? null : controller.selectedCategoryId.value,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: controller.categories.map((category) {
                    return DropdownMenuItem<int>(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedCategoryId.value = value ?? 0;
                  },
                  validator: (value) {
                    if (value == null || value == 0) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                )),
                const SizedBox(height: 16),
                Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedGroupItem.value.isEmpty ? null : controller.selectedGroupItem.value,
                  decoration: const InputDecoration(
                    labelText: 'Group Item',
                    border: OutlineInputBorder(),
                  ),
                  items: controller.groupItems.map<DropdownMenuItem<String>>((group) {
                    return DropdownMenuItem<String>(
                      value: group,
                      child: Text(group),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedGroupItem.value = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a group';
                    }
                    return null;
                  },
                )),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.saveProduct,
                    child: const Text('Save Product'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
