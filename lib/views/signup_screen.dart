import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/input_decorations.dart';
import '../viewmodels/auth_view_model.dart';
import '../widgets/common_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedCountry;
  String? _selectedGender;
  String? signUpError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthViewModel>(context, listen: false).fetchCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
        shadowColor: AppColors.shadow,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField("First Name", _firstNameController),
              SizedBox(height: 12.h),
              buildTextField("Last Name", _lastNameController),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Male", style: TextStyle(fontSize: 14.sp)),
                      value: "Male",
                      groupValue: _selectedGender,
                      onChanged: (val) => setState(() => _selectedGender = val),
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Female", style: TextStyle(fontSize: 14.sp)),
                      value: "Female",
                      groupValue: _selectedGender,
                      onChanged: (val) => setState(() => _selectedGender = val),
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              buildTextField(
                "Mobile No",
                _mobileController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 12.h),
              buildTextField(
                "Email",
                _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final emailRegex = RegExp(
                    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                  );
                  if (!emailRegex.hasMatch(val)) return "Enter a valid email";
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: AppInputDecorations.field(
                  hintText: "Select Country",
                ),
                value: _selectedCountry,
                items:
                    viewModel.countries
                        .map(
                          (country) => DropdownMenuItem(
                            value: country,
                            child: Text(
                              country,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (val) => setState(() => _selectedCountry = val),
                validator: (val) => val == null ? "Select a country" : null,
              ),
              SizedBox(height: 12.h),
              buildTextField(
                "Password",
                _passwordController,
                obscureText: true,
                validator: (val) {
                  final pattern =
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[-!@#$%^&*+])[A-Za-z\d\-!@#$%^&*+]{8,30}$';
                  if (!RegExp(pattern).hasMatch(val!)) {
                    return "Password must be strong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              buildTextField(
                "Confirm Password",
                _confirmPasswordController,
                obscureText: true,
                validator:
                    (val) =>
                        val != _passwordController.text
                            ? "Passwords do not match"
                            : null,
              ),
              SizedBox(height: 12.h),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Agree with Terms & Conditions"),
                value: viewModel.agreed,
                onChanged:
                    (val) => setState(() => viewModel.agreed = val ?? false),
              ),
              if (signUpError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    signUpError!,
                    style: TextStyle(color: AppColors.red, fontSize: 14.sp),
                  ),
                ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    viewModel.signUpPassword = _passwordController.text;
                    viewModel.confirmPassword = _confirmPasswordController.text;

                    viewModel.setUser(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      gender: _selectedGender ?? '',
                      mobile: _mobileController.text,
                      email: _emailController.text,
                      country: _selectedCountry ?? '',
                    );

                    final errorMsg = viewModel.validateSignUp();
                    setState(() {
                      signUpError = errorMsg;
                    });

                    if (errorMsg != null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(errorMsg)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Registered Successfully"),
                        ),
                      );
                      Navigator.pop(context);
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
                    height: 50.h,
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16.sp, color: AppColors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
