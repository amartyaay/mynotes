//Login
class UserNotFoundAuthException implements Excpetion {}
class WrongPasswordAuthException implements Excpetion {}

//Register
class WeakPasswordAuthException implements Exception{}
class InvalidEmailAuthException implements Excpetion{}
class EmailAlreadyInUseAuthException implements Excpetion{}

//generic exceptions
class GenericAuthException implements Excpetion{}
class UserNotLoggedInAuthException implements Excpetion{}