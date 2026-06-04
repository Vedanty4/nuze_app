import 'dart:io';

import 'package:nuze_app/core/error/exception.dart';
import 'package:nuze_app/core/error/failure.dart';
import 'package:nuze_app/core/utils/result.dart';

mixin ApiRunner {
  Future<Result<T>> runApiTask<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();

      return Success(result);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } on SocketException {
      return Error(OfflineFailure());
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }
}
