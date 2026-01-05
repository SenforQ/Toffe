import 'package:shared_preferences/shared_preferences.dart';

class CoinService {
  static const String _coinsKey = 'user_coins';

  /// Initialize a new user with 0 coins if they don't have coins set
  static Future<void> initializeNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_coinsKey)) {
      await prefs.setInt(_coinsKey, 0);
    }
  }

  /// Get the current coin balance
  static Future<int> getCurrentCoins() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_coinsKey) ?? 0;
  }

  /// Add coins to the user's balance
  /// Returns true if successful, false otherwise
  static Future<bool> addCoins(int amount) async {
    if (amount <= 0) return false;
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentCoins = await getCurrentCoins();
      await prefs.setInt(_coinsKey, currentCoins + amount);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Deduct coins from the user's balance
  /// Returns true if successful (enough coins), false otherwise
  static Future<bool> deductCoins(int amount) async {
    if (amount <= 0) return false;
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentCoins = await getCurrentCoins();
      if (currentCoins < amount) {
        return false; // Not enough coins
      }
      await prefs.setInt(_coinsKey, currentCoins - amount);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Set coins to a specific amount
  static Future<bool> setCoins(int amount) async {
    if (amount < 0) return false;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_coinsKey, amount);
      return true;
    } catch (e) {
      return false;
    }
  }
}

