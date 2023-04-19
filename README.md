![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
![IOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
<br/>
![Target](https://img.shields.io/badge/iOS-13.0-blue)
![Version](https://img.shields.io/badge/version-1.0.0-blue)
<br/>
![UIKit](https://img.shields.io/badge/-UIKit-blue)
![UIBezierPath](https://img.shields.io/badge/-UIBezierPath-blue)
![UITableViewDiffableDataSource](https://img.shields.io/badge/-UITableViewDiffableDataSource-blue)
![MVP](https://img.shields.io/badge/-MVP-blue)
![GCD](https://img.shields.io/badge/-GCD-blue)
![AutoLayout](https://img.shields.io/badge/-AutoLayout-blue)
<br/>
![URLSession](https://img.shields.io/badge/-URLSession-blue)
![REST](https://img.shields.io/badge/-REST-blue)
![ServerDrivenUI](https://img.shields.io/badge/-ServerDrivenUI-blue)

# Карты лояльности
Тестовое задание

## Description
Подгрузка данных происходит с сервера, с помощью REST. Реализована пагинация и кастомный активити индикатор с анимацией. При запросе данных, сервер случайным образом генерирует: идеальный ответ, ответ с ошибкой или долго отвечает на запрос. Реализована обработка ошибок, с возможностью повторного запроса из алерта. Как только данные на сервере заканчиваются, подгрузка данных прекращается и запроса новых больше не происходит.
<br/>
<br/>
По нажатию на одну из кнопок, отображается стандартный алерт с информацией о том, какая кнопка была нажата, и id компании, к которой относится эта карточка лояльности.
<br/>
<br/>
Цвета карточек приходят с сервера случайным образом.

### Описание используемых технологий
- Активити индикатор нарисован с помощью **UIBezierPath**.
- Многопоточность приложения построена на **GCD**.
- Приложение написано на архитектуре **MVP**.
- Работа с сетью происходит с помощью **REST**.
- Вместо стандартного data source у теблицы используется **UITableViewDiffableDataSource**
- Вёрстка итерфейса сделана полностью кодом с помощью **AutoLayout**
- Весь дизайн взят из ТЗ и реализован с помощью **pixel perfeсt**, так как размеров и шрифтов предоставлено не было.

## Installations
Clone and run project in Xcode 14 or newer

## Screenshots
<img src="https://github.com/ZyFun/LoyaltyCards/blob/main/Screenshots/Screenshot000.png" width="252" height="503" /> <img src="https://github.com/ZyFun/LoyaltyCards/blob/main/Screenshots/Screenshot001.png" width="252" height="503" /> <img src="https://github.com/ZyFun/LoyaltyCards/blob/main/Screenshots/Screenshot002.png" width="252" height="503" /> <img src="https://github.com/ZyFun/LoyaltyCards/blob/main/Screenshots/Screenshot003.png" width="252" height="503" />

## Demo
<img src="https://github.com/ZyFun/LoyaltyCards/blob/main/Demo/Demo000.gif" width="252" height="545" />

