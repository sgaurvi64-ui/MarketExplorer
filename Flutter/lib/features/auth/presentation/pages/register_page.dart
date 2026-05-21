import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/api_constants.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../../../core/providers/firebase_auth_provider.dart';
import '../../../../core/providers/firestore_provider.dart';
import '../providers/auth_state_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _userIdController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  bool _obscurePassword = true;
  DateTime? _selectedDob;
  String _countryCode = '+91';
  String? _userIdError;
  String? _ageError;
  String? _passwordRuleError;
  String? _phoneError;
  String? _emailError;
  bool _isCheckingUserId = false;

  @override
  void dispose() {
    _userIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 18, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 80),
      lastDate: DateTime(now.year - 14, now.month, now.day),
      initialDate: initialDate,
    );
    if (picked != null) {
      setState(() {
        _selectedDob = picked;
        _dobController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  bool _validatePasswordRules(String value) {
    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasLower = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));
    final hasSymbol = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return value.length >= 8 && hasUpper && hasLower && hasDigit && hasSymbol;
  }

  bool _validateEmailFormat(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  int _calculateAge(DateTime dob) {
    final now = DateTime.now();
    var age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age -= 1;
    }
    return age;
  }

  bool _isPhoneValid(String number) {
    final digitsOnly = RegExp(r'^\d+$').hasMatch(number);
    if (!digitsOnly) {
      return false;
    }
    if (_countryCode == '+91') {
      return number.length == 10;
    }
    return number.length >= 8;
  }

  bool _validateBeforeOtp() {
    setState(() {
      _userIdError = null;
      _ageError = null;
      _passwordRuleError = null;
      _phoneError = null;
      _emailError = null;
    });

    final userId = _userIdController.text.trim();
    if (userId.isEmpty || userId.toLowerCase() == 'admin') {
      _userIdError = 'User ID should be unique.';
    }

    if (_selectedDob == null) {
      _ageError = 'User must be 14 or above to create an account.';
    } else {
      final age = _calculateAge(_selectedDob!);
      if (age < 14) {
        _ageError = 'User must be 14 or above to create an account.';
      }
    }

    if (!_validatePasswordRules(_passwordController.text)) {
      _passwordRuleError =
          'Password must contain 8+ chars, uppercase, symbol, and number.';
    }

    if (!_isPhoneValid(_phoneController.text.trim())) {
      _phoneError =
          'Your phone number sequence does not match the country code.';
    }

    if (!_validateEmailFormat(_emailController.text.trim())) {
      _emailError = 'Invalid email ID or email ID does not exist.';
    }

    setState(() {});

    return _userIdError == null &&
        _ageError == null &&
        _passwordRuleError == null &&
        _phoneError == null &&
        _emailError == null;
  }

  Future<bool> _isUserIdAvailable(String userId) async {
    try {
      setState(() => _isCheckingUserId = true);
      final firestore = ref.read(firestoreServiceProvider);
      return await firestore.isUserIdAvailable(userId);
    } catch (_) {
      return false;
    } finally {
      if (mounted) {
        setState(() => _isCheckingUserId = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration roundedInput(String label, IconData icon) {
      return InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Color(0xFFEAF8F1),
                      child: Text(
                        'LOGO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B6E4F),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Create your account',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Create your account and start paper trading Indian markets.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _userIdController,
                    decoration: roundedInput(
                      'User ID (unique)',
                      Icons.alternate_email,
                    ),
                  ),
                  if (_userIdError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _userIdError!,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  TextField(
                    controller: _firstNameController,
                    decoration: roundedInput('First name', Icons.person_outline),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _lastNameController,
                    decoration: roundedInput('Last name', Icons.person_outline),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _dobController,
                    readOnly: true,
                    onTap: _pickDob,
                    decoration: roundedInput(
                      'Date of birth',
                      Icons.cake_outlined,
                    ),
                  ),
                  if (_ageError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _ageError!,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButton<String>(
                            value: _countryCode,
                            underline: const SizedBox.shrink(),
                            items: const [
                              DropdownMenuItem(value: '+91', child: Text('+91')),
                              DropdownMenuItem(value: '+1', child: Text('+1')),
                              DropdownMenuItem(value: '+44', child: Text('+44')),
                            ],
                            onChanged: (value) {
                              setState(() => _countryCode = value ?? '+91');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration:
                              roundedInput('Phone number', Icons.phone_outlined),
                        ),
                      ),
                    ],
                  ),
                  if (_phoneError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _phoneError!,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: roundedInput('Email', Icons.email_outlined),
                  ),
                  if (_emailError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _emailError!,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                  ),
                  if (_passwordRuleError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _passwordRuleError!,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  if (_isCheckingUserId) ...[
                    Row(
                      children: [
                        const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Checking user ID...',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _isSubmitting
                          ? null
                          : () async {
                              if (!_validateBeforeOtp()) {
                                return;
                              }
                              setState(() {
                                _isSubmitting = true;
                                _userIdError = null;
                              });
                              final userId = _userIdController.text.trim();
                              final isAvailable =
                                  await _isUserIdAvailable(userId);
                              if (!isAvailable) {
                                if (!mounted) return;
                                setState(() {
                                  _userIdError = 'User ID should be unique.';
                                  _isSubmitting = false;
                                });
                                return;
                              }

                              final firstName =
                                  _firstNameController.text.trim();
                              final lastName = _lastNameController.text.trim();
                              final name = '$firstName $lastName'.trim();
                              final email = _emailController.text.trim();
                              final password = _passwordController.text;
                              final phone =
                                  '$_countryCode ${_phoneController.text.trim()}';

                              try {
                                final firebaseAuth =
                                    ref.read(firebaseAuthServiceProvider);
                                final firestore =
                                    ref.read(firestoreServiceProvider);
                                final dio = ref.read(dioProvider);

                                final user = await firebaseAuth
                                    .registerWithEmailPassword(
                                      email: email,
                                      password: password,
                                    );

                                if (user == null) {
                                  throw Exception('Account creation failed.');
                                }

                                await firebaseAuth.sendEmailVerification();

                                await firestore.saveUserProfile(
                                  user.uid,
                                  {
                                    'user_id': userId,
                                    'first_name': firstName,
                                    'last_name': lastName,
                                    'username': name,
                                    'email': email,
                                    'phone': phone,
                                    'firebase_uid': user.uid,
                                    'createdAt':
                                        DateTime.now().toIso8601String(),
                                  },
                                );

                                await dio.post(
                                  '${ApiConstants.users}/register/',
                                  data: {
                                    'username': userId,
                                    'name': name,
                                    'first_name': firstName,
                                    'last_name': lastName,
                                    'email': email,
                                    'phone': phone,
                                    'firebase_uid': user.uid,
                                  },
                                );

                                await ref
                                    .read(authControllerProvider.notifier)
                                    .login(email: email, password: password);

                                if (!mounted) return;
                                context.go('/home');
                              } catch (error) {
                                if (!mounted) return;
                                setState(() => _isSubmitting = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Registration failed: $error',
                                    ),
                                  ),
                                );
                              }
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          _isSubmitting
                              ? 'Creating account...'
                              : 'Create Account',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Already have an account? Login'),
                    ),
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
