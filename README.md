# TecnoComponentes

## Pasos para Docker:

### Pasos para cargar
1. Tener docker instalado 
2. Ejecutar los comandos de iniciialización de bd
```bash
chmod +x server/database/scripts/init_script.sh
./server/database/scripts/init_script.sh
```

PRECAUCION: VERIFICAR SI EL PUERTO 3306

### Adicional
Iniciar el contenedor: "docker start tecomp_bd_container"

Parar el contenedor: "docker stop tecomp_bd_container"

### Información Importante

MYSQL_USER: mariadbuser, MYSQL_PASSWORD: mariadbuser
MYSQL_ROOT_PASSWORD: root
MYSQL_DATABASE: TecnoComponentes_BD

## React + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh

## Expanding the ESLint configuration

If you are developing a production application, we recommend using TypeScript with type-aware lint rules enabled. Check out the [TS template](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-react-ts) for information on how to integrate TypeScript and [`typescript-eslint`](https://typescript-eslint.io) in your project.

