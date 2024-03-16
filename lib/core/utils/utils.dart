import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static Future<void> showToast(String message) async =>
      await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
      );
}
