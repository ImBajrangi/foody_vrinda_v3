import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/app_theme.dart';
import '../../widgets/premium_widgets.dart';

class FoodDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onAddToCart;

  const FoodDetailScreen({
    super.key,
    required this.item,
    required this.onAddToCart,
  });

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusXL),
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroImage(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 16),
                      _buildPriceRow(),
                      const Divider(height: 48),
                      _buildDescription(),
                      const SizedBox(height: 32),
                      _buildAddons(),
                      const SizedBox(height: 120), // Space for bottom bar
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusXL),
          ),
          child: CachedNetworkImage(
            imageUrl:
                widget.item['image'] ??
                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppTheme.textMain),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.radio_button_checked,
              color: Colors.green,
              size: 20,
            ),
            const SizedBox(width: 8),
            if (widget.item['tags'].contains('BESTSELLER'))
              const ModernBadge(
                label: 'BESTSELLER',
                color: Colors.orange,
                icon: Icons.star,
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          widget.item['name'],
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(fontSize: 28),
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '₹${widget.item['price']}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppTheme.primary,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => setState(
                  () => _quantity = (_quantity > 1) ? _quantity - 1 : 1,
                ),
                icon: const Icon(Icons.remove, color: AppTheme.primary),
              ),
              Text(
                '$_quantity',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _quantity++),
                icon: const Icon(Icons.add, color: AppTheme.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          widget.item['desc'] ?? 'No description available for this item.',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAddons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Extra Add-ons',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        const SizedBox(height: 16),
        _addonItem('Extra Cheese', '₹40'),
        _addonItem('Extra Sauce', '₹20'),
        _addonItem('Coke 250ml', '₹50'),
      ],
    );
  }

  Widget _addonItem(String name, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PremiumCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(
              Icons.add_circle_outline,
              color: AppTheme.primary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
            const Spacer(),
            Text(price, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SaffronButton(
          label: 'Add to Cart',
          onPressed: () {
            widget.onAddToCart();
            Navigator.pop(context);
          },
          trailing: Text(
            '₹${widget.item['price'] * _quantity}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
