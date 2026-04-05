enum PriceStaleness { fresh, stale, expired, never }

PriceStaleness getPriceStaleness(DateTime? updatedAt) {
  if (updatedAt == null) return PriceStaleness.never;

  final age = DateTime.now().difference(updatedAt);
  if (age.inHours < 1) return PriceStaleness.fresh;
  if (age.inHours < 24) return PriceStaleness.stale;
  return PriceStaleness.expired;
}

String stalenessLabel(PriceStaleness staleness) => switch (staleness) {
      PriceStaleness.fresh => '',
      PriceStaleness.stale => '昨天的價格',
      PriceStaleness.expired => '價格已過期',
      PriceStaleness.never => '等待價格更新',
    };
