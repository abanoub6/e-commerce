abstract class AppExepetions implements Exception {
  final String message;
  AppExepetions(this.message);
}

class LocalExeption extends AppExepetions {
  LocalExeption(super.message);
}

class RemoteExeption extends AppExepetions {
  RemoteExeption(super.message);
}
