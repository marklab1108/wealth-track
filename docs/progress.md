# WealthTrack 開發進度

> 最後更新：2026-04-05

## 總覽

| Phase | 名稱 | 預估時間 | 狀態 |
|-------|------|---------|------|
| 1 | 基礎建設 | 1-2 天 | ✅ 完成 |
| 2 | 台幣現金 CRUD | 1-2 天 | ✅ 完成 |
| 3 | 美股 + 價格 API | 2-3 天 | ✅ 完成 |
| 4 | 台股 | 1-2 天 | ✅ 完成 |
| 5 | 外幣 + 基金 + 加密貨幣 | 2-3 天 | ✅ 完成 |
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

## Phase 3: 美股 + 價格 API ✅

**目標：** 美股持倉 CRUD + Yahoo Finance 價格 API + 匯率換算

**對應需求：** 需求 1, 2, 3b, 7

| 項目 | 狀態 | 產出檔案 |
|------|------|---------|
| Yahoo Finance API 服務（報價 + 股票名稱） | ✅ | `lib/features/price/data/yahoo_finance_service.dart` |
| ExchangeRate-API 匯率服務 | ✅ | `lib/features/price/data/exchange_rate_service.dart` |
| 匯率 DB 快取 Repository | ✅ | `lib/features/price/data/exchange_rate_repository.dart` |
| Price Providers（yahoo, fx service, usdToTwd） | ✅ | `lib/features/price/providers/price_provider.dart` |
| Stock Repository（CRUD + updatePrice） | ✅ | `lib/features/stock/data/stock_repository.dart` |
| Stock Providers（watchAll, refresh + RefreshResult） | ✅ | `lib/features/stock/presentation/providers/stock_provider.dart` |
| 刷新共用邏輯（失敗代號回報） | ✅ | `lib/features/stock/presentation/refresh_helper.dart` |
| 美股列表頁（名稱優先/代號副標/報酬率/過期標示） | ✅ | `lib/features/stock/presentation/stock_list_page.dart` |
| 美股新增/編輯表單（代號失焦自動帶入名稱） | ✅ | `lib/features/stock/presentation/stock_form_page.dart` |
| 資產 Tab 重構（TabBar: 現金/美股） | ✅ | `lib/features/dashboard/presentation/assets_tab_page.dart` |
| Dashboard 更新（總值 = 現金 + 美股 TWD） | ✅ | `lib/features/dashboard/presentation/dashboard_page.dart` |
| Dashboard 資產明細卡（現金/美股分列） | ✅ | 同上 |
| 圓餅圖改為依資產類型分布 | ✅ | `lib/features/dashboard/presentation/widgets/allocation_pie_chart.dart` |
| 總值卡片改為 async（等匯率） | ✅ | `lib/features/dashboard/presentation/widgets/total_value_card.dart` |
| 路由：`/assets/stock/add` + `/assets/stock/edit/:id` | ✅ | `lib/app/router.dart` |
| http 依賴安裝 | ✅ | `pubspec.yaml` |
| flutter analyze 0 issues | ✅ | — |

**功能流程：**
1. 首頁顯示總資產（現金 + 美股折合 TWD）+ 資產明細卡（分列現金/美股金額）+ 圓餅圖（依類型）
2. 首頁及美股 Tab 均有刷新按鈕 → 批次更新所有美股價格（Yahoo Finance API）
3. 刷新結果明確回報：成功幾支、失敗的代號列出（如代號打錯會提示）
4. 資產 Tab 用 TabBar 切換現金/美股，美股 Tab 右上角有刷新按鈕
5. 美股列表標題顯示股票名稱（如 Apple Inc.），副標題顯示代號 + 股數 + 均價
6. 點 FAB → 新增美股，輸入代號後離開欄位自動從 Yahoo Finance 帶入股票名稱
7. 編輯時更改代號，名稱會自動更新為新代號對應的股票名稱
8. 點任一筆 → 編輯，左滑刪除（含確認，顯示名稱+代號）
9. 刷新價格時：15 分鐘內的價格不重複抓取

