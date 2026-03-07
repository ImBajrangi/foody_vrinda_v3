import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Configuration for notification sounds based on user roles
class NotificationSoundConfig {
  // New constants for a single notification sound
  static const String notificationSoundChannelId = 'foody_vrinda_notifications';
  static const String notificationSoundChannelName =
      'Foody Vrinda Notifications';
  static const String notificationSoundFileName =
      'bell'; // bell.mp3 in assets/sounds/
  static const String notificationSoundValue = 'assets/sounds/bell.mp3';

  // Default sound file names for different roles (legacy/fallback)
  static const String defaultOwnerSound = 'bell.mp3';
  static const String defaultKitchenSound = 'bell.mp3';
  static const String defaultDeliverySound = 'bell.mp3';

  // Cache for loaded sounds
  static Map<String, String>? _cachedSounds;

  /// Get the sound file path for a specific role
  /// Returns the configured sound from SharedPreferences or default
  static Future<String> getSoundForRole(UserRole role) async {
    // Load sounds if not cached
    if (_cachedSounds == null) {
      await _loadSounds();
    }

    switch (role) {
      case UserRole.owner:
        return _cachedSounds!['owner']!;
      case UserRole.kitchen:
        return _cachedSounds!['kitchen']!;
      case UserRole.delivery:
        return _cachedSounds!['delivery']!;
      default:
        return defaultOwnerSound;
    }
  }

  /// Load sound preferences from SharedPreferences
  static Future<void> _loadSounds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _cachedSounds = {
        'owner': prefs.getString('sound_owner') ?? defaultOwnerSound,
        'kitchen': prefs.getString('sound_kitchen') ?? defaultKitchenSound,
        'delivery': prefs.getString('sound_delivery') ?? defaultDeliverySound,
      };
    } catch (e) {
      // If there's an error, use defaults
      _cachedSounds = {
        'owner': defaultOwnerSound,
        'kitchen': defaultKitchenSound,
        'delivery': defaultDeliverySound,
      };
    }
  }

  /// Reload sound preferences (call this after updating preferences)
  static Future<void> reloadSounds() async {
    _cachedSounds = null;
    await _loadSounds();
  }

  /// Get the asset path for a sound file
  static String getAssetPath(String soundFile) {
    return 'sounds/$soundFile';
  }

  /// Get channel ID based on notification type and role
  static String getChannelId(String notificationType, UserRole? role) {
    if (role != null) {
      return '${notificationType}_${role.value}';
    }
    return notificationType;
  }

  /// Get channel name based on notification type and role
  static String getChannelName(String notificationType, UserRole? role) {
    final rolePrefix = role != null ? '${_getRoleDisplayName(role)} ' : '';
    final typeDisplay = _getNotificationTypeDisplay(notificationType);
    return '$rolePrefix$typeDisplay';
  }

  /// Get human-readable role name
  static String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.owner:
        return 'Owner';
      case UserRole.kitchen:
        return 'Kitchen';
      case UserRole.delivery:
        return 'Delivery';
      case UserRole.developer:
        return 'Developer';
      case UserRole.customer:
        break;
    }
    return 'Customer';
  }

  /// Get human-readable notification type
  static String _getNotificationTypeDisplay(String type) {
    switch (type) {
      case 'new_orders':
        return 'New Orders';
      case 'delivery_orders':
        return 'Delivery Orders';
      case 'order_updates':
        return 'Order Updates';
      case 'general':
        return 'General Notifications';
      default:
        return 'Notifications';
    }
  }

  /// Check if custom sound should be used based on platform and availability
  static bool shouldUseCustomSound() {
    // Custom sounds are supported on both Android and iOS
    // However, we'll return true only if sound files are present
    // This can be extended to check file existence if needed
    return true;
  }
}
