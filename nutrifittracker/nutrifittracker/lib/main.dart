import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrifittracker/bloc/auth_bloc.dart';
import 'package:nutrifittracker/bloc/auth_event.dart';
import 'package:nutrifittracker/bloc/firebase_auth_provider.dart';
import 'package:nutrifittracker/bloc/auth_state.dart';
import 'package:nutrifittracker/bloc/meal/meal_bloc.dart';
import 'package:nutrifittracker/bloc/meal/meal_cloud_storge.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_bloc.dart';
import 'package:nutrifittracker/bloc/userMeals/user_meal_cloud_storage.dart';
import 'package:nutrifittracker/body/bloc/body_bloc.dart';
import 'package:nutrifittracker/body/bloc/body_cloud_storage.dart';
import 'package:nutrifittracker/body/views/body_view.dart';
import 'package:nutrifittracker/constants/routes.dart';
import 'package:nutrifittracker/views/activity_track_view.dart';
import 'package:nutrifittracker/views/category_view.dart';
import 'package:nutrifittracker/views/define_goal_view.dart';
import 'package:nutrifittracker/views/login/login_view.dart';
import 'package:nutrifittracker/views/nutrition/meal_entry_view.dart';
import 'package:nutrifittracker/views/nutrition_detail_view.dart';
import 'package:nutrifittracker/views/nutrition_track_view.dart';
import 'package:nutrifittracker/views/personal_health_info_view.dart';
import 'package:nutrifittracker/views/profile_view.dart';
import 'package:nutrifittracker/views/settings/profile_settings_view.dart';
import 'package:nutrifittracker/views/signup/gender_question_view.dart';
import 'package:nutrifittracker/views/signup/signup_view.dart';
import 'package:nutrifittracker/views/tab_bar.dart';
import 'package:nutrifittracker/views/workout_history_view.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            FirebaseAuthProvider(),
          ),
        ),
        BlocProvider(
          create: (context) => MealBloc(
            mealCloudStorage: MealCloudStorge(),
          ),
        ),
        BlocProvider(
          create: (context) => UserMealsBloc(
            UserMealCloudStorage(),
          ),
        ),
        BlocProvider(
          create: (context) => BodyBloc(
            BodyCloudStorage(),
          ),
        ),

        // Add other providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProviderScope(child: HomePage()),
      routes: {
        loginRoute: (context) => const LoginView(),
        signupRoute: (context) => const GenderQuestionView(),
        categoryRoute: (context) => const CategoryView(),
        defineExerciseGoalRoute: (context) => const DefineGoalView(),
        personalHealthInfoRoute: (context) => const PersonalHealthInfoView(),
        userProfileRpute: (context) => const ProfileView(),
        mainRoute: (context) => const MainScreen(),
        workoutHistoryRoute: (context) => const WorkoutHistoryView(),
        activityTrackingRoute: (context) => ActivityListView(),
        nutritionTrackRoute: (context) => const NutritionTrackView(),
        nutritionDetailRoute: (context) => const NutritionDetailView(),
        profileSetttingsRoute: (context) => const ProfileSettingsView(),
        addNewMealRoute: (context) => const MealEntryView(),
        myBodyRoute: (context) => const BodyView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const SignupView();
        } else if (state is AuthStateLoggedIn) {
          return const MainScreen();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
