import 'package:pull_to_refresh/pull_to_refresh.dart';

extension RefreshControllerExt on RefreshController {
  ///统一上拉下拉api，调一个就行了
  void refreshAndLoadCompleted() {
    refreshCompleted(resetFooterState: true);
    loadComplete();
  }
}
