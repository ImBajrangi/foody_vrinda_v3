import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../widgets/premium_widgets.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Stack(
        children: [
          // Background Placeholder for Map
          Container(
            color: const Color(0xFFE2E8F0),
            child: const Center(
              child: Icon(Icons.map_outlined, size: 100, color: Colors.white),
            ),
          ),

          // Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppTheme.textMain,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const ModernBadge(
                    label: 'ORDER #FV-90210',
                    color: AppTheme.primary,
                  ),
                ],
              ),
            ),
          ),

          // Draggable Bottom Sheet for Status
          _buildTrackingCard(),
        ],
      ),
    );
  }

  Widget _buildTrackingCard() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusXL),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 40,
              offset: Offset(0, -10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&w=150&q=80',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rajesh Kumar',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Your delivery partner is on the way',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const CircleAvatar(
                    backgroundColor: Color(0xFFE8F5E9),
                    child: Icon(Icons.call, color: Colors.green, size: 20),
                  ),
                ),
              ],
            ),
            const Divider(height: 48),
            _buildTimelineStep(
              'Order Confirmed',
              'Your order has been received',
              true,
              true,
            ),
            _buildTimelineStep(
              'Preparing Order',
              'Chef is working on your meal',
              true,
              true,
            ),
            _buildTimelineStep(
              'Out for Delivery',
              'Rider is 2km away from your home',
              false,
              true,
            ),
            _buildTimelineStep('Delivered', 'Enjoy your meal!', false, false),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String subtitle,
    bool isDone,
    bool isLast,
  ) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isDone ? Colors.green : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              if (isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isDone ? Colors.green : Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isDone ? AppTheme.textMain : AppTheme.textSecondary,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDone ? AppTheme.textSecondary : Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