**技術決策：**
- 使用 `http` 套件（非 dio），保持輕量
- Yahoo Finance Chart API（`/v8/finance/chart/{symbol}`）取得即時價格 + 股票名稱（`meta.shortName`）
- `StockQuote` 類別封裝 symbol / shortName / price，`getQuote()` 統一回傳
- ExchangeRate-API free tier（`open.er-api.com`）取 USD→TWD
- 匯率 DB 快取 24 小時，股票價格快取 15 分鐘
- API 失敗時 fallback 到最近一次快取價格
- `RefreshResult` 類別區分 updated / requested / failed，刷新後明確回報失敗代號
- `ref.invalidate()` 確保每次刷新都重新執行，不返回快取結果
- `refresh_helper.dart` 共用邏輯，首頁和美股 Tab 共用同一套刷新 + 通知
- Dashboard providers 改為 async（需等匯率 API），UI 加 loading indicator
- `fold<double>()` 顯式泛型避免 async 函式中型別推斷為 `FutureOr`
- 表單代號欄 `FocusNode` 監聽失焦事件，觸發 Yahoo Finance 自動查名稱
- 列表 UI 名稱優先、代號放副標題（消費級理財 App 設計慣例）
- Alpha Vantage fallback 留待後續需要時再加

---

## Phase 4: 台股 ✅

**目標：** 台股 CRUD + Yahoo Finance `.TW` 查詢

**對應需求：** 需求 3b（台股部分）

| 項目 | 狀態 | 產出檔案 |
|------|------|---------|
| TWSE MIS API 服務（即時報價+中文名稱，tse_/otc_ 自動偵測） | ✅ | `lib/features/price/data/twse_mis_service.dart` |
| TWSE OpenAPI 服務（上市公司中文簡稱 fallback） | ✅ | `lib/features/price/data/twse_service.dart` |
| TWSE MIS + TWSE + Yahoo 三層 provider | ✅ | `lib/features/price/providers/price_provider.dart` |
| `toYahooSymbol()` 工具（TW 加 `.TW` 後綴） | ✅ | `lib/features/stock/presentation/providers/stock_provider.dart` |
| `twStockAssetsProvider` 串流 | ✅ | 同上 |
| `refreshStockPrices` 支援雙市場（US + TW） | ✅ | 同上 |
| StockListPage 參數化（market, 幣別, 路由前綴） | ✅ | `lib/features/stock/presentation/stock_list_page.dart` |
| StockFormPage 參數化（market, TWD/USD, 代號格式） | ✅ | `lib/features/stock/presentation/stock_form_page.dart` |
| Assets Tab 3 tabs（現金/美股/台股） | ✅ | `lib/features/dashboard/presentation/assets_tab_page.dart` |
| Dashboard 資產明細 3 列（現金/美股/台股） | ✅ | `lib/features/dashboard/presentation/dashboard_page.dart` |
| Dashboard allocation 圓餅圖分 3 類 | ✅ | `lib/features/dashboard/presentation/providers/dashboard_provider.dart` |
| `usStockTotalTWD` + `twStockTotal` providers | ✅ | 同上 |
| 路由：`/assets/tw-stock/add` + `/assets/tw-stock/edit/:id` | ✅ | `lib/app/router.dart` |
| flutter analyze 0 issues | ✅ | — |

**功能流程：**
1. 資產 Tab 三個子頁：現金 / 美股 / 台股
2. 台股列表顯示名稱（如「台積電」）為標題，副標題為代號 + 股數 + 均價（NT$）
3. 新增台股：代號欄為數字鍵盤（如 2330），離開欄位從 TWSE MIS API 帶入中文名稱（涵蓋上市、上櫃、ETF），fallback TWSE 公司清單 → Yahoo Finance
4. 刷新按鈕：台股用 MIS API（~5 秒延遲），美股用 Yahoo Finance，各自 fallback
5. Dashboard 總資產 = 現金 + 美股(×匯率) + 台股，圓餅圖分 3 類顯示
6. TWSE OpenAPI fallback 留待後續需要時再加

**技術決策：**
- 複用 `StockAsset` + `StockRepository`，透過 `market` 欄位區分美股/台股
- `toYahooSymbol(symbol, market)` 統一處理 Yahoo API 代號格式
- `refreshStockPrices` 改為全市場掃描，`yahooToDb` Map 處理代號映射
- StockListPage / StockFormPage 參數化而非複製，避免重複程式碼
- 台股不需匯率換算，`twStockTotal` 為同步 provider
- 台股代號欄使用數字鍵盤（`TextInputType.number`），美股維持字母大寫
- **TWSE MIS API**（`mis.twse.com.tw/stock/api/getStockInfo.jsp`）：即時報價 + 中文名稱
  - 自動偵測 `tse_`（上市+ETF）和 `otc_`（上櫃），先試 tse 再試 otc
  - 批次查詢支援（`|` 分隔），一次請求更新所有台股
  - `z` 欄位取成交價，無交易時 fallback `y`（昨收）
