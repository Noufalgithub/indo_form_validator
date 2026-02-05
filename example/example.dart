import 'package:flutter/material.dart';
import 'package:indo_form_validator/indo_form_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indo Form Validator Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ExampleForm(),
    );
  }
}

class ExampleForm extends StatefulWidget {
  const ExampleForm({super.key});

  @override
  State<ExampleForm> createState() => _ExampleFormState();
}

class _ExampleFormState extends State<ExampleForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Indo Form Validator Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phone Number Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '081234567890',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: IndoValidator.phone(),
              ),
              const SizedBox(height: 16),

              // Phone Number with English messages
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number (English)',
                  hintText: '+628123456789',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: IndoValidator.phone(
                  config: ValidationConfig.english,
                ),
              ),
              const SizedBox(height: 16),

              // NIK Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NIK',
                  hintText: '3201234567890123',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: IndoValidator.nik(),
              ),
              const SizedBox(height: 16),

              // NIK with region validation
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NIK (with region validation)',
                  hintText: '3201234567890123',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: IndoValidator.nik(
                  config: ValidationConfig.strictMode,
                  validateRegion: true,
                ),
              ),
              const SizedBox(height: 16),

              // NPWP Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NPWP',
                  hintText: '12.345.678.9-012.345',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: IndoValidator.npwp(),
              ),
              const SizedBox(height: 16),

              // Email Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'user@example.com',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: IndoValidator.email(),
              ),
              const SizedBox(height: 16),

              // Chained Validators
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone (must be exactly 12 digits)',
                  hintText: '081234567890',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: IndoValidator.chain([
                  IndoValidator.phone(),
                  (value) {
                    final cleaned = value?.replaceAll(
                      RegExp(r'[\s\-\(\)]'),
                      '',
                    );
                    return cleaned?.length == 12
                        ? null
                        : 'Nomor harus 12 digit';
                  },
                ]),
              ),
              const SizedBox(height: 16),

              // Custom Validator
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Custom Validation',
                  hintText: 'Must start with 08',
                  border: OutlineInputBorder(),
                ),
                validator: IndoValidator.custom(
                  (value) => value?.startsWith('08') ?? false,
                  'Nomor harus dimulai dengan 08',
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid!')),
                    );
                  }
                },
                child: const Text('Validate Form'),
              ),
              const SizedBox(height: 24),

              // Standalone Validation Examples
              const Text(
                'Standalone Validation Examples:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _demonstrateStandaloneValidation,
                child: const Text('Run Standalone Validation'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _demonstrateStandaloneValidation() {
    // Using ValidationResult
    final phoneResult = IndoValidator.validatePhone('081234567890');
    print('Phone validation: ${phoneResult.isValid}');

    // Using boolean check
    final isValidNik = NikValidator.isValid('3201234567890123');
    print('NIK is valid: $isValidNik');

    // Format NPWP
    final formatted = NpwpValidator.format('123456789012345');
    print('Formatted NPWP: $formatted');

    // Custom config
    final result = PhoneValidator.validate(
      'invalid',
      config: ValidationConfig.english,
    );
    print('Error message: ${result.message}');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Check console for results')));
  }
}
