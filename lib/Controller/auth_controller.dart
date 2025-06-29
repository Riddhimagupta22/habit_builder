import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Services/AuthService/auth_service.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final LoginformKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final PhoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();

  final isLoading = false.obs;

  final authService = AuthService();

  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Enter a 10-digit phone number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) return 'Please enter an Email';
    RegExp emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailExp.hasMatch(value)) {
      return null;
    }
    {
      return 'Please enter a valid Email';
    }
  }

  Future<void> submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      final data = {
        "username": userNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": PasswordController.text,
        "Phone Number": PhoneNumberController.text,
      };
      await authService.CreateUser(data, context);
      isLoading.value = false;
    }
  }

  Future<void> submitLoginForm(BuildContext context) async {
    if (LoginformKey.currentState!.validate()) {
      isLoading.value = true;
      final data = {
        "email": emailController.text.trim(),
        "password": PasswordController.text,
        "username": userNameController.text.trim(),
      };
      await authService.login(data, context);
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    userNameController.dispose();
    PhoneNumberController.dispose();
    emailController.dispose();
    PasswordController.dispose();
    super.onClose();
  }
}
