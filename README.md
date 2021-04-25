<p align="center">
  <img src="https://raw.githubusercontent.com/topperspal/lorr/main/logo/lorr.png?sanitize=true" width="400px">
</p>
<h2 align="center">Simple & Lightweight Error Handling Solution</h2>

## Features

- Cross platform: mobile, desktop, browser
- No dependencies ( No even flutter )
- JUST 15 lines of code

## Example

```dart
import 'package:lorr/lorr.dart';

main() async {
  final result = await login("vickyboss");

  if (result.isLeft)
    print("Failure : ${result.left?.error}");
  else
    print("Success : Logged in as ${result.right?.name}");
}

Future<LorR<AppError, User>> login(String username) async {
  await Future.delayed(Duration(seconds: 2));
  if (username.length < 6) return left(AppError(error: "Invalid Username!"));
  return right(User(name: username));

  // You can implement a try/catch bloc with real login
  // If login success return right(User)
  // If login fails return left(AppError)
}

class User {
  String name;

  User({
    required this.name,
  });
}

class AppError {
  String error;

  AppError({
    required this.error,
  });
}

```
