import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../config/app_theme.dart';
import '../../widgets/premium_widgets.dart';
import '../tracking/tracking_screen.dart';
import '../home/home_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Success Animation
              Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_kz9pjcjt.json',
                width: 200,
                height: 200,
                repeat: false,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.check_circle,
                  size: 120,
                  color: AppTheme.success,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Order Placed Successfully!',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(color: AppTheme.success),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your order #FV-90210 has been received and is being prepared with love at Vrinda\'s Kitchen.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 48),
              PremiumCard(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      color: AppTheme.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estimated Preparation',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '15 - 20 minutes',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SaffronButton(
                label: 'Track Order',
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const TrackingScreen()),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
