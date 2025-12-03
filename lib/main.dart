import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/helper/permission_helper.dart';
import 'core/router/app_router.dart';
import 'core/notification/fcm_service.dart';
import 'core/notification/local_notification_service.dart';
import 'core/notification/notification_handler.dart';
import 'data/service/auth_service.dart';
import 'data/service/profile_service.dart';
import 'data/service/vhicle_service.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/profile/profile_bloc.dart';
import 'presentation/bloc/profile/profile_event.dart';
import 'presentation/bloc/add_vhicle/add_vehicle_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotificationService.initLocalNotification();
  await FCMService.initFCM();
  NotificationHandler.setupNotificationListener();
  runApp(const AppProvider());
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthService())),
        BlocProvider(create: (_) => ProfileBloc(ProfileService())..add(FetchProfile()),),
        BlocProvider(create: (_) => VehicleBloc(VhicleService())),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PermissionHelper().ensureLocationPermission();

    return MaterialApp(
      title: 'Serlok Mitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        fontFamily: 'PlusJakartaSans',
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
