import 'package:flutter/foundation.dart' as foundation;
import 'package:gorouter_auth/core/error/exceptions.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gorouter_auth/features/auth/data/data_source/auth_local_datasource.dart';

import '../../domain/entity/auth.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  final _kAuthBox = 'auth_box';

  @override
  Future<bool> initDb() async{
    try {
      if (!foundation.kIsWeb) {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
      }
      Hive.registerAdapter(AuthAdapter());
      await Hive.openBox<Auth>(_kAuthBox);
      return true;
    } catch (_) {
      throw ConnectionException();
    }
  }

  @override
  Future<bool> signIn() async {
    try{
      final authBox = Hive.box<Auth>(_kAuthBox);
      final convertedTask = Auth(isLoggedIn: true);
      await authBox.add(convertedTask);
      return Future.value(true);
    } catch (_) {
      throw ConnectionException();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try{
      final taskBox = Hive.box<Auth>(_kAuthBox);
      return taskBox.values.first.isLoggedIn;
    }
    catch(_) {
      throw ConnectionException();
    }
  }

}