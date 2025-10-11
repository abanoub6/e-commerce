import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/dependency-injection/service_locator.dart';
import 'package:e_commerce_app/core/utils/ui_utiles.dart';
import 'package:e_commerce_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/cubit/home_cubit_states.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/category_item.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/fading_image_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = serviceLocator.get<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit,
      child: BlocListener<HomeCubit, HomeCubitStates>(
        listener: (context, state) {
          if (state is LoadingHomeState) {
            CircularProgressIndicator();
          } else if (state is ErrorHomeState) {
            UiUtiles.showMessage(context, state.errorMessage);
          }
        },
        child: Scaffold(
          backgroundColor: AppTheme.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Route",
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "What do you search for?",
                            hintStyle: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 18,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 12,
                              ),
                              child: Icon(
                                Icons.search,
                                color: AppTheme.primaryColor,
                                size: 28,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                              borderSide: BorderSide(
                                color: AppTheme.secondaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: AppTheme.primaryColor,
                      size: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const FadingImageSlider(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeCubitStates>(
                    builder: (context, state) {
                      if (state is SuccessHomeState) {
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 115,
                              ),
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return CategoryItem(
                              categoryEntity: state.categories[index],
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
