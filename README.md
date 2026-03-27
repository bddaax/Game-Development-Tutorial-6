<a name="readme-top"></a>

<div align="center">
  
  <h1>🎮 Tutorial Game Development 2025/2026</h1>

  <p>
	<b>Brenda Po Lok Fahida</b> • 2306152304
  </p>

</div>

<br>

<div align="center">

[![TUTORIAL CSUI](https://img.shields.io/badge/-TUTORIAL_CSUI-EDC5BB?style=for-the-badge&logoColor=white)](https://csui-game-development.github.io/)
[![GODOT DOCS](https://img.shields.io/badge/-GODOT_DOCS-6B7F7E?style=for-the-badge&logo=godotengine&logoColor=white)](https://docs.godotengine.org/en/stable/getting_started/introduction/)
[![GITHUB](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/bddaax/Game-Development-Tutorial-6)

</div>

<br>

<details>
<summary><h2>Tutorial 6 – Menu and In-Game Graphical User Interface</h2></summary>

### Deskripsi
Tutorial 6 berfokus pada pembuatan **tampilan antar muka (UI/GUI)** pada game platformer 2D. Pada tutorial ini ditambahkan Main Menu, Life Counter GUI, dan Layar Game Over.

---

### Fitur yang Diimplementasikan

#### 1. Main Menu (`MainMenu.tscn`)
- **Struktur**: `Control` → `ColorRect` (background gelap) + `MarginContainer` → `VBoxContainer` → Label judul, label subtitle, dan `VBoxContainer` tombol-tombol.
- **Animasi**: Judul dan subtitle muncul dengan fade-in + slide-up menggunakan `create_tween()`.
- **Hover Effect**: Tombol membesar dan berubah warna kuning saat di-hover, kembali normal saat mouse keluar.
- **Tombol NEW GAME**: Memanggil `Transition.change_scene_to_file()` untuk pindah ke Level 1.
- **Tombol STAGE SELECT**: Membuka scene `LevelSelect.tscn`.
- **Reset Lives**: Saat memasuki Main Menu, `Global.lives` di-reset ke 3.

#### 2. Life Counter GUI (`LifeCounter.tscn`)
- **Struktur**: `MarginContainer` → `HBoxContainer` → Tombol `< Back` + `Label` Lives.
- **Label**: Di-update setiap frame via `_process()` dengan membaca `Global.lives`.
- **Shake Animation**: Saat nyawa berkurang, label bergetar menggunakan tween animation (shake effect).
- **Tombol Back**: Membawa pemain kembali ke Main Menu kapan saja.
- Life Counter dipasang dalam **`CanvasLayer`** agar selalu tampil di atas dunia game di Level 1 dan Level 2.

#### 3. Global Variable (`Global.gd`)
- Autoload script yang menyimpan `var lives = 3`.
- Nilai `lives` tetap tersimpan meskipun scene di-reload karena disimpan di autoload Node.

#### 4. Area Trigger / Death Zone (`area_2d.gd`)
- Saat Player jatuh ke lubang dan menyentuh `AreaTrigger` (Area2D):
  - Jika scene yang sedang aktif sama dengan `sceneName` → kurangi `Global.lives`.
  - Jika nyawa = 0 → pindah ke `LoseScreen.tscn`.
  - Jika nyawa masih ada → reload scene yang sama.

#### 5. Layar Game Over – Lose Screen (`LoseScreen.tscn`)
- Background merah gelap + teks **GAME OVER** besar.
- **Tombol TRY AGAIN**: Reset lives ke 3 dan kembali ke Level 1.
- **Tombol MAIN MENU**: Kembali ke Main Menu.

#### 6. Layar Menang – Win Screen (`WinScreen.tscn`)
- Background hijau gelap + teks **YOU WIN!**.
- **Tombol PLAY AGAIN**: Reset lives dan kembali ke Level 1.
- **Tombol MAIN MENU**: Kembali ke Main Menu.

#### 7. Transisi Antar Scene (`transition.gd`)
- Autoload `CanvasLayer` yang membuat overlay fade hitam via `create_tween()`.
- Fade out → ganti scene → fade in, tanpa memerlukan `AnimationPlayer`.

---

### Latihan Mandiri & Fitur Custom Tambahan

#### Fitur 1: Tombol Main Menu di Layar Game Over/Win
- `LoseScreen.tscn` dan `WinScreen.tscn` masing-masing memiliki tombol **MAIN MENU** yang membawa pemain kembali ke `MainMenu.tscn`.

#### Fitur 2: Stage Select (`LevelSelect.tscn`)
- Dapat diakses dari tombol **STAGES** di Main Menu.
- Menampilkan pilihan **LEVEL 1** dan **LEVEL 2** dengan tombol **< BACK** untuk kembali ke Main Menu.
- Memilih level akan mereset nyawa ke 3 dan langsung masuk ke level yang dipilih.

#### Fitur 3: Map Zoom Pickup (`MapPickup.tscn`)
- Kotak merah rahasia yang tersembunyi.
- Saat diambil, memunculkan popup animasi di layar.
- Mengaktifkan fitur Map Zoom Out: menekan tombol **M** akan memperkecil tampilan (zoom-out) kamera untuk melihat keseluruhan rintangan di level, dan menekan **M** lagi akan mengembalikannya.

#### Fitur 4: Extra Life Pickup (`LivePickup.tscn`)
- Item berwujud hati (Heart) yang memberikan ekstra nyawa (+1 Live) ketika diambil oleh pemain.
- Ditambahkan bersamaan dengan popup UI animasi sebagai penanda tambahan nyawa.

#### Fitur 5: Musuh / Enemy Logika Sederhana
- Tambahan objek musuh (Enemy) yang akan mendeteksi ketika tersentuh oleh pemain.
- Ketika menyentuh musuh, nyawa pemain akan berkurang 1 (-1 Live), sistem me-respawn pemain ke posisi awal dan mereset platform bergerak.

#### Fitur 6: Layar Transisi Next Level (`NextLevelScreen.tscn`)
- Apabila pemain berhasil menyelesaikan Level 1, akan diarahkan otomatis ke `NextLevelScreen.tscn`.
- Layar ini menampilkan "LEVEL CLEARED! Prepare for Level 2..." selama 3 detik sebelum melakukan transisi fade-in ke Level 2.

#### Fitur 7: Checkpoint Mekanik (Moving Platform Reset)
- Saat pemain mati (kehilangan 1 nyawa), posisi pemain akan di-reset.
- Setiap platform bergerak (`TileMapLayer2` di Level 2) akan mereset posisinya secara otomatis berkat fungsi modular `reset()` yang dipanggil saat respawn.

---

### Referensi Dokumentasi
[![CharacterBody2D](https://img.shields.io/badge/-CharacterBody2D-808080?style=for-the-badge&logo=godotengine&logoColor=white)](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)
[![AnimatedSprite2D](https://img.shields.io/badge/-AnimatedSprite2D-808080?style=for-the-badge&logo=godotengine&logoColor=white)](https://docs.godotengine.org/en/stable/classes/class_animatedsprite2d.html)
[![ParallaxBackground](https://img.shields.io/badge/-ParallaxBackground-808080?style=for-the-badge&logo=godotengine&logoColor=white)](https://docs.godotengine.org/en/stable/classes/class_parallaxbackground.html)
<br>
[![Control](https://img.shields.io/badge/-Control-808080?style=for-the-badge&logo=godotengine&logoColor=white)](https://docs.godotengine.org/en/stable/classes/class_control.html)
[![Tween](https://img.shields.io/badge/-Tween-808080?style=for-the-badge&logo=godotengine&logoColor=white)](https://docs.godotengine.org/en/stable/classes/class_tween.html)
[![CanvasLayer](https://img.shields.io/badge/-CanvasLayer-808080?style=for-the-badge&logo=godotengine&logoColor=white)](https://docs.godotengine.org/en/stable/classes/class_canvaslayer.html)
[![Autoload/Singleton](https://img.shields.io/badge/-Autoload%2FSingleton-808080?style=for-the-badge&logo=godotengine&logoColor=white)](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html)
<br>

</details>