import 'dart:io';
import 'package:flutter/material.dart';
//all product
final TextEditingController nameController = TextEditingController(),
    detailsController = TextEditingController(),
    costFirstDayController = TextEditingController(),
    costPerExtraDayController = TextEditingController(),
    costPerHourController = TextEditingController(),
    sellPriceController = TextEditingController(),
    originalPriceController = TextEditingController(),
    conditionController = TextEditingController();
final List<File> selectedImages = [];
//unique
final TextEditingController bookAuthorController = TextEditingController();
final List<String> selectedGenres = [];
final TextEditingController bikeBrandController = TextEditingController();
final TextEditingController bikeModelController = TextEditingController();

void clearAll() {
  nameController.clear();
  detailsController.clear();
  costFirstDayController.clear();
  costPerExtraDayController.clear();
  costPerHourController.clear();
  sellPriceController.clear();
  originalPriceController.clear();
  selectedImages.clear();
}
void clearBookProduct() {
  clearAll();
  bookAuthorController.clear();
  selectedGenres.clear();
}
void clearBikeProduct() {
  clearAll();
  bikeBrandController.clear();
  bikeModelController.clear();
}


