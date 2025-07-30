import 'package:demo_orientation_builder/screens/revenue_chart.dart';
import 'package:demo_orientation_builder/screens/home_page.dart';
import 'package:demo_orientation_builder/screens/home_screen.dart';
import 'package:demo_orientation_builder/screens/profile_page.dart';
import 'package:demo_orientation_builder/screens/weather_app.dart';
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
            path: 'profile',
            builder: (context, state) => const ProfileScreen(), 
          ),
          GoRoute(
            path: 'productTrung',
            builder: (context, state) => const ProductScreen(), 
          ),
          GoRoute(
            path: 'weather',
            builder: (context, state) => const WeatherHomePage(), 
          ),
          GoRoute(
            path: 'revenue',
            builder: (context, state) => const RevenueDashboard(),
          ),
        ],
      ),
    ],
  );
}
