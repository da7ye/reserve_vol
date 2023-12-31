import 'package:get/get.dart';
import 'package:reserve_vol/m/vols.dart';


class volsController extends GetxController {
  List<Vols> vols = [];
  var isLoading = true.obs;

  setIsLoadingVols(bool newValue) {
    isLoading.value = newValue;
  }

  addVols(Vols vol) {
    vols.add(vol);
  }

}