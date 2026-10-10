-- =========================================================
-- Carga inicial del menú (transcrito de las cartas originales).
-- Solo se ejecuta si la tabla restaurants está vacía.
-- Bebidas, adicionales de Golden/La Famiglia y borde de queso
-- NO aparecen en las cartas: son valores iniciales para editar en /admin.
-- =========================================================
do $seed$
begin
if exists (select 1 from public.restaurants) then
  raise notice 'Menú ya cargado, no se modifica.';
  return;
end if;

insert into public.restaurants (id, name, tagline, logo, menu_image, colors, sort) values
('golden', 'Golden Crunch', 'Urban Food · Burgers | Sándwiches | Bites | Fries',
 'assets/logos/golden.png', 'assets/menus/golden.jpg',
 '{"bg":"#0b0a08","card":"#17140f","primary":"#D4A537","secondary":"#F5D77E","accent":"#B8862B","text":"#f7f0e1","muted":"#b9aa8c","onPrimary":"#1a1206"}', 1),
('marysabor', 'Mar & Sabor', 'Sea Food · Del mar a tu mesa',
 'assets/logos/marysabor.png', 'assets/menus/marysabor.jpg',
 '{"bg":"#FBF6EE","card":"#ffffff","primary":"#1B3A6B","secondary":"#4A90C2","accent":"#E8505B","text":"#16294d","muted":"#5f6f8c","onPrimary":"#ffffff"}', 2),
('famiglia', 'La Famiglia', 'Pizzeria Italiana · Tradizione · Sapore · Amore',
 'assets/logos/famiglia.png', 'assets/menus/famiglia.jpg',
 '{"bg":"#F6F0E2","card":"#fffaf0","primary":"#22331f","secondary":"#B08D3E","accent":"#B3261E","text":"#1d2a22","muted":"#6b6a55","onPrimary":"#fffaf0"}', 3);

insert into public.categories (restaurant_id, name, note, sort) values
('golden','Hamburguesas','Todas nuestras hamburguesas vienen acompañadas de papas a la francesa · Carne artesanal 100% res',1),
('golden','Sándwiches','',2),
('golden','Bowls de papa a la francesa','Con toppings individuales',3),
('golden','Porciones','',4),
('golden','Golden Kids','¡Elige tu favorita y disfruta!',5),
('golden','Bebidas','',6),
('marysabor','Entradas','',1),
('marysabor','Arroces','',2),
('marysabor','Pastas','',3),
('marysabor','Fuertes','',4),
('marysabor','Otros','',5),
('marysabor','Acompañamientos y extras','',6),
('marysabor','Bebidas','',7),
('famiglia','Pizzas','¿No te decides? Pídela por mitades: dos sabores, una sola pizza (se cobra la mitad de mayor valor).',1),
('famiglia','Lasagnas','',2),
('famiglia','Sandwich Pizza','',3),
('famiglia','Bebidas','',4);

