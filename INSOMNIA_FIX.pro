DOMAINS
pilihan = integer
pertanyaan = string
gejala = symbol
jawab = char
hasil = string
anggota = string*

FACTS
dbjawabanya(gejala)
dbjawabantidak(gejala)

PREDICATES
nondeterm start
nondeterm ask(anggota)
nondeterm menu(pilihan)
nondeterm kelompok(string)
nondeterm kelompoks(string,anggota)
nondeterm jawaban(pertanyaan, gejala)
nondeterm jawabantidak(pertanyaan,gejala)
nondeterm gejala(gejala)
nondeterm diagnosa(hasil)
nondeterm jawabanku
nondeterm submenu
nondeterm jalankan
nondeterm tanya(pertanyaan, gejala, jawab)
nondeterm simpan(gejala, jawab)
clear_fakta
jalankan_ulang
output(hasil)



CLAUSES


/* MENU UTAMA */
start:-
write(" =========================================================================="),
nl,
write("        = APLIKASI SISTEM PAKAR UNTUK MENDIAGNOSA PENYAKIT GANGGUAN TIDUR ="),
nl,
write(" =========================================================================="),
		write("\n  1. Sistem Pakar Diagnosa Penyakit Insomnia"),
       		write("\n  2. Group Member"),
       		write("\n  3. Exit"),
        	write("\n      Pilih Menu : "),
		readint(Pilihan),menu(Pilihan).

menu(Pil):- 
Pil=1,submenu; /* jika inputan 1 maka menunjuk ke predicate submenu */
Pil=2,kelompok("kelompok"),start; /* jika inputan 2 maka menunjuk ke predicate kelompok setelah selesai baru, di arahkan ke predicate start*/
Pil=3,write("  Terima Kasih Sudah Menggunakan Program Ini \n");
Pil<1,write("  Pilih menu yang tersedia \n\n"),start;Pil>3,write("  Pilih menu yang tersedia \n\n"),start. /* jika inputan < 1 maka
  akan dimuncul peringatan, lalu kembali ke predicate start*/


submenu:-
nl, /* nl berfungsi untuk membuat baris baru */
write(" Silahkan jawab beberapa pertanyaan dibawah ini : \n  y ( Benar ) atau t ( Tidak Benar )\n \n"),
jalankan. /* memanggil predicate jalankan*/

jalankan:-
   jalankan_ulang,nl,nl,nl,
   write(" Apakah Anda mencoba Lagi (y/t) ?"),
   readchar(Jawab),nl,
   Jawab='y',
   submenu;start. /* jika input yes maka memanggil predicate submenu, jika inputan selain y maka memanggil predicate start*/
   
 jawabanku:-
 	jalankan_ulang./*memanggil predicate jalankan_ulang*/

/* persiapkan bagaimana pertanyaan dimunculkan dan dibagi sehingga dapat disimpan */
jawaban(_,Gejala):- /* */
	dbjawabanya(Gejala), /* */
	!./* menghentikan lacak balik*/
jawaban(Pertanyaan,Gejala):-
	not(dbjawabantidak(Gejala)),
	tanya(Pertanyaan,Gejala,Jawab),
	Jawab='y'.
	
jawabantidak(_,Gejala):-
	dbjawabantidak(Gejala),
	!./* menghentikan lacak balik*/	
jawabantidak(Pertanyaan,Gejala):-
	not(dbjawabanya(Gejala)),
	tanya(Pertanyaan,Gejala,Jawab),
	Jawab='t'.
	
/* FAKTA UNTUK MENGHAPUS JAWABAN YANG DISIMPAN */ 
clear_fakta:-
	retract(dbjawabanya(_)),fail. /* menghapus fakta dari section fact dbjawabanya, kemudian di fail untuk memaksa lacak balik untuk menghapus fakta yang lain */	
clear_fakta:-
	retract(dbjawabantidak(_)),fail. /* menghapus fakta dari section fact dbjawabanyatidak,kemudian di fail untuk memaksa lacak balik untuk menghapus fakta yang lain */	

clear_fakta.

/* FAKTA UNTUK MENYIMPAN JAWABAN */ 
simpan(Gejala,'y'):- /* jika jawaban pertanyaan y maka */
	asserta(dbjawabanya(Gejala)) . /* gejala akan disimpan di section fact dbjawabanya*/

