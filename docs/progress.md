# WealthTrack 開發進度

> 最後更新：2026-04-05

## 總覽

| Phase | 名稱 | 預估時間 | 狀態 |
|-------|------|---------|------|
| 1 | 基礎建設 | 1-2 天 | ✅ 完成 |
| 2 | 台幣現金 CRUD | 1-2 天 | ✅ 完成 |
| 3 | 美股 + 價格 API | 2-3 天 | ⬜ 未開始 |
| 4 | 台股 | 1-2 天 | ⬜ 未開始 |
| 5 | 外幣 + 基金 + 加密貨幣 | 2-3 天 | ⬜ 未開始 |
| 6 | 分析功能 | 2-3 天 | ⬜ 未開始 |
| 7 | 進階功能（選做） | 未定 | ⬜ 未開始 |

---

## Phase 1: 基礎建設 ✅

**目標：** 專案骨架 + DB + 導航 + 主題

| 項目 | 狀態 | 產出檔案 |
|------|------|---------|
| Flutter 專案初始化 | ✅ | `wealth-track/pubspec.yaml` |
| 依賴安裝（drift, riverpod, go_router, fl_chart, uuid, intl） | ✅ | `pubspec.yaml` |
| Feature-first + Clean Architecture 目錄結構 | ✅ | `lib/` 28 個目錄 |
| sealed class Asset hierarchy + enums | ✅ | `lib/core/models/asset.dart` |
| Drift DB 6 張表 + mixin 共用欄位 | ✅ | `lib/core/database/` |
| Riverpod appDatabase provider | ✅ | `lib/core/providers/database_provider.dart` |
| go_router + BottomNav 3 tab（總覽/資產/設定） | ✅ | `lib/app/router.dart`, `shell_page.dart` |
| Material 3 主題（綠色系 seed） | ✅ | `lib/app/theme.dart` |
| build_runner code gen 通過 | ✅ | `.g.dart` 檔案 |
| flutter analyze 0 issues | ✅ | — |

**技術決策：**
- DB 表使用 `@DataClassName('XxxRow')` 避免與 domain model 命名衝突
- 價格過期分級工具：`lib/core/utils/staleness.dart`
- 幣別格式化工具：`lib/core/utils/currency.dart`（支援 12 種幣別）

---

## Phase 2: 台幣現金 CRUD ✅

**目標：** 第一條完整垂直切片，現金的增刪改查 + 首頁總額 + 圓餅圖

**對應需求：** 需求 1, 2, 3a, 4, 5, 6, 7

| 項目 | 狀態 | 產出檔案 |
|------|------|---------|
| Cash Repository（DB CRUD） | ✅ | `lib/features/cash/data/cash_repository.dart` |
| Cash Riverpod Providers（watchAll, total, byBank） | ✅ | `lib/features/cash/presentation/providers/cash_provider.dart` |
| 現金列表頁（依銀行分組 + 各銀行小計） | ✅ | `lib/features/cash/presentation/cash_list_page.dart` |
| 滑動刪除（含確認對話框） | ✅ | 同上 |
| 新增/編輯表單（名稱/銀行/幣別下拉/金額） | ✅ | `lib/features/cash/presentation/cash_form_page.dart` |
| Dashboard 總資產卡片 | ✅ | `lib/features/dashboard/presentation/widgets/total_value_card.dart` |
| 資產分布圓餅圖（依銀行） | ✅ | `lib/features/dashboard/presentation/widgets/allocation_pie_chart.dart` |
| Dashboard Providers（totalValue, assetAllocation） | ✅ | `lib/features/dashboard/presentation/providers/dashboard_provider.dart` |
| 路由：`/assets/cash/add` + `/assets/cash/edit/:id` | ✅ | `lib/app/router.dart` |
| flutter analyze 0 issues | ✅ | — |

**功能流程：**
1. 首頁（總覽 tab）顯示現金總額 + 銀行分布圓餅圖
2. 資產 tab 顯示現金列表，依銀行名稱分組
3. 點 FAB（+）→ 新增現金表單（名稱、銀行、幣別、金額）
4. 點任一筆現金 → 編輯表單
5. 左滑刪除，有確認對話框
6. 所有操作即時更新首頁和列表（Riverpod watch drift stream）

---

## Phase 3: 美股 + 價格 API ⬜

**目標：** 美股持倉 CRUD + Yahoo Finance 價格 API + 匯率換算

**對應需求：** 需求 1, 2, 3b, 7

