import 'package:get_it/get_it.dart';
import 'package:livechat/services/firestore_db_service.dart';

import '../../services/firebase_auth.dart';
import '../../services/repository.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => FirebaseAuthentication());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDBService());
}
