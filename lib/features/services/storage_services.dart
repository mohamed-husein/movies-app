import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/utils/app_constants.dart';

class StorageServices extends GetxService {
  late GetStorage _box;
  Future<StorageServices> init() async {
    _box = GetStorage();
    _box.writeIfNull(AppConstance.favKey, []);
    return this;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  Future<void> remove() async {
    await _box.remove(AppConstance.favKey);
  }
}
