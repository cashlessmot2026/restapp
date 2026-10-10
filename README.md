# Menú Digital · Golden Crunch · Mar & Sabor · La Famiglia

PWA en React (un solo código, sin compilación) conectada a Supabase.

| Página | URL | Qué hace |
|---|---|---|
| Menú con botones | `/` | 3 botones con los logos; cada uno abre su carta con sus colores. El cliente arma el pedido (opciones, pizzas por mitades, bordes, adicionales, bebidas) y genera un ticket virtual para el mesero. |
| Mesero IA | `/ia/` | "Leo", mesero virtual con Google Gemini (voz y texto). Recomienda platos de la carta real, ofrece adicionales y genera el ticket. |
| Admin (oculto) | `/admin/` | Productos, precios, categorías, adicionales, bordes, colores, pedidos, ajustes de la IA, códigos QR y contraseña. |

- Pizzas por mitades: se cobra el valor de la mitad más cara.
- La API key de Gemini y la contraseña del admin viven solo en la base de datos (tablas privadas con RLS); la IA se llama desde Postgres (`ai_chat`).
- Códigos QR listos en `assets/qr/` (también se generan por mesa desde `/admin` → Códigos QR).
- Esquema de base de datos: `supabase/schema.sql` y carga inicial `supabase/seed.sql`.
