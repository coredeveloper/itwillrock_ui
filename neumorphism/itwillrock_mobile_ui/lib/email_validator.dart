///Validators collection class
///
///Only static classes which used in controls are implemented here.
class Validators {
  ///Email address validation helper method
  static String? validateEmail(String? email) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (email != null && !regex.hasMatch(email)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }
}