insert into public.products (restaurant_id, category_id, name, description, price, options, allow_half, tags, sort)
select v.rest, c.id, v.name, v.descr, v.price, v.opts::jsonb, v.half, v.tags, v.sort
from (values
 -- ===== GOLDEN CRUNCH =====
 ('golden','Hamburguesas','Golden Classic','Salsa de la casa, carne artesanal, lechuga, tomate, tocineta y cebolla. Incluye papas a la francesa.',43000,'[]',false,'hamburguesa res tocineta clasica',1),
 ('golden','Hamburguesas','Big Crunch','Carne artesanal, salsa especial agridulce, crocante de tocineta, cebolla crunch y lechuga. Incluye papas a la francesa.',45000,'[]',false,'hamburguesa res agridulce crocante',2),
 ('golden','Hamburguesas','Golden Smash Deluxe','Doble carne artesanal, cheddar, cebolla grillada, tocineta y salsa de la casa. Incluye papas a la francesa.',48000,'[]',false,'hamburguesa doble carne cheddar',3),
 ('golden','Hamburguesas','Golden Master Blue','Carne artesanal, queso provolone, salsa de queso azul con champiñones y tocineta. Incluye papas a la francesa.',48000,'[]',false,'hamburguesa queso azul champiñones provolone',4),
 ('golden','Sándwiches','Golden Pulled Pork','Cerdo cocinado en una reducción de salsa a lo isla, queso mozarella y cebolla grillada.',45000,'[]',false,'sandwich cerdo pulled pork',1),
 ('golden','Sándwiches','Golden Carnes','Jamón de pavo, salami, peperoni, lechuga morada en reducción balsámica, tomates asados, cebolla, queso provolone, queso crema y salsa de queso azul.',48000,'[]',false,'sandwich carnes frias',2),
 ('golden','Sándwiches','Gold Pollo Crispi','Pechuga apanada o a la plancha, lechuga, tocineta, pimentón y cebolla grillada, tomate, queso crema y salsa de la casa.',48000,'[{"name":"Pechuga","choices":["Apanada","A la plancha"]}]',false,'sandwich pollo',3),
 ('golden','Bowls de papa a la francesa','Bowl Pulled Pork','Papas a la francesa con pulled pork y salsa BBQ.',40000,'[]',false,'papas bowl cerdo bbq',1),
 ('golden','Bowls de papa a la francesa','Bowl Pollo Crispi','Papas a la francesa con pollo crispi y salsa especial de la casa agridulce.',40000,'[]',false,'papas bowl pollo',2),
 ('golden','Bowls de papa a la francesa','Bowl Queso Cheddar con Tocineta','Papas a la francesa con queso cheddar derretido y tocineta crujiente.',40000,'[]',false,'papas bowl queso tocineta',3),
 ('golden','Porciones','Porción de Deditos (10 unidades)','Deditos de queso o bocadillo, 10 unidades.',20000,'[{"name":"Relleno","choices":["Queso","Bocadillo"]}]',false,'deditos picar compartir',1),
 ('golden','Porciones','Porción de Empanadas (10 unidades)','10 empanadas acompañadas de ají o ahogado.',20000,'[{"name":"Salsa","choices":["Ají","Ahogado"]}]',false,'empanadas picar compartir',2),
 ('golden','Golden Kids','Golden Kids','Hamburguesa con carne artesanal, queso cheddar y tocineta, papas a la francesa y jugo de cajita.',39000,'[]',false,'niños kids hamburguesa',1),
 ('golden','Bebidas','Gaseosa','Gaseosa personal.',6000,'[]',false,'bebida',1),
 ('golden','Bebidas','Agua','Agua personal.',5000,'[]',false,'bebida',2),
 ('golden','Bebidas','Limonada natural','Limonada natural.',8000,'[]',false,'bebida',3),
 ('golden','Bebidas','Jugo natural','Jugo natural en agua.',9000,'[]',false,'bebida',4),
 -- ===== MAR & SABOR =====
 ('marysabor','Entradas','Fruta de pan con alioli de jengibre y ají isleño de la casa','Fruta de pan dorada, servida con alioli de jengibre y ají isleño de la casa.',15000,'[]',false,'entrada isleña',1),
 ('marysabor','Entradas','Fishball en salsa isleña','Bolas de pescado en salsa isleña, acompañadas de papa casco.',30000,'[]',false,'entrada pescado',2),
 ('marysabor','Entradas','Camarones estilo popcorn','Camarones crujientes estilo popcorn, acompañados con alioli de jengibre y cascos de limón.',38000,'[]',false,'entrada camarones',3),
 ('marysabor','Entradas','Canastas ahogadas en camarón de fruta de pan o plátano','Canastas rellenas de camarón con salsa isleña, crocante de parmesano, alioli de jengibre y limón. Fruta de pan o plátano según temporada.',38000,'[{"name":"Canasta","choices":["Fruta de pan","Plátano"]}]',false,'entrada camarones',4),
 ('marysabor','Arroces','Arroz de camarón','Camarones salteados con vegetales, arroz aromático en leche de coco y toque de la casa.',45000,'[]',false,'arroz camarones coco',1),
 ('marysabor','Arroces','Arroz de langostinos cremoso','Langostinos en salsa cremosa de tres quesos y cebolla blanca, con arroz especial.',60000,'[]',false,'arroz langostinos cremoso',2),
 ('marysabor','Arroces','Arroz mixto caldoso','Mezcla de mariscos frescos en caldo saborizado, con arroz al punto y mucho sabor.',60000,'[]',false,'arroz mariscos caldo',3),
 ('marysabor','Pastas','Pasta camarón y calamar','Pasta de camarón y calamar en salsa blanca a base de leche de coco, parmesano y aceite de albahaca, con crocante de parmesano.',45000,'[]',false,'pasta camarones calamar',1),
 ('marysabor','Pastas','Pasta ajillo camarón y langostino','Pasta salteada en mantequilla, ajo, vino blanco, tomates cherry y perejil, con opción de camarón y langostino.',51000,'[]',false,'pasta ajo camarones langostinos',2),
 ('marysabor','Pastas','Pasta Red Sea','Mix de tres mariscos salteados en aceite de coco, en salsa napolitana con leche de coco y albahaca.',65000,'[]',false,'pasta mariscos',3),
 ('marysabor','Fuertes','Filete ajillo / plancha','Filete de pescado a la plancha con salsa de ajo y perejil.',65000,'[{"name":"Preparación","choices":["Al ajillo","A la plancha"]}]',false,'pescado filete',1),
 ('marysabor','Fuertes','Salmón ajillo','Salmón a la plancha en salsa de ajo, mantequilla y hierbas frescas.',70000,'[]',false,'salmon',2),
 ('marysabor','Fuertes','Filete Caribe','Pescado apanado en salsa isleña, con mix verde y vinagreta, acompañado de un acompañante a elección: arroz de coco, ensalada o vegetales salteados.',75000,'[{"name":"Acompañante","choices":["Arroz de coco","Ensalada","Vegetales salteados"]}]',false,'pescado apanado isleño',3),
 ('marysabor','Fuertes','Salmón beurre blanc','Salmón a la plancha con delicada salsa beurre blanc de vino blanco y cítricos.',75000,'[]',false,'salmon',4),
 ('marysabor','Otros','Ensalada Mar y Sabor','Ensalada de la casa con tres tipos de mariscos a la parrilla, mix de verdes, tomates cherry, aceitunas, vinagreta de albahaca, aceite de coco y limón, parmesano, alioli de jengibre y cebolla encurtida.',45000,'[]',false,'ensalada mariscos saludable',1),
 ('marysabor','Otros','Marea Burguer Mini x2','Mini hamburguesas x2 de camarones, con salsa especial, blend de queso provolone y cheddar, mix de verdes, tomate y cebolla encurtida en flor de Jamaica, acompañadas de papa casco con alioli de jengibre.',48000,'[]',false,'hamburguesa camarones',2),
 ('marysabor','Acompañamientos y extras','Vegetales calientes','',10000,'[]',false,'acompañamiento',1),
 ('marysabor','Acompañamientos y extras','Ensalada','',10000,'[]',false,'acompañamiento',2),
 ('marysabor','Acompañamientos y extras','Papa casco','',10000,'[]',false,'acompañamiento',3),
 ('marysabor','Acompañamientos y extras','Porción de arroz de coco blanco','',10000,'[]',false,'acompañamiento',4),
 ('marysabor','Bebidas','Gaseosa','Gaseosa personal.',6000,'[]',false,'bebida',1),
 ('marysabor','Bebidas','Agua','Agua personal.',5000,'[]',false,'bebida',2),
 ('marysabor','Bebidas','Limonada de coco','Limonada de coco.',12000,'[]',false,'bebida',3),
 ('marysabor','Bebidas','Jugo natural','Jugo natural en agua.',9000,'[]',false,'bebida',4),
 -- ===== LA FAMIGLIA =====
 ('famiglia','Pizzas','Pizza Margherita','Salsa napolitana, mozzarella fresca, tomate, albahaca y aceite de oliva.',45000,'[]',true,'pizza clasica vegetariana',1),
 ('famiglia','Pizzas','Pizza Hawaiana','Salsa napolitana, mozzarella, jamón y piña.',45000,'[]',true,'pizza dulce',2),
 ('famiglia','Pizzas','Pizza Vegetariana','Salsa napolitana, mozzarella, pimientos, champiñones, cebolla, aceitunas y albahaca.',45000,'[]',true,'pizza vegetariana',3),
 ('famiglia','Pizzas','Pizza Jamón y Queso','Salsa napolitana, mozzarella y jamón.',45000,'[]',true,'pizza',4),
 ('famiglia','Pizzas','Pizza La Tropical','Salsa napolitana, mozzarella, pepperoni, piña y albahaca.',48000,'[]',true,'pizza dulce',5),
 ('famiglia','Pizzas','Pizza Pepperoni','Salsa napolitana, mozzarella y pepperoni.',50000,'[]',true,'pizza',6),
 ('famiglia','Pizzas','Pizza Pollo y Pesto','Salsa napolitana, mozzarella, pollo desmechado, pesto y queso azul.',55000,'[]',true,'pizza pollo',7),
 ('famiglia','Pizzas','Pizza Pollo y Champiñones','Salsa napolitana, mozzarella, pollo desmechado, champiñones y orégano.',50000,'[]',true,'pizza pollo',8),
 ('famiglia','Pizzas','Pizza Carnes','Salsa napolitana, mozzarella, pepperoni, jamón de cerdo, pollo desmechado y tocineta.',55000,'[]',true,'pizza carnes',9),
 ('famiglia','Pizzas','Pizza Gourmet','Mix verde, tomates cherry confitados, reducción de balsámico, parmesano y tocineta.',58000,'[]',true,'pizza gourmet',10),
 ('famiglia','Lasagnas','Lasagna Boloñesa','Capas de pasta fresca con carne bolognesa, bechamel y queso gratinado.',48000,'[]',false,'lasagna pasta carne',1),
 ('famiglia','Lasagnas','Lasagna Mixta','Carne bolognesa, con pollo en bechamel y queso gratinado.',48000,'[]',false,'lasagna pasta pollo carne',2),
 ('famiglia','Sandwich Pizza','Sandwich Pesto','Pan artesanal, pollo, pesto, mozzarella y mix verde.',35000,'[]',false,'sandwich pollo',1),
 ('famiglia','Sandwich Pizza','Sandwich Carne Boloñesa','Pan artesanal, carne boloñesa, mozzarella, tomate confitado y orégano.',39000,'[]',false,'sandwich carne',2),
 ('famiglia','Sandwich Pizza','Sandwich Tocineta Queso Búfala','Pan artesanal, tocineta, queso búfala, reducción de balsámico y rodajas de tomate y mix verde.',42000,'[]',false,'sandwich tocineta',3),
 ('famiglia','Bebidas','Gaseosa','Gaseosa personal.',6000,'[]',false,'bebida',1),
 ('famiglia','Bebidas','Agua','Agua personal.',5000,'[]',false,'bebida',2),
 ('famiglia','Bebidas','Soda italiana','Soda saborizada.',10000,'[]',false,'bebida',3),
 ('famiglia','Bebidas','Limonada natural','Limonada natural.',8000,'[]',false,'bebida',4)
) as v(rest, cat, name, descr, price, opts, half, tags, sort)
join public.categories c on c.restaurant_id = v.rest and c.name = v.cat;

