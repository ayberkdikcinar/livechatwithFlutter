class FB_Error {
  static String? getError(String error) {
    String _err;
    switch (error) {
      case 'email-already-in-use':
        _err = 'E-mail is already in use';
        break;
      case 'unknown':
        _err = 'Fields can not be empty';
        break;
      case 'invalid-email':
        _err = 'Check your email';
        break;
      case 'wrong-password':
        _err = 'Check your password';
        break;
      default:
        _err = 'An error has been occurred';
    }
    return _err;
  }
}
