class LeaderboardUserModel {
  const LeaderboardUserModel({
    required this.rank,
    required this.name,
    required this.totalValue,
    required this.returnsPercent,
    required this.isCurrentUser,
  });

  final int rank;
  final String name;
  final double totalValue;
  final double returnsPercent;
  final bool isCurrentUser;

  factory LeaderboardUserModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String? ?? '';
    return LeaderboardUserModel(
      rank: json['rank'] as int? ?? 0,
      name: name,
      totalValue: (json['portfolio_value'] ?? json['totalValue'] ?? 0).toDouble(),
      returnsPercent:
          (json['returns_percent'] ?? json['returnsPercent'] ?? 0).toDouble(),
      isCurrentUser: name.toLowerCase().contains('demo') || name == 'You',
    );
  }
}