simpan(Gejala,'t'):- /* jika jawaban pertanyaan t maka */
	asserta(dbjawabantidak(Gejala))./* gejala akan disimpan di section fact dbjawabanyatidak*/

tanya(Pertanyaan, Gejala, Jawab):-
	write(Pertanyaan), 
	readchar(Jawab),
	write(Jawab),
	nl,
	simpan(Gejala,Jawab).
 
/* START QUESTION */
jalankan_ulang:- 
	diagnosa(_),!, /* Memanggil diagnosa atau pertanyaan dengan mengabaikan isi argumen / variabel anonim */
	save("test.txt"), /* menyimpan jawaban di test.dat yang berada di C:\Users\Acer\AppData\Local\Temp */
	clear_fakta. /* memanggil predicate clear_fakta*/
	
/* JIKA HASIL DIAGNOSA TIDAK SESUAI DENGAN FAKTA ATAU JAWABAN TIDAK DITEMUKAN */
jalankan_ulang:-
	write(" Maaf, Kami tidak dapat menentukan jenis penyakit Anda. Sepertinya Anda Masih Sehat."), 
	clear_fakta.


/* DEKLARASI Gejala */ 

gejala(gejala1):-
	jawaban(" Apakah anda merasa sulit untuk tidur (y/t)?",diagnosa1).

gejala(gejala2):-
	jawaban(" Apakah anda sering terbangun saat tidur (y/t)?",diagnosa2).

gejala(gejala3):-
	jawaban(" Apakah anda merasakan rasa tidak segar atau lemas (y/t)?",diagnosa3).

gejala(gejala4):-
	jawaban(" Apakah anda selalu merasa cemas (y/t)?",diagnosa4).

gejala(gejala5):-
	jawaban(" Apakah anda sering kerja di tempat tidur (y/t)?",diagnosa5).

gejala(gejala6):-
	jawaban(" Apakah anda sulit untuk tidur sejak dini (y/t)?",diagnosa6).

gejala(gejala7):-
	jawaban(" Apakah anda tergolong orang obesitas (y/t)?",diagnosa7).

gejala(gejala8):-
	jawaban(" Apakah anda saat tidur mendengkur dengan keras (y/t)?",diagnosa8).

gejala(gejala9):-
	jawaban(" Apakah anda memiliki penyakir riwayat jantung (y/t)?",diagnosa9).

gejala(gejala10):-
	jawaban(" Apakah anda saat tidur mendengkur dengan ringan (y/t)?",diagnosa10).

gejala(gejala11):-
	jawaban(" Apakah anda berlebihan tidur pada siang hari (y/t)?",diagnosa11).

gejala(gejala12):-
	jawaban(" Apakah anda saat tidur selalu bergerak berulang misal gerakan kaki (y/t)?",diagnosa12).

gejala(gejala13):-
	jawaban(" Apakah anda saat tidur merasakan sensasi tidak enak pada kaki (y/t)?",diagnosa13).

gejala(gejala14):-
	jawaban(" Apakah anda sering tidur pada jam yang tidak seharusnya (y/t)?",diagnosa14).

/* diagnosa DITENTUKAN BERDASARKAN SYARAT DAN HASIL */ 

/* PENYAKIT INSOMNISA PRIMER */
diagnosa("diagnosa 3"):-
gejala(gejala1), 
gejala(gejala2),
gejala(gejala3),
output(" Anda Memiliki Penyakit Insomnia Primer.\n Gejala : sulit untuk tidur, sering terbangun saat tidur, merasa tidak segar atau lemas saat bangun tidur.").


/* ENYAKIT INSOMNIA KRONIK */
diagnosa("diagnosa 5"):-
gejala(gejala1),
gejala(gejala4),
gejala(gejala5),
output(" Anda Memiliki Penyakit Insomnia Kronik.\n Gejala : Sulit untuk tidur, Cemas ketika hendak tidur, Sering melakukan kegiatan ditempat tidur").



/* PENYAKIT INSOMNIA IDIOPATIK */
diagnosa("diagnosa 6"):-
gejala(gejala1),
gejala(gejala2),
gejala(gejala6),
output(" Anda Memiliki Penyakit Insomnia Idiopatik.\n Gejala : Sulit untuk tidur, Sering terbangun saat tidur, Mengalami kesulitan tidur sejak dini").



