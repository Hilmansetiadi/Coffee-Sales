Markdown
# End-to-End Coffee Sales Performance Analytics

## 📌 Project Overview
Proyek ini merupakan simulasi komprehensif analisis data ritel (*coffee shop*) dari hulu ke hilir (End-to-End). Fokus utama proyek ini adalah mengintegrasikan pengelolaan database relasional via **MySQL**, melakukan pembersihan dan pengecekan kualitas data (*Data Quality & Sanity Checking*), hingga mentransformasikannya menjadi dasbor bisnis interaktif berstandar korporat menggunakan **Power BI Desktop**.

## 🎯 Business Goals
1. **Financial Health Monitoring:** Mengukur performa pendapatan (*gross revenue*), laba bersih (*profit*), dan profit margin perusahaan secara riil.
2. **Product Portfolio Optimization:** Mengidentifikasi menu kopi yang menyumbang keuntungan tertinggi serta mengevaluasi produk dengan performa rendah.
3. **Operational Efficiency:** Menganalisis jam sibuk (*peak hours*) operasional toko untuk penyesuaian alokasi staf kasir dan barista.
4. **Payment Preferences:** Memetakan perilaku konsumen dalam memilih metode pembayaran (*cashless vs cash*).

## 🛠️ Tech Stack & Skills Demonstrated
* **Database Management:** MySQL Workbench (Data Ingestion, DDL/DQL, Constraints handling).
* **Data Engineering & Quality Control:** Data Cleansing, Cross-Table Referential Integrity, SQL Views Creation, Format Conversion (`STR_TO_DATE`).
* **Data Visualization & Analytics:** Power BI Desktop, DAX Measures, UI/UX Dashboard Layout, Executive Summary Reporting.

---

## 💻 Phase 1: Database Engineering & Analytics (MySQL)
Sebelum data ditarik ke dalam visualisasi, dilakukan audit data mendalam pada tabel `ecommerce_orders` dan `ecommerce_details` untuk memastikan keandalan informasi:

1. Handling Conversion Anomaly:Mendeteksi dan memperbaiki kegagalan konversi string tanggal akibat inkonsistensi karakter pemisah tekstual (`DD-MM-YYYY`), dijinakkan dengan kombinasi fungsi:
   ```sql
   SELECT 
       MIN(STR_TO_DATE(order_date, '%d-%m-%Y')) AS tanggal_paling_awal,
       MAX(STR_TO_DATE(order_date, '%d-%m-%Y')) AS tanggal_paling_akhir
   FROM ecommerce_orders;
Business Logic Sanity Check: Memastikan tidak ada anomali margin di mana nilai profit melebihi total gross amount transaksi akibat galat input sistem.

Production-Ready View: Mengunci struktur data yang telah tereliminasi dari duplikasi dan data null ke dalam database produksi berbentuk VIEW untuk efisiensi pemrosesan penarikan data:

SQL
CREATE OR REPLACE VIEW v_clean_ecom_sales AS
SELECT 
    o.order_id,
    STR_TO_DATE(o.order_date, '%d-%m-%Y') AS transaction_date,
    o.customername,
    d.category,
    d.sub_category,
    d.amount AS sales_amount,
    d.quantity AS qty_sold,
    d.profit
FROM ecommerce_details d
INNER JOIN ecommerce_orders o ON d.order_id = o.order_id;
📊 Phase 2: Data Visualization & Dashboard Design (Power BI)
Laporan visualisasi dirancang dalam 2 halaman interaktif yang memisahkan antara eksplorasi data taktis dan ringkasan eksekutif strategis:

Halaman 1: Sales Performance Dashboard
KPI Cards: Menampilkan gambaran makro performa keuangan bisnis (Total Revenue, Total Profit, Profit Margin).

Time Series Analysis: Grafik garis tren pendapatan bulanan untuk memantau fluktuasi penjualan sepanjang tahun.

Operational Peak Hours: Grafik batang kontribusi pendapatan berdasarkan jam transaksi untuk melacak jendela waktu tersibuk toko (morning coffee run).

Product & Payment Share: Bar chart horizontal yang mengelompokkan varian menu paling menguntungkan serta visualisasi perbandingan dominasi transaksi digital.

Halaman 2: Business Insight & Executive Summary
Halaman khusus yang didedikasikan untuk jajaran manajemen puncak (C-Level) berupa narasi analisis performa mendalam dan rekomendasi aksi bisnis nyata (Data Storytelling) tanpa distorsi elemen visual padat.

🚀 Key Insights & Business Recommendations
Fundamental Finansial Sehat: Perusahaan mencetak profit margin sebesar 54.28% (Total Revenue $89.86K, Profit $48.78K), membuktikan kontrol HPP produk yang sangat kuat.

Latte & Milk-Based Dominance: Varian Latte memimpin perolehan keuntungan mutlak sebesar $16.1K, menjadikannya produk prioritas utama untuk strategi pemasaran atau promo bundling.

Peak Hour Resource Allocation: Lonjakan transaksi terfokus secara konsisten pada pukul 08.00 - 10.00 pagi. Manajemen disarankan menambah kapasitas staf pada shift pagi untuk mereduksi antrean.

Cashless Revolution: Metode pembayaran kartu (Card) mendominasi mutlak sebesar 97.57% (2.774 transaksi) dibandingkan tunai yang hanya 2.43%. Infrastruktur mesin pembayaran digital wajib menjadi prioritas utama pemeliharaan teknis di toko.
