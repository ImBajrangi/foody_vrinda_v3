import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../widgets/premium_widgets.dart';
import '../order_success/order_success_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _items = [
    {
      'name': 'Paneer Butter Masala',
      'price': 220.0,
      'qty': 1,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDIojp7_O1f8Q3yWNDPQowiqwtn95WaYnmEyx7a_slrLA5KKXU1p8HrfkVUHWJEO02o3g_em3Et45bg5Kev8fS8LDvZrQID-zvPsdybVhMl_p4nq7aO9LZs2v-T7HheQyYSuT5amNlm451x5DPKoesEDNdrdT0bJDEhMIfbDj10TsXJIPCjr9Nv7xUkMWAoJQ3sCo1PeLU2KoLwFLsTn1I0-2awgIGZ_mxEEJX1y1bxvA5Vvfv7C-VTGqlmrSahnWkqkxScgp3IZd4',
    },
    {
      'name': 'Chicken Dum Biryani',
      'price': 280.0,
      'qty': 1,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAKcE5LiCaNMjSGtufYs0pl7TgkaiyAot_QqSndPKeQ4fj30k7JoW383T4ThaNshcrmq8wo8PB43fkinihLYgSlcFm3A7A0E9S1CDu-d40F_wte-de__FVLr6xZia0yL3m1UfkxZcGSq3mi7cqDtuW3BdOR8dYQq3j2Dfp80YOYscL8PSX81B-cao5qowSB8uwOjsRkaMUUaNhzhwZBM1Ww3ESZuVjdhQ0HWa-mN60AcwctdpuqpqZufyOlp5qbpnjznoEK59qyuY8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryAddress(),
            const SizedBox(height: 24),
            Text('Your Order', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ..._items.map((item) => _buildCartItem(item)),
            const SizedBox(height: 24),
            _buildPromoCode(),
            const SizedBox(height: 24),
            _buildBillDetails(),
            const SizedBox(height: 32),
            SaffronButton(
              label: 'Proceed to Payment',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return PremiumCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFFFEBD6),
            child: Icon(Icons.location_on, color: AppTheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery to Home',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                Text(
                  'Krishna Nagar, Mathura, UP - 281001',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PremiumCard(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '₹${item['price']}',
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove, size: 18),
                    color: AppTheme.primary,
                  ),
                  Text(
                    '${item['qty']}',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 18),
                    color: AppTheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCode() {
    return PremiumCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.local_offer_outlined, color: AppTheme.primary),
          const SizedBox(width: 12),
          const Text(
            'Apply Promo Code',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              'View All',
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillDetails() {
    return PremiumCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bill Details',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          const SizedBox(height: 16),
          _billRow('Item Total', '₹500.00'),
          _billRow('Delivery Fee', '₹40.00'),
          _billRow('GST and Taxes', '₹25.00'),
          const Divider(height: 32),
          _billRow('Total Amount', '₹565.00', isBold: true),
        ],
      ),
    );
  }

  Widget _billRow(String label, String val, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
              fontSize: isBold ? 16 : 14,
            ),
          ),
          Text(
            val,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
              fontSize: isBold ? 16 : 14,
              color: isBold ? AppTheme.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
