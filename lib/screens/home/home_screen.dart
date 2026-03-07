import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/app_theme.dart';
import '../../widgets/premium_widgets.dart';
import '../restaurant/restaurant_screen.dart';
import '../favorites/favorites_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  final List<Widget> _screens = [
    const _HomeContent(),
    const FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: IndexedStack(index: _currentNavIndex, children: _screens),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', 0),
              _buildNavItem(Icons.favorite_rounded, 'Favorites', 1),
              _buildNavItem(Icons.shopping_bag_rounded, 'Cart', 2),
              _buildNavItem(Icons.person_rounded, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final active = _currentNavIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? AppTheme.primary : AppTheme.textSecondary),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: active ? FontWeight.w800 : FontWeight.w500,
              color: active ? AppTheme.primary : AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  final _categories = [
    {'icon': Icons.local_pizza, 'label': 'Pizza'},
    {'icon': Icons.lunch_dining, 'label': 'Burger'},
    {'icon': Icons.ramen_dining, 'label': 'Ramen'},
    {'icon': Icons.set_meal, 'label': 'Sushi'},
    {'icon': Icons.coffee, 'label': 'Coffee'},
    {'icon': Icons.bakery_dining, 'label': 'Desserts'},
  ];

  final _trendingDishes = [
    {
      'name': 'Paneer Butter Masala',
      'kitchen': "Vrinda's Kitchen",
      'price': '₹220',
      'rating': '4.8',
      'time': '25 min',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDIojp7_O1f8Q3yWNDPQowiqwtn95WaYnmEyx7a_slrLA5KKXU1p8HrfkVUHWJEO02o3g_em3Et45bg5Kev8fS8LDvZrQID-zvPsdybVhMl_p4nq7aO9LZs2v-T7HheQyYSuT5amNlm451x5DPKoesEDNdrdT0bJDEhMIfbDj10TsXJIPCjr9Nv7xUkMWAoJQ3sCo1PeLU2KoLwFLsTn1I0-2awgIGZ_mxEEJX1y1bxvA5Vvfv7C-VTGqlmrSahnWkqkxScgp3IZd4',
    },
    {
      'name': 'Chicken Dum Biryani',
      'kitchen': "Royal Spice",
      'price': '₹280',
      'rating': '4.9',
      'time': '35 min',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAKcE5LiCaNMjSGtufYs0pl7TgkaiyAot_QqSndPKeQ4fj30k7JoW383T4ThaNshcrmq8wo8PB43fkinihLYgSlcFm3A7A0E9S1CDu-d40F_wte-de__FVLr6xZia0yL3m1UfkxZcGSq3mi7cqDtuW3BdOR8dYQq3j2Dfp80YOYscL8PSX81B-cao5qowSB8uwOjsRkaMUUaNhzhwZBM1Ww3ESZuVjdhQ0HWa-mN60AcwctdpuqpqZufyOlp5qbpnjznoEK59qyuY8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverHeader(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPromoBanner(),
                const SizedBox(height: 24),
                _buildSectionHeader('Categories', () {}),
                const SizedBox(height: 16),
                _buildCategories(),
                const SizedBox(height: 32),
                _buildSectionHeader('Trending Dishes', () {}),
                const SizedBox(height: 16),
                _buildTrendingDishes(),
                const SizedBox(height: 32),
                _buildSectionHeader('Nearby Kitchens', () {}),
                const SizedBox(height: 16),
                _buildKitchenList(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      toolbarHeight: 120,
      backgroundColor: AppTheme.backgroundLight,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppTheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Home - Mathura, UP',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 16),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                  const Spacer(),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=80',
                    ),
                    radius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppTheme.textSecondary),
                    const SizedBox(width: 8),
                    Text(
                      'Search for "Biryani"',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                    const Spacer(),
                    const Icon(Icons.mic, color: AppTheme.primary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.accentGold],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.local_fire_department,
              size: 180,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'FLAT 50% OFF',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Savor the flavor\nof Vrinda Specials',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Use code: VRINDA50',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(
              color: AppTheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 20),
        itemBuilder: (context, i) => CategoryChip(
          label: _categories[i]['label'] as String,
          icon: _categories[i]['icon'] as IconData,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RestaurantScreen()),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingDishes() {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _trendingDishes.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, i) {
          final dish = _trendingDishes[i];
          return PremiumCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RestaurantScreen()),
            ),
            radius: AppTheme.radiusL,
            child: SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppTheme.radiusL),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: dish['image']!,
                      height: 120,
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dish['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dish['kitchen']!,
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dish['price']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppTheme.primary,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  dish['rating']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKitchenList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, i) {
        return PremiumCard(
          padding: const EdgeInsets.all(12),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RestaurantScreen()),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1544148103-0773bf10d330?auto=format&fit=crop&w=150&q=80',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Vrinda's Kitchen",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const ModernBadge(
                          label: '4.5',
                          color: Colors.green,
                          icon: Icons.star,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'North Indian • Mughlai • Biryani',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '25-30 min',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.wallet_outlined,
                          size: 14,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '₹250 for two',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
