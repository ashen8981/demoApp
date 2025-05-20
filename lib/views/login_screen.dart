import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../viewmodels/auth_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gradient background
          Container(
            height: 260.h,
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
          ),

          // Main form container
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  // Top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: AppColors.white),
                        onPressed: () => SystemNavigator.pop(),
                      ),
                      Row(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap:
                                () => Navigator.pushNamed(context, '/signup'),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 40.h),
                  // Login Form
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "Enter your details below",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          buildTextField(
                            "Username",
                            _userController,
                            suffixIcon: const Icon(Icons.person_2),
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter username'
                                        : null,
                          ),

                          SizedBox(height: 16.h),
                          buildTextField(
                            "Password",
                            _passController,
                            obscureText: _obscureText,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed:
                                  () => setState(
                                    () => _obscureText = !_obscureText,
                                  ),
                            ),
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter password'
                                        : null,
                          ),

                          if (viewModel.error != null)
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Text(
                                viewModel.error!,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),

                          SizedBox(height: 10.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/reset');
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Sign In Button
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  viewModel.loginUsername =
                                      _userController.text;
                                  viewModel.loginPassword =
                                      _passController.text;
                                  if (await viewModel.validateLogin()) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/home',
                                    );
                                  } else {
                                    setState(() {});
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
