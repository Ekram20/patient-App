
String? validateEmail(String? email)
{
  RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValidate = emailRegex.hasMatch(email ?? '');
  if(!isEmailValidate ) {
    return ' Please enter your email Correctly';
  }
  return null;
}