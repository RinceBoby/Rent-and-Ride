import 'package:get/get.dart';

//<<<<<SnackBar>>>>>//
getSnackBar(String value) {
  print(value);
  Get
    ..closeAllSnackbars()
    ..showSnackbar(
      GetSnackBar(
        borderRadius: 30,
        title: "Warning",
        message: value,
        duration: const Duration(seconds: 3),
      ),
    );
}
