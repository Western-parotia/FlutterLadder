import 'api.dart';
import 'httpV2.dart';

class MJHttpTool {
    String url = "";
    //int page = 0;

    MJHttpTool({required String url}) {
        this.url = url;
    }
    // 请求数据的方法
    void requestData(RequestSuccess success,RequestFailure failure,RequestDone done) {
        Future future = Http.instance.get(url);
        future.then((value) {
            success(value.toString());
        }).onError((error, stackTrace) {
            print(error);
            print(stackTrace);
            if (failure != null) {
                failure(error);
            }
        }).whenComplete(() {
            if (done != null) {
                done();
            }
        });
    }
}

typedef RequestSuccess = Function(dynamic value);
typedef RequestFailure = Function(dynamic value);
typedef RequestDone = Function();