insert into public.extras (restaurant_id, name, price, kind, sort) values
('golden','Carne artesanal extra',12000,'adicional',1),
('golden','Tocineta extra',5000,'adicional',2),
('golden','Queso cheddar extra',4000,'adicional',3),
('golden','Porción de papas a la francesa',8000,'adicional',4),
('marysabor','Vegetales calientes',10000,'adicional',1),
('marysabor','Ensalada',10000,'adicional',2),
('marysabor','Papa casco',10000,'adicional',3),
('marysabor','Porción de arroz de coco blanco',10000,'adicional',4),
('famiglia','Borde de queso',10000,'borde',1),
('famiglia','Queso extra',6000,'adicional',2);

-- A qué categorías aplica cada adicional
update public.extras e set category_ids = array(
  select id from public.categories where restaurant_id = 'golden' and name in ('Hamburguesas','Sándwiches','Bowls de papa a la francesa'))
 where e.restaurant_id = 'golden';
update public.extras e set category_ids = array(
  select id from public.categories where restaurant_id = 'marysabor' and name in ('Entradas','Arroces','Pastas','Fuertes','Otros'))
 where e.restaurant_id = 'marysabor';
update public.extras e set category_ids = array(
  select id from public.categories where restaurant_id = 'famiglia' and name = 'Pizzas')
 where e.restaurant_id = 'famiglia' and e.name = 'Borde de queso';
