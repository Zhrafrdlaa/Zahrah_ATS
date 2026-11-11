# ☕ Coffee Point

Aplikasi pemesanan kopi **tanpa antre** berbasis Flutter. Pilih menu, atur pesanan, pilih waktu ambil, lalu bayar dengan QRIS, semuanya dari satu aplikasi.

> Proyek **Asesmen Tengah Semester (ATS) Praktikum**
> Mata Kuliah: Pemrograman Perangkat Bergerak (RPL317) • Teknologi Rekayasa Perangkat Lunak
> Fokus: **Frontend** dengan dummy data (tanpa backend)

---

## ✨ Fitur

| Fitur | Keterangan |
|---|---|
| 🔍 Pencarian & filter | Cari menu berdasarkan nama dan filter kategori (Espresso, Non-Coffee, Pastry) |
| ❤️ Favorit | Tandai menu favorit dari halaman detail |
| 🛠️ Kustomisasi pesanan | Pilih ukuran, tingkat manis, es, dan catatan untuk barista |
| 🛒 Keranjang | Tambah, kurangi, dan hapus item, dengan badge jumlah dan tombol **LIHAT** di snackbar |
| 🎟️ Kupon & waktu ambil | Aktifkan kupon dan pilih jam pengambilan pesanan |
| 📱 Pembayaran QRIS | QR dummy dengan hitung mundur 15 menit dan opsi buat kode baru |
| ✅ Validasi & error handling | Validasi form login, pesan error, dan tampilan kosong yang rapi |

## 📱 Halaman

1. **Splash Screen**
2. **Login**
3. **Beranda & Menu** (dengan tab Keranjang dan Profil)
4. **Detail Produk**
5. **Konfirmasi Pembayaran** (termasuk modal Pilih Waktu Ambil)
6. **Pembayaran QRIS**
7. **Pesanan Berhasil**

## 🧱 Arsitektur

Menggunakan pola **MVVM** dengan **Provider**, sehingga data tetap aman saat layar diputar atau berpindah halaman.

```
lib/
├── main.dart
├── app/          → rute & tema
├── core/         → warna, text style, validator, formatter, exception
├── models/       → Product, CartItem, AppUser, enum kustomisasi
├── data/         → dummy data
├── viewmodels/   → Auth, Menu, Cart, Navigation
├── screens/      → 7 halaman aplikasi
└── widgets/      → komponen UI yang dapat dipakai ulang
```

Komponen seperti tombol, input field, kartu produk, dan stepper jumlah dibuat sekali sebagai class widget, lalu dipakai berulang di banyak halaman (prinsip OOP).

## 🔑 Akun Demo

| Email | Kata Sandi |
|---|---|
| `zara@email.com` | `latte123 |

## 🛠️ Teknologi

- Flutter & Dart
- Provider (state management)
- Dummy data lokal