| 項目 | 狀態 |
|------|------|
| 美股持倉 CRUD（代號/數量/成本/碎股） | ⬜ |
| Yahoo Finance API 串接（primary） | ⬜ |
| Alpha Vantage fallback | ⬜ |
| 本地快取 15 分鐘 | ⬜ |
| ExchangeRate-API 匯率串接 | ⬜ |
| 美股市值計算（USD→TWD） | ⬜ |
| 首頁更新：現金 + 美股總值 | ⬜ |
| 資產分布圓餅圖（現金 vs 美股） | ⬜ |
| 股票列表頁（當前價/成本/報酬率） | ⬜ |
| 價格過期分級標示 | ⬜ |

**技術重點：**
- Yahoo Finance unofficial API，台股用 `.TW` 後綴（如 `2330.TW`）
- API 快取策略：股票 15 min、匯率 24h
- 失敗時顯示上次快取價格 + 過期標示

---

## Phase 4: 台股 ⬜

**目標：** 台股 CRUD + TWSE API

**對應需求：** 需求 3b（台股部分）

| 項目 | 狀態 |
|------|------|
| 台股 CRUD（複用 StockAsset, market=TW） | ⬜ |
| Yahoo Finance `.TW` 查詢（共用美股 API code） | ⬜ |
| TWSE OpenAPI fallback | ⬜ |
| 首頁總資產 = 現金 + 美股(TWD) + 台股 | ⬜ |

---

## Phase 5: 外幣 + 基金 + 加密貨幣 ⬜

**目標：** 補齊所有資產類型

**對應需求：** 需求 3a-ii, 3c, 3d, 2

| 項目 | 狀態 |
|------|------|
| 外幣現金 CRUD + 匯率 API 換算 | ⬜ |
| 國內基金 CRUD（淨值手動輸入） | ⬜ |
| 加密貨幣 CRUD + CoinGecko API | ⬜ |
| 完整資產分布圓餅圖（全類型） | ⬜ |

**技術重點：**
- CoinGecko API：免費 30 req/min
- 基金無穩定 API，v1 手動輸入淨值
- API 快取：加密貨幣 5 min

---

## Phase 6: 分析功能 ⬜

**目標：** 走勢圖 + 報酬率（v1 成功標準之一）

| 項目 | 狀態 |
|------|------|
| 每日淨值快照記錄（首次開 app 時） | ⬜ |
| 資產總值 30 天走勢圖（fl_chart LineChart） | ⬜ |
| 各類資產報酬率計算 | ⬜ |
| 資產配置趨勢分析 | ⬜ |

---

## Phase 7: 進階功能（選做）⬜

**不在 v1 成功標準內**

| 項目 | 狀態 |
|------|------|
| 壓力測試 what-if 面板 | ⬜ |
| 加密備份（Google Drive / iCloud） | ⬜ |
| Widget 首頁小工具 | ⬜ |
| 深色模式 | ⬜ |
| 匯率變動影響分析 | ⬜ |

---

## 專案結構

```
wealth-track/              (repo root)
├── docs/
│   ├── Requirement.md     (原始需求)
│   ├── design.md          (設計文件 — 技術架構 source of truth)
│   └── progress.md        (本檔 — 開發進度)
├── wealth-track/          (Flutter app)
│   ├── lib/
│   │   ├── app/           (app.dart, router.dart, shell_page.dart, theme.dart)
│   │   ├── core/
│   │   │   ├── database/  (app_database.dart, tables/asset_tables.dart)
│   │   │   ├── models/    (asset.dart — sealed class hierarchy)
│   │   │   ├── providers/ (database_provider.dart)
│   │   │   └── utils/     (currency.dart, staleness.dart)
│   │   ├── features/
│   │   │   ├── dashboard/presentation/ (dashboard_page, widgets/, providers/)
│   │   │   ├── cash/      (data/cash_repository, presentation/cash_list_page, cash_form_page, providers/)
│   │   │   ├── stock/     (目錄已建，待 Phase 3 實作)
│   │   │   ├── fund/      (目錄已建，待 Phase 5 實作)
│   │   │   ├── crypto/    (目錄已建，待 Phase 5 實作)
│   │   │   ├── price/     (目錄已建，待 Phase 3 實作)
│   │   │   └── settings/  (settings_page — 版本資訊)
│   │   └── main.dart
│   ├── pubspec.yaml
│   └── test/
└── README.md
```

## 技術棧

| 層級 | 技術 | 版本 |
|------|------|------|
| 框架 | Flutter | 3.x (SDK ^3.11.4) |
| 本地 DB | drift | ^2.22.1 |
| 狀態管理 | flutter_riverpod + riverpod_annotation | ^2.6.1 |
| 路由 | go_router | ^14.8.1 |
| 圖表 | fl_chart | ^0.70.2 |
| Code Gen | build_runner + drift_dev + riverpod_generator | — |
| 測試 | flutter_test + mocktail | — |
