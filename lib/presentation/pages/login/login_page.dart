import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/core/theme/app_theme.dart';
import 'package:bus_booking/presentation/pages/login/bloc/login_bloc.dart';
import 'package:bus_booking/presentation/pages/login/bloc/login_state.dart';
import 'package:bus_booking/presentation/widgets/CommonButton/common_button.dart';
import 'package:bus_booking/presentation/widgets/CommonTextField/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: GestureDetector(
        onTap: () => {
          FocusScope.of(context).unfocus(),
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              gradient: Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).loginBackgroundGradient
                  : null,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : null,
            ),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {},
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      const Center(
                        child: Text(
                          "English (US)",
                          style: TextStyle(color: AppColors.textGray),
                        ),
                      ),
                      const SizedBox(height: 121),
                      SvgPicture.asset(
                        "assets/icons/instagram_outline.svg",
                        fit: BoxFit.contain,
                        height: 72,
                        width: 72,
                      ),
                      const SizedBox(height: 121),
                      CommonTextField(
                        controller: emailController,
                        hintText: "Username, email or mobile number",
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      CommonTextField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        hintText: "Password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      CommonButton(
                        text: 'Log In',
                        onPressed: () => {},
                      ),
                      const SizedBox(height: 300),
                      SvgPicture.asset(
                        height: 14,
                        width: 66,
                        "assets/icons/meta_logo.svg",
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onPrimary,
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
