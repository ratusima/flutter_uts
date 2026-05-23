// lib/screens/login_screen.dart

import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../utils/app_state.dart';
import '../utils/validators.dart';
import '../widgets/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  bool _isLoading = false;

  String? _errorMessage;

  bool _isPasswordVisible = false;

  @override
  void dispose() {

    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _handleLogin() async {

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {

      _isLoading = true;

      _errorMessage = null;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    final email =
        _emailController.text.trim();

    final password =
        _passwordController.text;

    UserModel? matchedUser;

    for (final user
        in UserModel.validUsers) {

      if (user.email == email &&
          user.validPassword ==
              password) {

        matchedUser = user;

        break;
      }
    }

    if (!mounted) return;

    setState(() {

      _isLoading = false;
    });

    if (matchedUser != null) {

      AppState.of(context)
          ?.login(matchedUser);

      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
      );

    } else {

      setState(() {

        _errorMessage =
            'Email atau password salah.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final colorScheme =
        Theme.of(context).colorScheme;

    return Scaffold(

      backgroundColor:
          colorScheme.surface,

      body: SafeArea(

        child: Center(

          child: SingleChildScrollView(

            padding:
                const EdgeInsets.all(24),

            child: Container(

              width: 420,

              padding:
                  const EdgeInsets.all(32),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  28,
                ),

                boxShadow: [

                  BoxShadow(
                    color:
                        Colors.black12,

                    blurRadius: 18,

                    offset:
                        const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(

                mainAxisSize:
                    MainAxisSize.min,

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  // HEADER
                  Center(
                    child: Column(

                      children: [

                        Container(

                          width: 80,

                          height: 80,

                          decoration:
                              BoxDecoration(

                            color:
                                colorScheme
                                    .primary,

                            borderRadius:
                                BorderRadius.circular(
                              22,
                            ),
                          ),

                          child: const Icon(
                            Icons.school_rounded,

                            color:
                                Colors.white,

                            size: 42,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Text(
                          'Selamat Datang',

                          style:
                              Theme.of(
                            context,
                          )
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(

                            fontWeight:
                                FontWeight
                                    .w700,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          'Masuk ke akun Anda untuk melanjutkan',

                          style:
                              Theme.of(
                            context,
                          )
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(

                            color:
                                colorScheme
                                    .onSurface
                                    .withOpacity(
                                      0.6,
                                    ),
                          ),

                          textAlign:
                              TextAlign
                                  .center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // FORM
                  Form(

                    key: _formKey,

                    child: Column(

                      children: [

                        // EMAIL
                        CustomTextField(

                          label: 'Email',

                          hint:
                              'Masukkan email Anda',

                          controller:
                              _emailController,

                          validator:
                              Validators.email,

                          keyboardType:
                              TextInputType
                                  .emailAddress,
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        // PASSWORD
                        CustomTextField(

                          label:
                              'Password',

                          hint:
                              'Masukkan password Anda',

                          controller:
                              _passwordController,

                          validator:
                              Validators.password,

                          obscureText:
                              !_isPasswordVisible,

                          textInputAction:
                              TextInputAction
                                  .done,

                          suffixIcon:
                              IconButton(

                            icon: Icon(

                              _isPasswordVisible

                                  ? Icons
                                      .visibility_off_outlined

                                  : Icons
                                      .visibility_outlined,

                              color:
                                  colorScheme
                                      .onSurface
                                      .withOpacity(
                                        0.5,
                                      ),
                            ),

                            onPressed: () {

                              setState(() {

                                _isPasswordVisible =
                                    !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  // LUPA PASSWORD
                  Align(

                    alignment:
                        Alignment.centerRight,

                    child: TextButton(

                      onPressed: () {

                        Navigator.pushNamed(
                          context,
                          '/forgot-password',
                        );
                      },

                      child: Text(

                        'Lupa Password?',

                        style: TextStyle(

                          color:
                              colorScheme
                                  .primary,

                          fontWeight:
                              FontWeight
                                  .w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  // ERROR MESSAGE
                  if (_errorMessage != null)
                    ...[

                    Container(

                      padding:
                          const EdgeInsets.all(
                        12,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            colorScheme
                                .errorContainer,

                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),

                      child: Row(

                        children: [

                          Icon(

                            Icons.error_outline,

                            color:
                                colorScheme
                                    .error,

                            size: 18,
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          Expanded(

                            child: Text(

                              _errorMessage!,

                              style: TextStyle(

                                color:
                                    colorScheme
                                        .error,

                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                  ],

                  // BUTTON LOGIN
                  PrimaryButton(

                    label: 'Masuk',

                    onPressed:
                        _handleLogin,

                    isLoading:
                        _isLoading,
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