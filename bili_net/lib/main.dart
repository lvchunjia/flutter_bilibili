import 'package:bili_net/http/core/hi_error.dart';
import 'package:flutter/material.dart';

import 'http/dao/login_dao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    // TestRequest request = TestRequest();
    // request.add("aa", "ddd").add("bb", "333").add("requestPrams", "kkkk");
    //
    // try {
    //   var response = await HiNet.getInstance().fire(request);
    //   print(response);
    // } on NeedAuth catch (e) {
    //   print(e);
    // } on NeedLogin catch (e) {
    //   print(e);
    // } on HiNetError catch (e) {
    //   print(e);
    // } catch (e) {
    //   print(e);
    // }

    testLogin();
  }

  void testLogin() async {
    try {
      var result = await LoginDao.registration(
        '17864182410',
        '123456',
        '11187977',
        '9516',
      );
      // var result2 = await LoginDao.login('用户名', '密码');
      // print(result2);
      print("registrationResult: $result");
    } on NeedAuth catch (e) {
      print("NeedAuth: $e");
    } on HiNetError catch (e) {
      print("HiNetError: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
