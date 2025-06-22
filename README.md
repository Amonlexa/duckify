# Duckify - Манок для уток 🦆

<img src="screenshots/screen_1.jpg" width="120" align="right">
<img src="screenshots/screen_2.jpg" width="120" align="right">
<img src="screenshots/screen_3.jpg" width="120" align="right">
<img src="screenshots/screen_4.jpg" width="120" align="right">



Приложение-манок для охоты на уток с коллекцией аудиозаписей птичьих голосов.  
Реализовано на Flutter с использованием BLoC/Cubit для управления состоянием.

[![Flutter](https://img.shields.io/badge/Flutter-3.13+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.1+-blue.svg)](https://dart.dev)

## 📱 Основные функции

- Воспроизведение аудиозаписей манков
- Разделение по категориям уток
- Фоновая работа аудио
- Системные медиа-уведомления

## 🏗️ Архитектура
MVC - Model View Controller

## 🛠️ Технологии

- **Аудио**: `just_audio` + `audio_service` для фонового воспроизведения
- **Стейт-менеджмент**: `flutter_bloc` + `cubit`
- **Для файловой системы**: `path_provider`
- **Для сравнения моделей и процедур**: `equatable`
