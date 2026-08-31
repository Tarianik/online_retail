# Анализ Online Retail

## Задача

Необходимо провести

## Стек технологий

PostgreSQL | SQL | Python (pandas, matplotlib, seaborn, squarify) | Metabase

## Dashboard

Ссылка на дашборд Metabase: \
 [data.tarianik.dev/public/dashboard/f903cd3c-e7ab-42c2-8b77-34a2a1051889](data.tarianik.dev/public/dashboard/f903cd3c-e7ab-42c2-8b77-34a2a1051889)

## О датасете

Ссылка на датасет: \
 [https://archive.ics.uci.edu/dataset/502/online+retail+ii](https://archive.ics.uci.edu/dataset/502/online+retail+ii) \
Строк: 1067371 \
Столбцов: 8 \
Online Retail II содержит все транзакции, совершенные зарегистрированной в Великобритании онлайн-компанией, не имеющей розничных магазинов, в период с 01.12.2009 по 09.12.2011.

## Очистка данных

Была создана промежуточная таблица с сырыми данными из [csv-файла](online_retail_II.csv) и представление `stg_valid`, куда по мере очистки данных добавлялись фильтры для формирования финальной таблицы. SQL-запросы, отфильтровывающие ненужные данные находятся в файле [data_checks.sql](data_checks.sql) и представлены в следующей таблице:

<table>
    <tr>
        <td>Правило</td>
        <td>Ссылка</td>
        <td>Строк</td>
        <td>Комментарии</td>
    </tr>
    <tr>
        <td><code>unit_price <= 0</code></td>
        <td><a href="/sql/data_checks.sql#L1">data_checks.sql#L15</a></td>
        <td>6207</td>
        <td>Это бесплатные товары. Исключены, так как влияют на метрики топ товаров.</td>
    </tr>
    <tr>
        <td><code>stock_code</code> не соответствует ^\d+[a-zA-Z]\*$</td>
        <td><a href="/sql/data_checks.sql#L6">data_checks.sql#L6</a></td>
        <td>6094</td>
        <td>Это почтовые расходы (POST), непривязанные к товарам скидки (D) и т. п., транзакций нет</td>
    </tr>
   <tr>
        <td><code>description IS NULL</code> (нет описания товара)</td>
        <td><a href="/sql/data_checks.sql#L15">data_checks.sql#L1</a></td>
        <td>4382</td>
        <td>У всех таких строк также <code>unit_price = 0</code> — это незавершённые/битые записи, не транзакции</td>
    </tr>
        <tr>
        <td><code>quantity < 0</code> и <code>invoice_no</code>  не содержит префикс "C"</td>
        <td><a href="/sql/data_checks.sql#L20">data_checks.sql#L15</a></td>
        <td>3457</td>
        <td>В датасете 22950 строк с отрицательным <code>quantity</code>: из них 19493 строк — отмененные заказы (с префиксом "C"), они были оставлены. Остальные были исключены, так как в <code>description</code> содержали либо NULL, либо "lost", "damaged", "missing" и т. п.</td>
    </tr>
        </tr>
        <tr>
       <td>Уникальные <code>invoice_no</code> с разными датами или покупателями</td>
        <td><a href="/sql/bad_invoices.sql">bad_invoices.sql</a></td>
        <td>83</td>
        <td>Битые записи. Не были добавлены в таблицы при <code>INSERT</code> из <code>stg_valid</code></td>
    </tr>
      <tr>
        <td><code>invoice_no</code> не соответствует ^C?\d{6}$</td>
        <td><a href="/sql/data_checks.sql#L27">data_checks.sql#L1</a></td>
        <td>6</td>
        <td>Это списания долга, не транзакции</td>
    </tr>
     <tr>
        <td><code>customer_id IS NULL</code> </td>
        <td><a href="/sql/data_checks.sql#L32">data_checks.sql#L15</a></td>
        <td>~22% строк</td>
        <td>Гостевые покупки сохранены</td>
    </tr>    
</table>

Были созданы таблицы `customers`, `orders`, `products`, `order_items` ([/sql/create_tables.sql](), [/sql/insert.sql]()). и заполнены данными из получившегося представления `stg_valid`.

## ER-диаграмма

![ER-диаграмма](img/ERD.png)

## Анализ и метрики

### Выручка и количество заказов по месяцам

![RFM-cегментация](img/revenue_and_orders.png)
В 2011 году рост выручки и количества заказов практически отсутствовал относительно показателей предыдущего года. Выручка стабильно увеличивается к Q4 2011 в связи с праздниками. Пики наблюдаются в ноябрях 2010 (+78% к средней) и 2011 (+82%) годов.

### RFM-cегментация

![RFM-cегментация](img/rfm.png)
Огромную долю выручки приносит группа "Лучших" клиентов, а именно только 22% клиентов генерируют 72% всей выручки

### Когортный анализ

![Когортный анализ](img/cohort_retention.png)
Клиенты когорты 2010-10 в последующих месяцах возвращались значительно реже, чем клиенты других когорт.

_RFM-сегментация и когортный анализ сделаны на основе заказов с customer_id (78% от всех заказов)._

### Заказы по статусу клиента: новые/вернувшиеся/гости

![Customer status](img/customer_status.png)
В 2011 приток новых клиентов существенно сократился - в первые месяцы года в несколько раз. Количество заказов не уменьшилось благодаря вернувшимся пользователям, что также подтверждается графиком RFM-сегментации.

<details>
<summary>Остальные визуализации (5)</summary>

![AOV](img/aov.png)
![Процент отмен](img/cancellation_rate.png)
![Geography](img/geography.png)
![Geography no UK](img/geography_no_uk.png)
![Top products](img/top_products.png)

</details>
