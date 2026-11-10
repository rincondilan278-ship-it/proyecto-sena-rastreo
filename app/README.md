# Rastreo Ambiental — React + Node + MySQL

Este proyecto convierte la interfaz HTML/CSS/JS original a React + TypeScript y reemplaza los dos PHP (`login.php` y `register.php`) por una API Node/Express.

## 1. Instalar

```bash
npm install
```

## 2. Configurar MySQL

La API espera por defecto:

- Base de datos: `rastreo_ambiental`
- Usuario: `root`
- Contraseña: vacía
- Host: `localhost`

Si tus datos son diferentes, copia `.env.example` como `.env` y cámbialos.

La API usa las tablas que ya utilizaba el PHP original:

- `usuario`
- `ciudadano`
- `funcionario`
- `administrador`
- `conductor`

## 3. Ejecutar

Terminal 1:

```bash
npm run server
```

Terminal 2:

```bash
npm run dev
```

O ambas:

```bash
npm run dev:all
```

Frontend: http://localhost:5173  
API: http://localhost:3000/api/health

## 4. Rutas principales

- `/`
- `/login`
- `/register`
- `/terms`
- `/administrador/dashboard`
- `/ciudadano/dashboard`
- `/conductor/dashboard`
- `/funcionario/dashboard`

## Nota

Las páginas HTML que estaban vacías en el proyecto original se dejaron como módulos React preparados, para que no desaparezcan y para que los enlaces no queden rotos.

Las funciones de camiones, alertas, horarios, reportes, configuración y geolocalización que ya existían en JavaScript fueron trasladadas a estados y eventos de React.

El siguiente paso natural es conectar cada módulo CRUD con MySQL mediante nuevos endpoints de la API.
