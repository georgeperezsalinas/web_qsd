# QSD Soft — Static Web Site

Sitio web corporativo de QSD Soft. HTML estático con Nginx en Docker.

## Estructura

```
qsdsoft/
├── index.html        # Página principal (todo en un archivo)
├── Dockerfile        # Imagen Docker con nginx:alpine
├── nginx.conf        # Config optimizada (gzip, cache, security headers)
├── docker-compose.yml
└── README.md
```

## Deploy en VPS

### Opción 1 — Docker Compose (recomendado)

```bash
# 1. Sube los archivos a tu VPS
scp -r qsdsoft/ usuario@tu-vps:/opt/qsdsoft/

# 2. En el VPS
cd /opt/qsdsoft
docker compose up -d --build

# 3. Verifica
docker ps
curl http://localhost
```

### Opción 2 — Docker directo

```bash
docker build -t qsdsoft-web .
docker run -d --name qsdsoft-web --restart unless-stopped -p 80:80 qsdsoft-web
```

### Opción 3 — Con dominio + HTTPS (Traefik / Nginx Proxy Manager)

Descomenta las líneas `labels` en `docker-compose.yml` y ajusta el dominio.
Traefik gestionará el certificado SSL automáticamente con Let's Encrypt.

## Actualizar el sitio

```bash
# Edita index.html, luego:
docker compose up -d --build
```

## Personalización rápida

| Qué cambiar | Dónde |
|---|---|
| Colores de marca | Variables CSS `:root` en `index.html` |
| Logo (texto) | Busca `logo-mark` y `logo-text` |
| Datos de contacto | Busca `ventas@qsdsoft.com` / `+51 921459342` |
| Nombres de clientes | Busca `.client-logo` |
| Foto "Acerca de" | Reemplaza el `<i class="bi bi-building">` con `<img src="...">` |
| Servicios | Busca `.service-card` y edita los bloques |

## Imágenes propias

Coloca tus imágenes junto a `index.html` y referéncialas:

```html
<img src="foto-equipo.jpg" alt="Equipo QSD" class="img-fluid" />
```

Luego en el `Dockerfile` agrega:
```dockerfile
COPY assets/ /usr/share/nginx/html/assets/
```