/* PENYAKIT SINDROM APNEA OBSTRUKTIF */
diagnosa("diagnosa 8"):-
gejala(gejala1),
gejala(gejala2),
gejala(gejala4),
gejala(gejala7),
gejala(gejala8),
output(" Anda Memiliki Penyakit Sindrom Apnea Tidur Obstruktif.\n Gejala : Sulit untuk tidur, Sering terbangun saat tidur, Cemas ketika hendak tidur, Mengalami obesitas, Mendengkur dengan suara keras pada saat tidur. ").


/* PPENYAKIT SINDROM APNEA SENTRAL */
diagnosa("diagnosa 10"):-
gejala(gejala1),
gejala(gejala2),
gejala(gejala4),
gejala(gejala9),
gejala(gejala10),
output(" Anda Memiliki Penyakit Sindrom Apnea Tidur Sentral. \n Gejala : Sulit untuk tidur, Sering terbangun saat tidur, Cemas ketika hendak tidur, Memiliki riwayat penyakit jantung, Mendengkur dengan suara halus pada saat tidur. ").


/* PENYAKIT SINDROM HIPOVENTILASI ALVEOLAR */
diagnosa("diagnosa 11"):-
gejala(gejala1),
gejala(gejala2),
gejala(gejala4),
gejala(gejala7),
gejala(gejala11),
output(" Anda Memiliki Penyakit Sindrom Hipoventilasi Alveolar Sentral.\n Gejala : Sulit untuk tidur, Sering terbangun saat tidur, Cemas ketika hendak tidur, Mengalami obesitas, Sering tidur berlebihan di siang hari. ").


/* PENYAKIT TRESTLESS LEG SYNDROM */
diagnosa("diagnosa 13"):-
gejala(gejala1),
gejala(gejala2),
gejala(gejala4),
gejala(gejala13),
output(" Anda Memiliki Penyakit Restless Leg Syndrome. \n Gejala : Sulit untuk tidur, Sering terbangun saat tidur, Cemas ketika hendak tidur, Mengalami sensasi tidak enak ditungkai kaki yang menyebabkan anda tidak bisa tidur. ").


/* PENYAKIT PERIODIC LEG MOVEMENT */
diagnosa("diagnosa 13"):-
gejala(gejala1),
gejala(gejala2),
gejala(gejala4),
gejala(gejala12),
gejala(gejala13),
output(" Anda Memiliki Penyakit Periodic Leg Movement.\n Gejala : Sulit untuk tidur, Sering terbangun saat tidur, Cemas ketika hendak tidur, Sering menggerakan kaki secara berulang dengan durasi pendek, Mengalami sensasi tidak enak ditungkai kaki. ").


/* PENYAKIT GANGGUAN RITMIK SIRKADIAN */
diagnosa("diagnosa 14"):-
gejala(gejala1),
gejala(gejala2),
gejala(gejala4),
gejala(gejala11),
gejala(gejala14),
output(" Anda Memiliki Penyakit Gangguan Ritmik Sirkadian.\n Gejala : Sulit untuk tidur, Merasa tidak segar atau lemas saat bangun tidur, Cemas ketika hendak tidur, Sering tidur berlebihan di siang hari, Sering tidur pada jam yang tidak semestinya.").


output(Hasil):- 
upper_lower(HasilPenyakit, Hasil),nl,nl, /*upper_lower merupakan fungsi yang mengkonversi huruf kecil menjadi huruf besar*/
write(" Hasil identifikasi yang kami dapatkan yaitu ", HasilPenyakit),nl.

/* GROUP MEMBER */

kelompok(Kelompok):- 
  	kelompoks(Kelompok,List), /* memanggil predicate kelompoks*/
	ask(List). /* Memanggil predicate ask*/
 ask([]). /*predicate ask masih memiliki list kosong*/
 ask([H|T]):-
	write(H), /* Head dari list di tampilkan*/
	ask(T). /* pemanggilan kembali predicate ask dengan head baru*/

kelompoks("kelompok",[" \n == GROUP 2 AI MEMBER ==","\n Muhammad Rizal","      [1515015105]","\n Ferry Miechel Lubis","  [1515015111]","\n Jumarni","                     [1515015125] \n\n"]).



goal
/* GOAL HERE */
start.