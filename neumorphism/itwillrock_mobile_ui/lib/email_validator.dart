/// A collection of validators for form fields.
class Validators {
  /// Validates an email address.
  ///
  /// Returns an error message if the email is invalid, otherwise returns null.
  ///
  /// [email] The email address to validate.
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
