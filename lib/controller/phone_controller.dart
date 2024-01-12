import 'package:get/get.dart';

class PhoneAuthController extends GetxController {
  Rx<String> phoneNumber = ''.obs;
  Rx<bool> isButtonEnabled = false.obs;
  Rx<bool> isCheckboxChecked = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void validatePhoneNumber(String value) {
    phoneNumber.value = value;
    if (phoneNumber.value.length == 10 && isCheckboxChecked.value) {
      isButtonEnabled.value = true;
      updateButtonStatus();
    } else {
      isButtonEnabled.value = false;
    }
  }

  void toggleCheckbox(bool? value) {
    isCheckboxChecked.value = value ?? false;
    validatePhoneNumber(phoneNumber.value);
    updateButtonStatus();
  }

  void updateButtonStatus() {
    isButtonEnabled.value = phoneNumber.value.length == 10 && isCheckboxChecked.value;
  }

}
