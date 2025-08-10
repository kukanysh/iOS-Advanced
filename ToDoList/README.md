# 📋 To-Do List App (VIPER + Core Data)

A simple yet scalable To-Do List application built using **Swift**, **SwiftUI**, and **VIPER architecture** with **Core Data** for persistent storage.  
The project follows a clean architecture approach to ensure testability, maintainability, and separation of concerns.

---

## 🚀 Features
- **Add new tasks** with title and details
- **Mark tasks as completed**
- **Edit and delete tasks**
- **Persistent storage** using Core Data
- **VIPER architecture** for clean modular code
- **SwiftUI** for modern and responsive UI

---

## 🏗 Architecture

The app uses the **VIPER pattern**:
- **V**iew: SwiftUI views for UI representation
- **I**nteractor: Handles business logic (fetching, saving, updating tasks)
- **P**resenter: Connects View and Interactor, formats data for display
- **E**ntity: Core Data model (`ToDoModel`) and plain Swift structs (`ToDoEntity`)
- **R**outer: Handles navigation and screen transitions

---

## 🗄 Data Persistence

**Core Data** is used to store tasks locally.  
Core Data entities:
- `ToDoModel` (Core Data entity) — stores title, details, completion status, and creation date
- `ToDoEntity` (Plain Swift struct) — used for communication between layers

---

## 🖼 Logo
<img width="256" height="256" alt="AppIcon~ios-marketing" src="https://github.com/user-attachments/assets/b6e22853-19ce-43be-9967-7474964388b0" />
---


## 🖼 Screenshots
<img width="402" height="874" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-11 at 02 45 13" src="https://github.com/user-attachments/assets/620a17d1-2320-40a8-b4b3-199bbbd1575b" />
<img width="402" height="874" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-11 at 02 49 53" src="https://github.com/user-attachments/assets/9647503c-b8fc-4002-8301-1415c56097cb" />
<img width="402" height="874" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-11 at 02 45 17" src="https://github.com/user-attachments/assets/bb8953d6-22ab-4f0b-9484-72d804c67ab2" />
---