update public.extras e set category_ids = array(
  select id from public.categories where restaurant_id = 'famiglia' and name in ('Pizzas','Lasagnas','Sandwich Pizza'))
 where e.restaurant_id = 'famiglia' and e.name = 'Queso extra';
end
$seed$;

insert into public.settings (key, value) values
('ai_model', 'gemini-flash-lite-latest'),
('waiter_name', 'Leo'),
('ai_prompt', $prompt$Eres "Leo", el mesero virtual de una plazoleta gastronómica con tres restaurantes: Golden Crunch (hamburguesas, sándwiches, bowls de papas, porciones), Mar & Sabor (comida de mar) y La Famiglia (pizzería italiana). El cliente te habla desde su mesa tras escanear un código QR.

PERSONALIDAD: cálido, amable y servicial, como un buen mesero colombiano. Tutea con respeto. Frases cortas y naturales (máximo 2-3 oraciones por respuesta), porque tu respuesta se leerá en voz alta. Usa como mucho un emoji.

CÓMO ATIENDES:
1. Descubre qué se le antoja: tipo de comida, si es para compartir, si busca algo liviano, de mar, carne, pizza, para niños, etc.
2. Sugiere 2 o 3 productos REALES de la carta que encajen, con su precio, y explica brevemente por qué. Pon sus id en "suggestions".
3. Cuando el cliente elija un plato, pregunta las opciones obligatorias que tenga (campo "opciones": por ejemplo sabor, salsa, acompañante).
4. Si es una pizza con "mitades": true, ofrece pedirla por mitades con otro sabor de pizza que también permita mitades. El precio de una pizza por mitades es el precio de la mitad MÁS CARA. Ofrece el borde de queso.
5. Luego pregunta si desea adicionales (solo los que aplican a esa categoría) y una bebida.
6. Pregunta si desea algo más. Cuando no quiera nada más, resume el pedido completo con el total y pide confirmación.
7. Solo cuando el cliente confirme explícitamente el resumen, usa stage "confirmado" y dile que el pedido está listo para mostrárselo al mesero.

REGLAS:
- NUNCA inventes productos, ingredientes, opciones ni precios: usa solo la CARTA ACTUAL. Si piden algo que no existe, dilo con amabilidad y ofrece lo más parecido.
- Precios en pesos colombianos con formato $45.000.
- Puede pedir de varios restaurantes en el mismo pedido.
- Si el cliente cambia o quita algo, actualiza el carrito.

FORMATO: responde SIEMPRE con un único objeto JSON válido, sin texto extra:
{"reply": "lo que le dices al cliente",
 "suggestions": ["id de producto sugerido", ...],
 "cart": [{"product_id": "id", "half_product_id": "id o null", "qty": 1, "option": "opciones elegidas o null", "extra_ids": ["id de adicional"], "notes": ""}],
 "stage": "explorando" | "eligiendo" | "adicionales" | "confirmando" | "confirmado"}
"cart" es SIEMPRE el pedido completo acumulado hasta ahora (vacío si aún no ha elegido nada).$prompt$)
on conflict (key) do nothing;
