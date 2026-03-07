import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/app_theme.dart';
import '../../widgets/premium_widgets.dart';
import '../cart/cart_screen.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  int _selectedTab = 0;
  final int _cartCount = 0;
  final double _cartTotal = 0.0;
  final _tabs = ['Recommended', 'Thali', 'Biryani', 'Starters', 'Sides'];

  final _menuItems = [
    {
      'name': 'Paneer Butter Masala',
      'desc':
          'Rich and creamy cottage cheese curry made with onion, tomato, and cashew nut paste.',
      'price': 220.0,
      'tags': ['BESTSELLER', 'VEG'],
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDIojp7_O1f8Q3yWNDPQowiqwtn95WaYnmEyx7a_slrLA5KKXU1p8HrfkVUHWJEO02o3g_em3Et45bg5Kev8fS8LDvZrQID-zvPsdybVhMl_p4nq7aO9LZs2v-T7HheQyYSuT5amNlm451x5DPKoesEDNdrdT0bJDEhMIfbDj10TsXJIPCjr9Nv7xUkMWAoJQ3sCo1PeLU2KoLwFLsTn1I0-2awgIGZ_mxEEJX1y1bxvA5Vvfv7C-VTGqlmrSahnWkqkxScgp3IZd4',
    },
    {
      'name': 'Chicken Dum Biryani',
      'desc':
          'Aromatic basmati rice cooked with marinated chicken, spices, and herbs in traditional dum style.',
      'price': 280.0,
      'tags': ['POPULAR', 'NON-VEG'],
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAKcE5LiCaNMjSGtufYs0pl7TgkaiyAot_QqSndPKeQ4fj30k7JoW383T4ThaNshcrmq8wo8PB43fkinihLYgSlcFm3A7A0E9S1CDu-d40F_wte-de__FVLr6xZia0yL3m1UfkxZcGSq3mi7cqDtuW3BdOR8dYQq3j2Dfp80YOYscL8PSX81B-cao5qowSB8uwOjsRkaMUUaNhzhwZBM1Ww3ESZuVjdhQ0HWa-mN60AcwctdpuqpqZufyOlp5qbpnjznoEK59qyuY8',
    },
    {
      'name': 'Special Veg Thali',
      'desc':
          'Dal makhani, shahi paneer, mix veg, 2 butter naan, jeera rice, raita, and gulab jamun.',
      'price': 250.0,
      'tags': ['BESTSELLER', 'VEG'],
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDibie3CsYtbce44ndRefsb8wQKPVID7kQ_Jd_gTOmryxHuEqbc80JdPAK-2ZoSFD7L846WcAIRXpole0mEe0tswrtjYt2pOBdvBCe3PRCbfEljibFDiepGY_NJ4bufOZbTcnvnlsbI8j3LeHueJxQLcXwYzPwf_7fGjfc6GvEc_dIDejaulRDWIjx1Ag4qJzYVIy0sLmna739Q_0uCGyP9iPZAHx4kPNK09uVbfvUg9a2y4QhPxI6C3Ebq0zSmwNCnD4X0lvFD8XU',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildHero(),
              SliverToBoxAdapter(child: _buildInfoBar()),
              SliverToBoxAdapter(child: _buildPromoSection()),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(child: _buildTabs()),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildMenuItem(_menuItems[index]),
                    childCount: _menuItems.length,
                  ),
                ),
              ),
            ],
          ),
          _buildFloatingCart(),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppTheme.primary,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          child: IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          child: IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuD22ti5pbtZyh56fLdMv-3lYP1fXCWxFqffnZMS3t2wRo2z0FLtneWBgaZS_rUG8OdSmoT_nxxYAbYQJDAMw4ZRSc2YPOy1l99xY6I7RwqoIShmBDtV-r18nStX97Jgzas3DMCaO8KOwQjBGM2EHiBlRHq1oaFQmjCgkpOj2EbVBPZ-x7Z2tD9arfCZBrtAtemGycuYoslpfPKkhAWpZ665zIsO3HvYbjEq4DTL9HQLxLGcrCZTopOQitpSrlLKPGdpI8HGp8QnB8o',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vrinda's Kitchen",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _headerChip('North Indian'),
                      const SizedBox(width: 8),
                      _headerChip('Mughlai'),
                      const SizedBox(width: 8),
                      _headerChip('Biryani'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoBar() {
    return Transform.translate(
      offset: const Offset(0, -24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusXL),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _infoItem('4.5', Icons.star, '200+ ratings', Colors.amber),
            _divider(),
            _infoItem('25-30', Icons.timer_outlined, 'mins', AppTheme.primary),
            _divider(),
            _infoItem('₹250', Icons.wallet_outlined, 'for two', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String val, IconData icon, String label, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              val,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            const SizedBox(width: 4),
            Icon(icon, color: color, size: 18),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _divider() => Container(
    width: 1,
    height: 40,
    color: Colors.grey.withValues(alpha: 0.2),
  );

  Widget _buildPromoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_offer, color: AppTheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Use code VRINDA50',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  Text(
                    'Flat ₹75 OFF on orders above ₹199',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SaffronButton(label: 'Apply', onPressed: () {}, fullWidth: false),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 24),
        itemBuilder: (context, i) {
          final active = i == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _tabs[i],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                    color: active ? AppTheme.primary : AppTheme.textSecondary,
                  ),
                ),
                if (active) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: 24,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    if (item['tags'].contains('BESTSELLER'))
                      const ModernBadge(
                        label: 'BESTSELLER',
                        color: Colors.orange,
                        icon: Icons.star,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${item['price']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['desc'],
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: item['image'],
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -15,
                child: Container(
                  width: 90,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: const Center(
                        child: Text(
                          'ADD',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingCart() {
    if (_cartCount == 0) return const SizedBox.shrink();
    return Positioned(
      bottom: 24,
      left: 16,
      right: 16,
      child: SaffronButton(
        label: 'View Cart',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        ),
        trailing: Text(
          '$_cartCount items | ₹$_cartTotal',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});
  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => child;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
