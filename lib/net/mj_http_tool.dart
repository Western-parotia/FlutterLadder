import 'api.dart';
import 'httpV2.dart';

class MJHttpTool {
    // String url = "";
    // Map param= {};
    // MJHttpTool({required String url}) {
    //     this.url = url;
    // }
    // 请求数据的方法
    void getRequestData(String url,RequestSuccess success,RequestFailure failure,RequestDone done) {
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

    void postRequestData (String url,Map<String,dynamic>  param,RequestSuccess success,RequestFailure failure,RequestDone done) {
        Map<String,dynamic> requestParam = {};
        if (param != null) {
            requestParam = param!;
        }
        Future future = Http.instance.post(url,params: requestParam);
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
    void postFormRequestData (String url,Map<String,dynamic>  param,RequestSuccess success,RequestFailure failure,RequestDone done) {
        Map<String,dynamic> requestParam = {};
        if (param != null) {
            requestParam = param!;
        }
       // Future future = Http.instance.postForm(url,params: requestParam);
        Future future = Http.instance.postForm(url, requestParam);
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