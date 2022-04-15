// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(App());

/// The main app.
class App extends StatelessWidget {
  /// Creates an [App].
  App({Key? key}) : super(key: key);

  /// The title of the app.
  static const String title = 'GoRouter Example: Push Async and Pop with Result';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
      );

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const Page1ScreenWithPushAsync(),
      ),
      GoRoute(
        path: '/page2',
        builder: (BuildContext context, GoRouterState state) => const Page2ScreenWithPopResult(),
      ),
    ],
  );
}

/// The screen of the first page.
class Page1ScreenWithPushAsync extends StatefulWidget {
  /// Creates a [Page1ScreenWithPushAsync].
  const Page1ScreenWithPushAsync({Key? key}) : super(key: key);

  @override
  State<Page1ScreenWithPushAsync> createState() => _Page1ScreenWithPushAsyncState();
}

class _Page1ScreenWithPushAsyncState extends State<Page1ScreenWithPushAsync> {

  dynamic result;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('${App.title}: page 1')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Result: $result'),
              ElevatedButton(
                onPressed: () async {
                  result = await context.pushAsync('/page2');
                  setState(() {});
                },
                child: const Text('Push page 2'),
              ),
            ],
          ),
        ),
      );
}

/// The screen of the second page.
class Page2ScreenWithPopResult extends StatelessWidget {
  /// Creates a [Page2ScreenWithPopResult].
  const Page2ScreenWithPopResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('${App.title}: page 2 pop result'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () => context.pop({'name':'John','email': 'john@example.com'}),
                  child: const Text('Pop home page'),
                ),
              ),
            ],
          ),
        ),
      );
}
