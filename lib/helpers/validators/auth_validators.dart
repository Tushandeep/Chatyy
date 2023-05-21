import '../typedef/typedef.dart';

AuthFormValidator emailValidator = (val) {
  if (val!.isEmpty || !val.contains('@')) {
    return 'Please valid email address';
  }
  return null;
};

AuthFormValidator usernameValidator = (val) {
  if (val!.isEmpty) {
    return 'Empty Username Not Valid';
  }
  if (val.length <= 3) {
    return 'Username must be atleast 4 characters long';
  }
  if (val.length >= 20) {
    return 'Username length exceeded';
  }
  return null;
};

AuthFormValidator passwordValidator = (val) {
  if (val!.isEmpty || val.length < 7) {
    return 'Password must be atleast of 8 characters';
  }
  return null;
};
