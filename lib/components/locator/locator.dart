import 'package:get_it/get_it.dart';

import '../../services/firebase_auth.dart';
import '../../services/firebase_storage_service.dart';
import '../../services/firestore_db_service.dart';
import '../../services/user_repository.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => FirebaseAuthentication());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => FirebaseStorageService());
}
