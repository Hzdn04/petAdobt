# Pet Adobt

Aplikasi _Pet Adobt_ adalah platform online yang mempertemukan orang yang ingin mengadopsi hewan peliharaan dengan hewan yang membutuhkan rumah baru. Aplikasi ini memudahkan orang untuk menemukan hewan peliharaan yang cocok dengan gaya hidup mereka.

## Tables

(Menggunakan PostgreSQL)

### Pet Table

- Fields dalam tabel `Pet` :

  | key      | keterangan      |
  | -------- | --------------- |
  | id       | int primary key |
  | pet_type | varchar         |
  | race     | varchar         |
  | age      | int             |
  | price    | int             |
  | stock    | int             |

### Adobt Table

- Fields dalam tabel `Adobt` :

  | key     | keterangan      |
  | ------- | --------------- |
  | id      | int primary key |
  | name    | varchar         |
  | address | text            |
  | email   | varchar         |
  | phone   | varchar         |

### Junction Table (petAdobt)

- Fields dalam Junction Table `petAdobt` :

  | key         | keterangan      |
  | ----------- | --------------- |
  | id          | int primary key |
  | petId       | int             |
  | adobtId     | int             |
  | adobt_date  | date            |
  | total_price | int             |

### Routes

Berikut _endpoints_ yang telah dibuat dalam folder **Routes**:

| Method | Endpoints             | Keterangan                                                                             |
| ------ | --------------------- | -------------------------------------------------------------------------------------- |
| GET    | /                     | home page                                                                              |
| GET    | /pets                 | data hewan peliharaan dari tabel `Pet`                                                 |
| GET    | /adobts               | data para adobter dari tabel `Adobts`                                                  |
| GET    | /petAdobts            | data transaksi mengadobsi pet dari tabel `petAdobt`, join dengan tabel `Pet` & `Adobt` |
| POST   | /pets/create          | berfungsi untuk menambahkan data pet                                                   |
| POST   | /adobts/create        | berfungsi untuk menambahkan data adobter                                               |
| POST   | /petAdobts/create     | berfungsi untuk menambahkan data transaksi                                             |
| GET    | /pets/delete/:id      | menghapus dari id table `Pet`                                                          |
| GET    | /adobts/delete/:id    | menghapus dari id table `Adobt`                                                        |
| GET    | /petAdobts/delete/:id | menghapus dari id table `petAdobt`                                                     |
| POST   | /pets/update/:id      | berfungsi untuk memperbaharui data pet                                                 |
| POST   | /jobs/update/:id      | berfungsi untuk memperbaharui data adobter                                             |

---
