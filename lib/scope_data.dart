import 'package:googlemapdemo/database.dart';
import 'package:scoped_model/scoped_model.dart';

class DataFetch extends Model {
  List<LocationData> locationData = [];

  void addData(LocationData location) {
    DatabaseHelper.instance.add(location);
    allData();
  }

  void delete(int id) {
    DatabaseHelper.instance.delete(id);
    allData();
  }

  allData() async {
    locationData = await DatabaseHelper.instance.getData();
    notifyListeners();
  }
}