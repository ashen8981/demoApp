import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child: Builder(
        builder: (context) {
          final viewModel = Provider.of<HomeViewModel>(context, listen: false);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Home",
                style: TextStyle(color: AppColors.white),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.white),
                onPressed: () => viewModel.exitApp(context),
              ),
              centerTitle: true,
              backgroundColor: AppColors.primary,
              elevation: 4,
              shadowColor: AppColors.shadow,
            ),
            body: Consumer<HomeViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.username == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 14.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${viewModel.username}!",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        children: [
                          // Company icon
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.ac_unit,
                              size: 20.w,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Search bar
                          Expanded(
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search...',
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // 3-dot menu icon
                          IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: AppColors.primary,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 88.h),
                      Center(
                        child: Text(
                          "Welcome to Home Screen",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
