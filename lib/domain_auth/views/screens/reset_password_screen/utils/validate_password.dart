String? validatePassword(String? password) {
  if (password == null) {
    return "Password cannot be empty";
  }
  if (password.length < 8) {
    return "Password must contains at least 8 characters";
  }
  return null;
}
