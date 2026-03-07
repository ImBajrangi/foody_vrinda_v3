import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../widgets/premium_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(AppTheme.radiusXL),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=80',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Mr. Bajrangi',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'mr.bajrangi@example.com',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildProfileStat('Orders', '12'),
                      _buildProfileStat('Reviews', '4'),
                      _buildProfileStat('Points', '450'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildProfileOption(Icons.person_outlined, 'My Account'),
                  _buildProfileOption(Icons.shopping_bag_outlined, 'My Orders'),
                  _buildProfileOption(
                    Icons.location_on_outlined,
                    'My Addresses',
                  ),
                  _buildProfileOption(
                    Icons.payment_outlined,
                    'Payment Methods',
                  ),
                  _buildProfileOption(
                    Icons.notifications_none,
                    'Notifications',
                  ),
                  _buildProfileOption(Icons.help_outline, 'Help & Support'),
                  const SizedBox(height: 24),
                  SaffronButton(
                    label: 'Logout',
                    onPressed: () => Navigator.of(
                      context,
                    ).popUntil((route) => route.isFirst),
                    fullWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppTheme.primary,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProfileOption(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PremiumCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        onTap: () {},
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
