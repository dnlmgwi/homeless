import 'package:homeless/packages.dart';
import 'package:intl/intl.dart';

class PathProvider {
  String filePath;
  static var now = DateTime.now();
  var newNow = DateFormat("yyyy-MM-dd").format(now);

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.absolute.path;
  }

  Future<File> get localFile async {
    final path = await _localPath;
    filePath = '$path/data$newNow.csv';
    return File('$path/data$newNow.csv').create();
  }
}
