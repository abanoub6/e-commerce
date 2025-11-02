import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/dependency-injection/service_locator.dart';
import 'package:e_commerce_app/core/utils/ui_utiles.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/cubit/home_cubit_states.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/category_item.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/fading_image_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    homeCubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => homeCubit,
      child: BlocListener<HomeCubit, HomeCubitStates>(
        listener: (context, state) {
          if (state is ErrorHomeState) {
            UIUtiles.showMessage(state.errorMessage);
          }
        },
        child: Scaffold(
          backgroundColor: AppTheme.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🏷️ Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ShopZone 🛍️",
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: AppTheme.primaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  /// 🔍 Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Search for products...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppTheme.primaryColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// 🖼️ Slider
                  const FadingImageSlider(),

                  const SizedBox(height: 25),

                  /// 🧩 Categories Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  BlocBuilder<HomeCubit, HomeCubitStates>(
                    builder: (context, state) {
                      final isLoading = state is LoadingHomeState;

                      return Skeletonizer(
                        enabled: isLoading,
                        child: SizedBox(
                          height:
                              300, // ✅ زودناها من 240 إلى 300 لتفادي الـ overflow
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(bottom: 10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  mainAxisExtent: 140,
                                ),
                            itemCount:
                                state is SuccessHomeState
                                    ? state.categories.length
                                    : 6,
                            itemBuilder: (context, index) {
                              if (state is SuccessHomeState) {
                                return CategoryItem(
                                  categoryEntity: state.categories[index],
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
