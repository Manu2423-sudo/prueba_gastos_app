# Control de Gastos - Flutter App  

Control de Gastos es una aplicación móvil desarrollada en **Flutter** que permite registrar, visualizar y gestionar gastos personales. Se conecta a una **API REST**, autenticacion, almacenamiento local para modo offline y validaciones en los formularios.

---

##  Características
-  **Autenticación con JWT** (sin Firebase).
-  **Registro y consulta de gastos** conectándose a una API REST.
-  **Modo offline**: Guarda gastos en almacenamiento local y sincroniza cuando hay conexión.
-  **Validaciones en formulario** (campos obligatorios, monto numérico y mayor a 0).
-  **Gestión del estado con Bloc** para mejor rendimiento y separación de lógica de negocio.

---

##  Tecnologías utilizadas
- **Flutter** (Dart)
- **Dio** (Para llamadas a la API REST)
- **SharedPreferences** (Para autenticación y almacenamiento local)
- **SQLite** (Para almacenamiento offline)
- **Flutter Bloc** (Gestión del estado)

---

## 📲 Instalación y ejecución

### 🔹 1. Clonar el repositorio
```  
