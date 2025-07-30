import 'package:demo_orientation_builder/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:demo_orientation_builder/screens/product_list.dart';

GoRouter appRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: 'products',
            builder: (context, state) => const MyProductList(),
          ),
          GoRoute(
            path: 'books',
            builder: (context, state) => const Placeholder(), // Placeholder for books page
          ),
        ],
      ),
    ],
  );
}
