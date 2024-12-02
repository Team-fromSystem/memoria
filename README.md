<div id="top"></div>

## 使用技術一覧


<p style="display: inline">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white">
  <img src="https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white">
  <img src="https://img.shields.io/badge/Unity-%23000000.svg?style=for-the-badge&logo=unity&logoColor=white"> 
</p>

## 目次

1. [プロジェクトについて](#プロジェクトについて)
2. [環境](#環境)
3. [ディレクトリ構成](#ディレクトリ構成)
4. [開発環境構築](#開発環境構築)

## プロジェクト名

memoria (メモリア)

## プロジェクトについて

- 第二回和歌山県イノベーションプログラミングコンテストへの提出用
- ARを使用して観光地での楽しみ方を増やすアプリです
- ARの部分の実装にunityを使用しています
  
コンテスト審査担当者様へ

事前にgitのsubmoduleを使用している旨を伝えさせていただいたのですが、
提出直前にてfirebase,unityに関連するversion関連の不具合が発覚し、修正を間に合わせることが叶わなかったため、
現時点ではflutterのプロジェクトリポジトリとunityのプロジェクトリポジトリを分割した状態で、それぞれを提出させて頂きます。
提出用のformに2本の動作動画Linkを添付致しましたので、ご確認お願いします。
  
 
<br />
<div align="left">
    <a href="https://github.com/Team-fromSystem/fromSystem_Unity"><strong>unity側のリポジトリ »</strong></a>
</div>
<br />


## 環境

| 言語・フレームワーク        | バージョン   |
| ---------------------   | ---------- |
| ・flutter 側             | ---------- |
|   flutter SDK           | 3.22.2     |
|   Dart                  | 3.5.4      |
|   flutter_unity_widget  | 2022.2.1   |
|   java                  | 17.0.11    |
|   gradle                | 8.5        |
|   fvm                   | 3.2.1      |
| ・unity 側               | ---------- |
|   unity                 | 2022.3.451f|
|   flutter_unity_widget  | 2022.2.0   |
| ・動作環境               | ---------- |
|   Android               | 13.0~      |
|   ios                   | 13~        |

unityとの互換性の問題で**flutterのバージョンをfvmを使用して下げています！**

その他のパッケージのバージョンは pubspec.yaml を参照してください

↓その他細かい情報
<pre>
 fvm flutter doctor -v
[√] Flutter (Channel stable, 3.22.2, on Microsoft Windows [Version 10.0.22631.4460], locale en-US)
    • Flutter version 3.22.2 on channel stable at C:\Users\Kousu\fvm\versions\3.22.2
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 761747bfc5 (6 months ago), 2024-06-05 22:15:13 +0200
    • Engine revision edd8546116
    • Dart version 3.4.3
    • DevTools version 2.34.3

[√] Windows Version (Installed version of Windows is version 10 or higher)

[√] Android toolchain - develop for Android devices (Android SDK version 35.0.0)
    • Android SDK at C:\Users\Kousu\AppData\Local\Android\Sdk
    • Platform android-35, build-tools 35.0.0
    • Java binary at: C:\Program Files\Microsoft\jdk-21.0.4.7-hotspot\bin\java
    • Java version OpenJDK Runtime Environment Microsoft-9889606 (build 21.0.4+7-LTS)
    • All Android licenses accepted.

[√] Chrome - develop for the web
    • Chrome at C:\Program Files\Google\Chrome\Application\chrome.exe

[X] Visual Studio - develop Windows apps
    X Visual Studio not installed; this is necessary to develop Windows apps.
      Download at https://visualstudio.microsoft.com/downloads/.
      Please install the "Desktop development with C++" workload, including all of its default components

[√] Android Studio (version 2024.1)
    • Android Studio at C:\Program Files\Android\Android Studio
    • Flutter plugin can be installed from:
       https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
       https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 17.0.11+0--11852314)

[√] VS Code (version 1.95.3)
    • VS Code at C:\Users\Kousu\AppData\Local\Programs\Microsoft VS Code
    • Flutter extension version 3.100.0

[√] Connected device (4 available)
    • SO 53B (mobile)   • QV785GJGA6 • android-arm64  • Android 13 (API 33)
    • Windows (desktop) • windows    • windows-x64    • Microsoft Windows [Version 10.0.22631.4460]
    • Chrome (web)      • chrome     • web-javascript • Google Chrome 129.0.6668.90
    • Edge (web)        • edge       • web-javascript • Microsoft Edge 131.0.2903.70

[√] Network resources
    • All expected network resources are available.
</pre>
  

<p align="right">(<a href="#top">トップへ</a>)</p>

## ディレクトリ構成

<pre>
.
│  firebase_options.dart
│  main.dart
│
├─backend
│  ├─fileDownloader
│  │      fileDownloader.dart
│  │
│  ├─models
│  │      event.dart
│  │      event.freezed.dart
│  │      event.g.dart
│  │
│  └─provider
│          booked_list.dart
│          booked_list.g.dart
│          favorite_list.dart
│          favorite_list.g.dart
│          provider_event.dart
│
├─common
│  │  banner_card.dart
│  │  booked_card.dart
│  │  dialogs.dart
│  │  favorite_card.dart
│  │  image_viewer_overlay.dart
│  │
│  └─bottomBar
│          account_overlay.dart
│          bottom_nav_bar.dart
│          selected_index.dart
│          selected_index.g.dart
│
├─pages
│      detail_page.dart
│      google_map_page.dart
│      home_page.dart
│      register_page.dart
│
└─utils
        event_period_checker.dart
        location_checker.dart
        location_permission_request.dart
        notification.dart
        notification_permission_request.dart
        weekday_converter.dart
</pre>

<p align="right">(<a href="#top">トップへ</a>)</p>

## 開発環境構築
- flutter側
- git clone git@github.com:Team-fromSystem/memoria.git 
   
- ターミナルで `flutter doctor -v`
  - flutterが最新の場合、お好きな方法でバージョンを3.22.2に下げてください
    - fvmの場合(https://zenn.dev/altiveinc/articles/flutter-version-management#dart%E3%81%A7%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
    - `fvm install 3.22.2`
    - `fvm list`
    - `fvm use 3.22.2`
- `flutter run`が通れば成功！

<p align="right">(<a href="#top">トップへ</a>)</p>
