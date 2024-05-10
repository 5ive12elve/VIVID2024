class SignUpWithEmailAndPasswordFailure {
  final String message;

  SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occurred."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure('Please enter a stronger password.');
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure('Email is not valid.');
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure('The email address is already in use by another account.');
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}
