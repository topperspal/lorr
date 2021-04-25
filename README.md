<p align="center">
  <img src="https://raw.githubusercontent.com/topperspal/lorr/main/logo/lorr.png?sanitize=true" width="400px">
</p>
<h1 align="center">L or R == LEFT  or RIGHT</h1>
<h3 align="center">L or R == ERROR or SUCCESS</h3>
<h2 align="center">Simple & Lightweight Error Handling Solution</h2>

## Features

- Cross platform: mobile, desktop, browser
- No dependencies ( No even flutter )
- JUST 15 lines of code

## Why LorR

Developers are awesome, they write good apps for people to make their life happier and easier. Sounds good! But even the best apps in market need to handle error. Therefore developers always seek for simple error handling solutions.<br><br>

> LorR helps you to cache an error as soon as possible and return it along with the result( User, message, data etc.)

## Usages

Here is how `LorR` Works

Consider an async function `Future login(String email, String password)` that will try to login. Here if user successfully gets logged in, the function will obviously return `User`. But there

Now consider you want to login in the app, so your function will be some kind of -

```dart
Future<dynamic> login(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return result.user;
    } catch (error) {
      return error;
    }
}
```

but there is problem with this type of approach, This is neither compile-safe nor predictive. In a big project, you will definately get into trouble finding the return type of the function.

Here `LorR` comes to rescue you. The same function can be written using `LorR` -

```dart
Future<LorR<AppError, User>> login(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Add a null check (!) after user because LorR will always single value either left() or right() and the second will be null
      // Here if we don't get any error, the result will definately provide user and user will not be null
      // by adding null check operator (!) we are telling the compiler that result.user is not null
      return right(result.user!);
    } catch (error) {
      // Here we don't need a null check because compiler is happy with new AppError Obj
      return left(AppError(error: "Some error occured while loggin in!"));
    }
  }

```

> Always return data using `right()` and error using `left()` just for convention

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

> If `LorR` makes a smile on your face, I'll be happy
