// lib/screens/forgot_password_screen.dart

import 'package:flutter/material.dart';

import '../utils/validators.dart';
import '../widgets/custom_widgets.dart';

class ForgotPasswordScreen
    extends StatefulWidget {

  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen>
      createState() =>
          _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  bool _isLoading = false;

  bool _emailSent = false;

  @override
  void dispose() {

    _emailController.dispose();

    super.dispose();
  }

  Future<void> _handleSendReset() async {

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {

      _isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    setState(() {

      _isLoading = false;

      _emailSent = true;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: const Text(
          'Link reset telah dikirim',
        ),

        backgroundColor:
            Colors.green.shade600,

        behavior:
            SnackBarBehavior.floating,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10),
        ),

        margin:
            const EdgeInsets.all(16),
      ),
    );
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

                  // BACK BUTTON
                  IconButton(

                    padding:
                        EdgeInsets.zero,

                    alignment:
                        Alignment.centerLeft,

                    icon: Icon(

                      Icons
                          .arrow_back_ios_rounded,

                      color:
                          colorScheme
                              .onSurface,
                    ),

                    onPressed: () {

                      Navigator.pop(
                        context,
                      );
                    },
                  ),

                  const SizedBox(
                    height: 8,
                  ),

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
                                    .primary
                                    .withOpacity(
                                      0.1,
                                    ),

                            borderRadius:
                                BorderRadius.circular(
                              22,
                            ),
                          ),

                          child: Icon(

                            Icons
                                .lock_reset_rounded,

                            color:
                                colorScheme
                                    .primary,

                            size: 42,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Text(

                          'Lupa Password?',

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

                          'Masukkan email Anda untuk menerima link reset password.',

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

                            height: 1.5,
                          ),

                          textAlign:
                              TextAlign
                                  .center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 36,
                  ),

                  // FORM
                  Form(

                    key: _formKey,

                    child: CustomTextField(

                      label: 'Email',

                      hint:
                          'Masukkan email Anda',

                      controller:
                          _emailController,

                      validator:
                          Validators
                              .resetEmail,

                      keyboardType:
                          TextInputType
                              .emailAddress,

                      textInputAction:
                          TextInputAction
                              .done,
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // BUTTON RESET
                  PrimaryButton(

                    label:
                        'Kirim Link Reset',

                    onPressed:
                        _emailSent
                            ? null
                            : _handleSendReset,

                    isLoading:
                        _isLoading,
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // BUTTON KEMBALI
                  SizedBox(

                    width: double.infinity,

                    height: 50,

                    child: OutlinedButton(

                      onPressed: () {

                        Navigator.pop(
                          context,
                        );
                      },

                      style:
                          OutlinedButton.styleFrom(

                        side: BorderSide(

                          color:
                              colorScheme
                                  .outline
                                  .withOpacity(
                                    0.5,
                                  ),
                        ),

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),

                      child: Text(

                        'Kembali ke Login',

                        style: TextStyle(

                          color:
                              colorScheme
                                  .onSurface,

                          fontWeight:
                              FontWeight
                                  .w500,
                        ),
                      ),
                    ),
                  ),

                  // SUCCESS MESSAGE
                  if (_emailSent) ...[

                    const SizedBox(
                      height: 24,
                    ),

                    Container(

                      padding:
                          const EdgeInsets.all(
                        16,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors
                                .green
                                .shade50,

                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),

                        border: Border.all(

                          color:
                              Colors
                                  .green
                                  .shade200,
                        ),
                      ),

                      child: Row(

                        children: [

                          Icon(

                            Icons
                                .check_circle_outline,

                            color:
                                Colors
                                    .green
                                    .shade600,
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(

                                  'Email terkirim!',

                                  style: TextStyle(

                                    fontWeight:
                                        FontWeight
                                            .w600,

                                    color:
                                        Colors
                                            .green
                                            .shade700,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                Text(

                                  'Cek inbox ${_emailController.text.trim()}',

                                  style: TextStyle(

                                    fontSize: 13,

                                    color:
                                        Colors
                                            .green
                                            .shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}