- 台股名稱查詢優先順序：MIS API → TWSE 公司清單 → Yahoo Finance → 代號本身
- 台股價格刷新優先順序：MIS API → Yahoo Finance（`.TW`）
- MIS API 流量評估：個人用 ~20 支股票/15 分鐘 = 每小時 ~4 次批次請求，遠低於可負荷量
- TWSE 公司清單 24 小時記憶體快取，keepAlive provider 確保不被釋放

---

## Phase 5: 外幣 + 基金 + 加密貨幣 ✅

**目標：** 補齊所有資產類型，完整五類資產支援

**對應需求：** 需求 3a-ii, 3c, 3d, 2

| 項目 | 狀態 | 產出檔案 |
|------|------|---------|
| ExchangeRate 多幣別支援（一次 API 呼叫取全部匯率） | ✅ | `lib/features/price/data/exchange_rate_service.dart` |
| `allRatesToTwd` provider（USD 交叉匯率） | ✅ | `lib/features/price/providers/price_provider.dart` |
| CoinGecko API 服務（search + getPrices） | ✅ | `lib/features/price/data/coingecko_service.dart` |
| CoinGecko provider（keepAlive） | ✅ | `lib/features/price/providers/price_provider.dart` |
| Yahoo 基金淨值爬蟲服務（meta JSON 解析） | ✅ | `lib/features/price/data/yahoo_fund_service.dart` |
| Yahoo 基金 provider（keepAlive） | ✅ | `lib/features/price/providers/price_provider.dart` |
| 基金 Repository（CRUD + updateNavByFundCode） | ✅ | `lib/features/fund/data/fund_repository.dart` |
| 基金 Providers（watchAll, fundTotal, refreshFundPrices） | ✅ | `lib/features/fund/presentation/providers/fund_provider.dart` |
| 基金列表頁（名稱/代號/單位/淨值/報酬率） | ✅ | `lib/features/fund/presentation/fund_list_page.dart` |
| 基金新增/編輯表單（代號失焦自動帶入名稱，錯誤提示） | ✅ | `lib/features/fund/presentation/fund_form_page.dart` |
| 加密貨幣 Repository（CRUD + updatePrice） | ✅ | `lib/features/crypto/data/crypto_repository.dart` |
| 加密貨幣 Providers（watchAll, refreshCryptoPrices） | ✅ | `lib/features/crypto/presentation/providers/crypto_provider.dart` |
| 加密貨幣列表頁（名稱/代號/數量/價格/報酬率） | ✅ | `lib/features/crypto/presentation/crypto_list_page.dart` |
| 加密貨幣新增/編輯表單（代號自動帶入名稱） | ✅ | `lib/features/crypto/presentation/crypto_form_page.dart` |
| Asset model 補 returnRate getter（Fund + Crypto） | ✅ | `lib/core/models/asset.dart` |
| Dashboard 總值含全部五類資產 | ✅ | `lib/features/dashboard/presentation/providers/dashboard_provider.dart` |
| Dashboard 明細卡增加基金+加密貨幣列 | ✅ | `lib/features/dashboard/presentation/dashboard_page.dart` |
| Dashboard 圓餅圖分 5 類（現金/美股/台股/基金/加密貨幣） | ✅ | `lib/features/dashboard/presentation/providers/dashboard_provider.dart` |
| 資產 Tab 增至 5 tabs（含基金/加密貨幣） | ✅ | `lib/features/dashboard/presentation/assets_tab_page.dart` |
| 路由：fund/add, fund/edit, crypto/add, crypto/edit | ✅ | `lib/app/router.dart` |
| 刷新邏輯整合：股票+加密貨幣+基金同時刷新 | ✅ | `lib/features/stock/presentation/refresh_helper.dart` |
| 外幣現金匯率轉換（Dashboard 正確計算） | ✅ | `lib/features/dashboard/presentation/providers/dashboard_provider.dart` |
| flutter analyze 0 issues | ✅ | — |

