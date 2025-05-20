import 'package:flutter/material.dart';
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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          padding: const EdgeInsets.all(24),
                          child: const Icon(
                            Icons.android,
                            size: 100,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Hi, ${viewModel.username}!",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Welcome to Home Screen",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                      ],
                    ),
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
