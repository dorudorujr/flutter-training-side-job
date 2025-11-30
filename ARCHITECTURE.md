# アーキテクチャ設計書

本プロジェクトでは、Riverpodを使用した状態管理とクリーンアーキテクチャの原則に基づいたレイヤー構造を採用しています。

## 目次

- [レイヤー構造](#レイヤー構造)
- [依存関係図](#依存関係図)
- [各レイヤーの詳細](#各レイヤーの詳細)
- [データフロー](#データフロー)

## レイヤー構造

```
lib/
├── data/                          # Data層
│   ├── data_sources/             # データソース（外部APIとの通信）
│   │   └── weather_data_source.dart
│   └── repositories/             # リポジトリ（データ取得とUI状態管理）
│       ├── weather_repository.dart
│       └── weather_ui_state_repository.dart
├── domain/                        # Domain層
│   └── use_cases/                # ユースケース（ビジネスロジック）
│       └── fetch_weather_use_case.dart
├── models/                        # モデル（データ構造）
│   ├── weather_request.dart
│   └── weather_response.dart
├── presentation/                  # Presentation層
│   ├── ui_state/                 # UI状態の定義
│   │   └── weather_page_ui_state.dart
│   └── providers/                # UI用のProvider
│       └── weather_page_ui_state_provider.dart
└── weather_screen.dart            # UI層（Widget）
```

## 依存関係図

以下は、Riverpodの`riverpod_graph`ツールを使用して自動生成されたProvider依存関係図です。

![Provider依存関係図](./riverpod_graph.html)

HTMLファイルをブラウザで開くと、インタラクティブな依存関係図を確認できます。

### 主要なProvider間の依存関係

```
WeatherScreen (Widget)
    ↓ watch
weatherPageUiStateProvider
    ↓ watch
weatherUiStateRepositoryProvider (Notifier)
    ↑ notifier を使用
fetchWeatherUseCaseProvider
    ↓ watch
weatherRepositoryProvider
    ↓ watch
weatherDataSourceProvider
```

## 各レイヤーの詳細

### 1. Data Source層

**責務**: 外部APIとの通信

#### `WeatherDataSource`
- `YumemiWeather` APIをラップ
- JSON文字列の送受信を担当

```dart
class WeatherDataSource {
  String fetchWeather(String requestJson);
}
```

**Provider**: `weatherDataSourceProvider`

---

### 2. Repository層

**責務**: データの取得・変換とUI状態の管理

#### `WeatherRepository`
- データソースを使用して天気情報を取得
- リクエスト/レスポンスのJSON変換
- ドメインモデル（`WeatherResponse`）への変換

```dart
class WeatherRepository {
  WeatherResponse fetchWeather({
    required String area,
    required DateTime date,
  });
}
```

**Provider**: `weatherRepositoryProvider`

#### `WeatherUiStateRepository`
- UI状態（`WeatherPageUiState`）の管理
- ローディング状態、エラー状態、天気情報の更新

```dart
@Riverpod(keepAlive: true)
class WeatherUiStateRepository extends _$WeatherUiStateRepository {
  void updateWeather(...);
  void setLoading({required bool isLoading});
  void setError(String errorMessage);
  void clearError();
}
```

**Provider**: `weatherUiStateRepositoryProvider` (NotifierProvider)

**keepAlive: true を使用する理由**:
- 画面遷移時に状態を保持
- アプリ全体で共有される状態
- 意図しない再初期化を防ぐ

---

### 3. UseCase層

**責務**: ビジネスロジックの実行

#### `FetchWeatherUseCase`
- 天気情報取得の処理フロー全体を管理
- Repository層を組み合わせてビジネスロジックを実現
- エラーハンドリング

```dart
class FetchWeatherUseCase {
  Future<void> execute() async {
    // 1. ローディング開始
    // 2. Repository から天気データを取得
    // 3. UI状態を更新（成功/失敗）
  }
}
```

**Provider**: `fetchWeatherUseCaseProvider`

**依存関係**:
- `weatherRepositoryProvider` (天気データ取得)
- `weatherUiStateRepositoryProvider.notifier` (UI状態更新)

---

### 4. Presentation層

**責務**: UI向けのデータ提供

#### `WeatherPageUiState`
- Freezedを使用したimmutableなデータクラス
- 天気情報、ローディング状態、エラーメッセージを保持

```dart
@freezed
class WeatherPageUiState with _$WeatherPageUiState {
  const factory WeatherPageUiState({
    String? weatherCondition,
    int? minTemperature,
    int? maxTemperature,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _WeatherPageUiState;
}
```

#### `weatherPageUiStateProvider`
- `weatherUiStateRepositoryProvider`のstateを公開
- UI層からはこのProviderを監視

```dart
@riverpod
WeatherPageUiState weatherPageUiState(Ref ref) {
  return ref.watch(weatherUiStateRepositoryProvider);
}
```

---

### 5. UI層（Widget）

**責務**: ユーザーインターフェースの表示

#### `WeatherScreen`
- `ConsumerWidget`を継承
- `weatherPageUiStateProvider`を監視してUIを構築
- `fetchWeatherUseCaseProvider`を使用して天気取得を実行

```dart
class WeatherScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(weatherPageUiStateProvider);

    // UI構築...

    // リロードボタン
    onPressed: () {
      unawaited(
        ref.read(fetchWeatherUseCaseProvider).execute(),
      );
    }
  }
}
```

## データフロー

### 天気情報取得フロー

1. **ユーザーアクション**: Reloadボタンをタップ
   ```dart
   ref.read(fetchWeatherUseCaseProvider).execute()
   ```

2. **UseCase実行**: `FetchWeatherUseCase.execute()`
   - ローディング状態をtrueに設定
   ```dart
   weatherUiStateRepository.setLoading(isLoading: true);
   ```

3. **データ取得**: `WeatherRepository.fetchWeather()`
   - リクエストを作成
   - DataSourceを通じてAPIを呼び出し
   - レスポンスを変換

4. **UI状態更新**:
   - 成功時: `weatherUiStateRepository.updateWeather(...)`
   - 失敗時: `weatherUiStateRepository.setError(...)`

5. **UI再描画**: `weatherPageUiStateProvider`を監視しているWidgetが自動的に再描画

### 依存方向

```
UI層
  ↓ (使用)
Presentation層
  ↓ (監視)
Repository層 (UI State)
  ↑ (更新)
UseCase層
  ↓ (使用)
Repository層 (Data)
  ↓ (使用)
Data Source層
```

### 注意点

- **上位レイヤーは下位レイヤーに依存するが、逆はない**
- **UIはUseCaseを通じてビジネスロジックを実行**（直接Repositoryを呼ばない）
- **状態管理はWeatherUiStateRepositoryに集約**