**功能流程：**
1. 資產 Tab 五個子頁：現金 / 美股 / 台股 / 基金 / 加密貨幣（可滑動 TabBar）
2. 基金列表顯示名稱為標題，副標題為基金代號 + 持有單位數 + 均價，右側顯示淨值 + 報酬率
3. 新增基金：輸入 Yahoo 基金代號（如 `F000014SAX:FO`）後離開欄位自動從 Yahoo 台灣帶入名稱；代號查不到會顯示錯誤提示
4. 加密貨幣列表顯示名稱為標題，副標題為代號 + 數量 + 均價（USD），右側顯示價格 + 報酬率
5. 新增加密貨幣：輸入代號（BTC）後離開欄位自動從 CoinGecko 帶入名稱（Bitcoin）
6. 刷新按鈕：同時更新股票（MIS + Yahoo）、加密貨幣（CoinGecko）和基金淨值（Yahoo 台灣爬蟲），合併回報結果
7. Dashboard 總資產 = 現金(含外幣匯率轉換) + 美股(×USD匯率) + 台股 + 基金 + 加密貨幣(×USD匯率)
8. 圓餅圖分 5 類顯示：現金 / 美股 / 台股 / 基金 / 加密貨幣

**技術決策：**
- **ExchangeRate 多幣別支援**：單次 API 呼叫 `open.er-api.com/v6/latest/USD` 取得所有匯率，透過 USD 交叉匯率計算 X→TWD = USD→TWD / USD→X，一次呼叫覆蓋 12 種幣別
- `allRatesToTwd` provider 取代原本的 `usdToTwd` 為底層實作，`usdToTwd` 改為從 `allRatesToTwd` 讀取
- 現金 Dashboard 正確處理外幣：`cashTotalTWD` provider 使用 `CashAsset.valueTWD(rates)` 換算
- **CoinGecko API**（`api.coingecko.com/api/v3`）：免費 30 req/min
  - `/search?query={symbol}`：查代號帶入名稱 + 取得 CoinGecko ID
  - `/simple/price?ids={ids}&vs_currencies=usd`：批次價格查詢
  - In-memory `_idCache`：symbol→id 映射快取，避免重複搜尋
- 加密貨幣價格快取 5 分鐘（設計文件規定）
- **Yahoo 基金淨值爬蟲**（`tw.stock.yahoo.com/fund/{code}/summary`）：
  - 從 HTML 內嵌 `meta` JSON 解析基金名稱、淨值、日期
  - 代號為 Yahoo/Morningstar fund ID（如 `F000014SAX:FO`），使用者從 Yahoo 股市 URL 取得
  - `getQuotes()` 並行批次查詢多檔基金
  - 基金淨值快取 4 小時（每日僅更新一次，無需頻繁刷新）
- 基金表單代號欄 `FocusNode` 監聽失焦事件，觸發 Yahoo 自動查名稱；查無代號顯示 SnackBar 錯誤提示
- 基金表單不顯示淨值欄位（與股票/加密貨幣一致），淨值由刷新按鈕自動從 Yahoo 取得
- `FundAsset` 和 `CryptoAsset` 都加上 `returnRate` getter，公式同 `StockAsset`
- `refreshAndNotify` 整合：同時 `Future.wait` 股票、加密貨幣和基金刷新，合併 `RefreshResult`
- Assets Tab 使用 `isScrollable: true` + `TabAlignment.start` 以容納 5 tabs
- 刷新按鈕在美股/台股/基金/加密貨幣 tab 顯示，現金不顯示

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
│   │   │   ├── dashboard/presentation/ (dashboard_page, assets_tab_page, widgets/, providers/)
│   │   │   ├── cash/      (data/cash_repository, presentation/cash_list_page, cash_form_page, providers/)
│   │   │   ├── stock/     (data/stock_repository, presentation/stock_list_page, stock_form_page, refresh_helper, providers/)
│   │   │   ├── price/     (data/yahoo_finance_service, yahoo_fund_service, exchange_rate_service, exchange_rate_repository, coingecko_service, providers/)
│   │   │   ├── fund/      (data/fund_repository, presentation/fund_list_page, fund_form_page, providers/)
│   │   │   ├── crypto/    (data/crypto_repository, presentation/crypto_list_page, crypto_form_page, providers/)
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
| HTTP | http | ^1.2.2 |
| 圖表 | fl_chart | ^0.70.2 |
| Code Gen | build_runner + drift_dev + riverpod_generator | — |
| 測試 | flutter_test + mocktail | — |
