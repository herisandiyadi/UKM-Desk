import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Term & Condition",
                ),
                Tab(text: "Privacy"),
              ],
            ),
            title: Text("Term And Privacy"),
            backgroundColor: Colors.red[800],
          ),
          body: TabBarView(
            children: [
              initViewTerm(),
              initViewPrivacy(),
            ],
          ),
        ),
      ),
    );
  }

  Widget initViewTerm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
              "https://www.enforcea.com/assets/img3/contacts_page-title-1536x416.jpg"),
          Html(
            data: htmlContent,
            style: {
              "div": Style(textAlign: TextAlign.left),
              "h2": Style(fontSize: FontSize.medium, textAlign: TextAlign.left)
            },
          )
        ],
      ),
    );
  }

  Widget initViewPrivacy() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
              "https://www.enforcea.com/assets/img3/contacts_page-title-1536x416.jpg"),
          Html(
            data: htmlKebijakan,
            style: {
              "div": Style(textAlign: TextAlign.left),
              "h2": Style(fontSize: FontSize.medium, textAlign: TextAlign.left)
            },
          )
        ],
      ),
    );
  }

  final String htmlKebijakan = ''' <div style="text-align: left">
                            <p>Firma Sudiarta dan Rekan (selanjutnya disebut “EnforceA” atau “Kami”) memiliki komitmen tinggi terhadap perlindungan data Saudara. Kami bertanggung jawab untuk menegakkan prinsip-prinsip pengurusan data dengan integritas yang penuh, dimana Kami selalu menjadikan keamanan data Saudara menjadi prioritas utama Kami. Untuk itu, keamanan data Saudara (serta data lainnya yang Saudara percayakan kepada Kami) adalah hal yang terpenting untuk Kami.</p>
                            <p>Kebijakan privasi ini (selanjutnya disebut “Kebijakan”) mengatur tentang cara Kami mengumpulkan dan menggunakan data Saudara dalam https://www.enforcea.com (selanjutnya disebut “Situs”). Dengan menggunakan jasa accounting dan perpajakan yang disediakan EnforceA dan mengakses Situs Kami, Saudara telah menyetujui dan terikat dengan hal-hal yang telah terdapat dalam Kebijakan ini. Oleh karena itu, Kami berharap Saudara membaca Kebijakan ini untuk memastikan bahwa Saudara mengerti bagaimana cara Kami menangani data Saudara.</p>
                            <p><b>Cara mengumpulkan data Saudara</b></p>
                            <p>EnforceA adalah penyedia layanan jasa akuntansi dan perpajakan yang ditujukan untuk usaha kecil dan menengah di Indonesia. Ketika Saudara menggunakan Produk atau mengakses Situs, Saudara secara langsung maupun tidak langsung memberikan data Saudara kepada Kami yang akan Kami lindungi dan gunakan dalam metode yang diatur dalam Kebijakan ini. Sebagai contoh, data yang kami kumpulkan dapat berupa nama, alamat e-mail, nomor telepon dan data lainnya yang Saudara berikan sehubungan dengan penggunaan Saudara atas Produk dan akses Situs. Kami dapat mengumpulkan:</p>
                            <ul style="list-style-type: disc">
                                <li>Email dan Password Saudara untuk memberikan akses ke Produk EnforceA;</li>
                                <li>Data yang Saudara kirim dan serahkan kepada EnforceA;</li>
                                <li>Informasi tentang perangkat Saudara ketika mengakses Situs atau Produk, seperti IP Address dan informasi browser;</li>
                                <li>Kesan, pesan, kritik, dan saran dari Saudara, pembicaraan melalui chat dan interaksi lainnya di Situs atau Produk Kami; dan/atau</li>
                                <li>Seluruh hal yang Saudara lakukan dan data yang Saudara masukkan ke dalam Situs atau Produk.</li>
                            </ul>
                            <p>Kami dapat mengumpulkan data secara langsung dari Saudara ketika Saudara:</p>
                            <ul style="list-style-type: disc">
                            <li>Mengakses Situs;</p>
                            <li>Mendaftar untuk menggunakan Produk EnforceA;</li>
                            <li>Menggunakan Produk EnforceA;</li>
                            <li>Mengirimkan kesan, pesan, kritik dan saran Saudara;</li>
                            <li>Menghubungi tim support Kami; atau</li>
                            <li>Memasukkan informasi dalam bentuk apapun dalam Situs atau Product.</li>
                            </ul>
                            <p>Data yang Saudara masukkan adalah data Saudara sendiri yang Saudara anggap benar, dan Saudara bertanggung jawab penuh atas segala data yang Saudara masukkan dalam Situs atau Produk Kami.</p>
                            <p><b>Contoh penggunaan data Saudara</b></p>
                            <p>Setiap data yang Saudara masukkan ke dalam Situs dan/atau Produk dapat kami gunakan, termasuk namun tidak terbatas untuk:</p>
                            <ul style="list-style-type: disc">
                            <li>Memproses data Saudara, termasuk namun tidak terbatas pada laporan keuangan, pengajuan perpajakan, faktur penjualan atau pembelian, laporan usaha, dan lainnya;</li>
                            <li>Mengantar surat dan barang yang Saudara beli dari kami;</li>
                            <li>Menginformasikan pengembangan Produk, penawaran penjualan dan perawatan atau gangguan apa pun yang mungkin Saudara hadapi;</li>
                            <li>Melakukan proses pembayaran; dan</li>
                            <li>Mengetahui informasi kunjungan Saudara, seperti waktu kunjungan dan apa yang Saudara lakukan dalam kunjungan tersebut.</li>
                            </ul>
                            <p>Kami juga dapat mengumpulkan dan menggunakan data Saudara yang tidak dapat diidentifikasi sebagai pribadi, untuk:</p>
                            <ul style="list-style-type: disc">
                            <li>Mengoptimalkan Produk, Situs, kampanye pemasaran, dan lainnya;</li>
                            <li>Membantu Kami untuk mengetahui bagaimana cara Saudara menggunakan Produk;</li>
                            <li>Melihat efektifitas Situs dan Produk;</li>
                            <li>Menemukan dan menyelesaikan masalah yang ada di Situs dan Produk; dan</li>
                            <li>Mengembangkan Product.</p>
                            </ul>
                            <p><b>Pembagian data ke pihak ketiga</b></p>
                            <p>Kami tidak akan menjual, menyewakan, atau menyebarkan data Saudara tanpa izin dari Saudara kecuali ditentukan lain dalam Kebijakan ini. Kami hanya akan mengungkapkan data Saudara kepada pihak ketiga atas izin Saudara atau jika diperlukan untuk mengakomodir kebutuhan penggunaan Produk Saudara.</p>
                            <p>Dengan memberikan izin apapun untuk mengungkapkan data Saudara, Saudara mengizinkan Kami untuk mengungkapkan dan mengirimkan data tersebut ke pihak ketiga terpilih, dan Saudara membebaskan Kami atas segala kerugian atau kerusakan yang timbul dari kegagalan pihak ketiga untuk mengamankan data Saudara. Kami tidak dapat menjamin keamanan data Saudara pada sistem pihak ketiga dan Kami tidak memiliki kontrol atau tanggung jawab atas kebijakan privasi atau konten dari aplikasi pihak ketiga. Saudara memiliki tanggung jawab untuk memeriksa kebijakan privasi dari setiap pihak ketiga, sehingga Saudara dapat memahami bagaimana mereka akan menangani data Saudara.</p>
                            <p>Kami mungkin mengungkapkan data Saudara tanpa persetujuan Saudara untuk mematuhi perintah pengadilan atau keputusan badan pemerintah yang sah atau peraturan yang berlaku. Kemudian apabila memungkinkan dan diperbolehkan, Kami akan memberi tahu Saudara apabila Kami mengungkapkan data Saudara.</p>
                            <p><b>Penggunaan Cookies</b></p>
                            <p>Cookies merupakan berkas teks yang ditempatkan di komputer Saudara untuk kepentingan pencatatan. Kami menggunakan cookies untuk membantu Kami memberikan Saudara kemudahan dalam menggunakan Produk. Cookies tidak dapat digunakan untuk menjalankan program atau mengirim virus ke komputer Saudara.</p>
                            <p>Cookies akan mencatat data Saudara seperti data yang Saudara simpan ke Situs atau Produk. Sebagai contoh, jika Saudara membuat akun di dalam Situs, cookies akan membantu Kami untuk mengingat data yang spesifik untuk kunjungan Saudara berikutnya. Ketika Saudara kembali ke dalam Situs, data yang Saudara berikan sebelumnya akan diberikan kembali, sehingga akan menjadi lebih mudah apabila Saudara mengaktifkan cookies Saudara.</p>
                            <p>Sebagai tambahan, pihak lainnya juga dapat menganalisa data untuk Kami, seperti Google Analytics. Mereka dapat mengumpulkan data Saudara yang tidak dapat diidentifikasi sebagai pribadi tentang aktivitas online Saudara saat Saudara menggunakan Produk Kami atau mengakses Situs.</p>
                            <p><b>Keamanan Data</b></p>
                            <p>Kami selalu berusaha meningkatkan keamanan data Saudara dengan menggunakan teknologi terbaru dan mematuhi peraturan yang berlaku untuk memenuhi harapan pihak terkait, dan untuk memastikan peningkatan kualitas yang berkelanjutan. Selanjutnya, Kami menjadikan perlindungan data Saudara sebagai prioritas Kami dengan menggunakan Standar tertinggi untuk mengamankan data Saudara.</p>
                            <p><b>Kontak</b></p>
                            <p>Apabila Saudara ingin mengajukan keluhan tentang data Saudara atau Saudara memiliki pertanyaan lain mengenai privasi atau keamanan data Saudara silahkan menghubungi Kami melalui:</p>
                            <ul style="list-style-type: disc">
                            <li>E-mail : contact@enforcea.com</li>
                            <li>Telepon : +62 21 7918 2328 </li>
                            <li>Fax : +62 21 7975 5981</li>
                            <li>Alamat : Wisma Korindo, 5th Floor, Jalan MT Haryono Kav. 62, Pancoran, Jakarta Selatan, Indonesia - 12780.</li>
                            </ul>
                            <p><b>Perubahan terhadap Kebijakan Privasi</b></p>
                            <p>Kami memiliki hak untuk mengubah Kebijakan ini sewaktu-waktu yang akan berlaku efektif ketika telah diunggah ke Situs. Pembaharuan Kebijakan dapat mempengaruhi penggunaan Saudara atas Produk atau Situs atau keamanan data Saudara. Kami akan melakukan pemberitahuan kepada Saudara mengenai perubahan yang telah Kami lakukan (jika diperlukan), dengan cara dan rentang waktu yang wajar. Apabila Saudara tetap melanjutkan penggunaan Produk, maka hal tersebut akan dianggap sebagai persetujuan terhadap segala perubahan Kebijakan.</p>
                        </div>''';
  final String htmlContent = '''<div class="woocommerce" >
                        <p>Syarat-syarat ini mengikat dan mulai berlaku untuk Saudara saat Saudara mulai mengakses layanan apapun dari EnforceA.</p>
                    <p>Layanan EnforceA dapat berubah dari waktu ke waktu berdasarkan kesan & saran dari pengguna. Syarat-syarat ini tidak dimaksudkan untuk menjawab setiap pertanyaan atau menunjukkan setiap masalah yang dapat timbul dari penggunaan layanan EnforceA. EnforceA berhak untuk mengubah Syarat & Ketentuan ini kapan saja, dan mulai berlaku pada saat Syarat & Ketentuan yang baru atau yang telah direvisi di lampirkan di Website EnforceA. EnforceA akan berusaha untuk mengumumkan dan menyampaikan perubahan-perubahannya kepada Saudara melalui email atau pemberitahuan melalui Website. Karena Syarat & Ketentuan ini dapat berubah dari waktu ke waktu, maka menjadi kewajiban Saudara untuk memastikan bahwa Saudara sudah membaca, mengerti, dan menyetujui Syarat & Ketentuan terbaru yang tersedia pada Website EnforceA.</p>
                    <p>Dengan mendaftarkan diri untuk menggunakan layanan EnforceA, Saudara menyatakan bahwa Saudara sudah membaca dan mengerti Syarat & Ketentuan ini, dan dianggap memiliki wewenang untuk bertindak atas nama siapapun yang terdaftar untuk menggunakan layanan kami.</p>
                    <p></p>
                    <p>Syarat & Ketentuan ini berlaku mulai tanggal 1 Januari 2020.</p>
                    <p><b>1. Syarat & Ketentuan EnforceA</b></p>
                    <ul style="list-style-type: none">
                        <li>a) Perjanjian – berarti Syarat & Ketentuan ini;</li>
                        <li>b) Biaya penggunaan jasa – berarti biaya bulanan (belum termasuk pajak) yang harus Saudara bayar sesuai daftar biaya yang dicantumkan pada Website EnforceA (yang EnforceA dapat merubah dari waktu ke waktu dengan sepengetahuan Saudara);</li>
                        <li>c) Informasi Rahasia – melingkup semua informasi yang dikomunikasikan antara pihak Perjanjian ini, baik secara tertulis, elektronik, atau lisan, termasuk Layanan ini, tapi tidak termasuk informasi yang sudah menjadi atau akan dijadikan untuk publik, terkecuali yang sudah diungkapkan dan terbongkar tanpa hak atau oleh pihak pengguna atau lainnya secara tidak sah;</li>
                        <li>d) Data – berarti data apapun yang dikirim dan diserahkan Pelanggan ke EnforceA dan laporan keuangan dan perpajakan yang disediakan oleh EnforceA berdasarkan data yang dikirim dan diserahkan Pelanggan kepada EnforceA;</li>
                        <li>e) Hak Kekayaan Intelektual – berarti paten, merek dagang, merek jasa atau layanan, hak cipta, hak pada disain, pengetahuan, atau hak kekayaan intelektual atau industri lainnya, maupun terdaftar atau tidak terdaftar;</li>
                        <li>f) Layanan – berarti layanan jasa akunting dan laporan perpajakan, dan operasional yang disediakan (dan dapat dirubah atau diperbarui dari waktu ke waktu) melalui Website;</li>
                        <li>g) Website – berarti situs internet di domain www.enforcea.com atau situs internet lainnya yang di kelola oleh EnforceA;</li>
                        <li>h) EnforceA – berarti Firma Sudiarta dan Rekan yang terdaftar di Indonesia.</li>
                        <li>i) Pengguna Diundang – berarti setiap orang atau badan, selain Pelanggan, yang memakai Layanan dari waktu ke waktu dengan izin dari Pelanggan;</li>
                        <li>j)	Pelanggan - berarti orang, maupun atas nama pribadi, organisasi atau badan lainnya, yang mendaftar untuk menggunakan Layanan;</li>
                        <li>k) Saudara - berarti Pelanggan atau Pengguna Diundang.</li>
                    </ul>
                    <p><b>2. Penggunaan Layanan</b></p>
                    <p>EnforceA memberi Saudara hak untuk mengakses dan memakai Layanan EnforceA melalui Website EnforceA dengan peran penggunaan yang sudah ditentukan untuk Saudara, sesuai dengan jenis layanan yang Saudara pilih. Hak ini non-eksklusif, tidak dapat dipindahtangankan, dan dibatasi oleh dan bergantung pada perjanjian ini. Saudara mengakui dan menyetujui, bergantung kepada perjanjian tulis apapun yang berlaku antara Pelanggan dan Pengguna Diundang, atau hukum lainnya yang berlaku:</p>
                    <ul style="list-style-type: none">
                        <li>a. Bahwa Pelanggan dapat menggunakan layanan jasa accounting dan perpajakan yang disediakan EnforceA terhitung tanggal yang disepakati dan pembayaran telah dilakukan ke Rekening Bank EnforceA;</li>
                        <li>b. Bahwa adalah tanggung jawab Pelanggan untuk menentukan siapa yang mendapat akses sebagai Pengguna Diundang dan jenis peran dan hak yang mereka punya untuk mengakses jenis data yang Saudara miliki;</li>
                        <li>c. Bahwa tanggung jawab Pelanggan untuk semua penggunaan Layanan oleh Pengguna Diundang;</li>
                        <li>d. Bahwa tanggung jawab Pelanggan untuk mengendalikan setiap tingkat akses untuk Pengguna Diundang kepada organisasi dan Layanan yang relevan setiap saat, dan bisa menarik atau mengubah akses atau tingkat akses Pengguna Diundang kapanpun, untuk alasan apapun dan dalam hal manapun;</li>
                        <li>e. Jika ada perselisihan antara Pelanggan dan Pengguna Diundang mengenai akses kepada organisasi atau Layanan apapun, Pelanggan lah yang harus membuat keputusan dan mengatur akses atau tingkat akses ke Data atau Layanan yang Pengguna Diundang akan dapat, jika ada.</li>
                    </ul>
                    <p><b>3. Ketersediaan Pelayanan Kami</b></p>
                    <p>Pelayanan dan support yang kami lakukan melalui 3 bentuk :</p>
                    <ul style="list-style-type: none">
                    <li>a) Chat: 9.00 – 17.00, Hari Senin – Jumat
                        Chat yang diterima di luar jam kerja akan dibalas melalui email dalam kurun waktu 24 jam. Chat yang dilakukan Jumat di atas jam 17.00 dan pada hari libur akan direspon selambatnya pada hari kerja berikutnya.
                        </li>
                    <li>b) Telepon: 9.00 – 17.00, Hari Senin – Jumat</li>
                    <li>c) Email: 9.00 – 17.00, Hari Senin – Jumat
                        Email yang diterima di luar jam kerja akan dibalas dalam kurun waktu 24 jam.  Email yang diterima pada Jumat di atas jam 17.00 dan pada hari libur akan direspon selambatnya pada hari kerja berikutnya.
                        </li>
                    </ul>
                    <p><b>4. Kewajiban Saudara</b></p>
                    <ul style="list-style-type: none">
                        <li>a) Kewajiban Pembayaran</li>
                        Tagihan (invoice) atas penggunaan jasa EnforceA akan dibuat dan diterbitkan sesuai dengan perjanjian yang disepakati, dimulai tanggal perjanjian berlangganan untuk Layanan EnforceA. Jangka waktu pembayaran tagihan adalah 7 hari kerja terhitung tanggal tagihan (invoice). Semua tagihan akan ditambah PPN 10%. EnforceA akan terus membuat tagihan untuk Saudara sampai perjanjian penggunaan jasa EnforceA oleh Saudara diakhiri.
                        Semua tagihan dari EnforceA akan dikirim kepada Saudara, atau kepada kontak penagihan yang telah Saudara berikan, melalui email. Saudara juga diminta untuk menyimpan bukti transaksi.</li>
                        <p>b) Kewajiban Umum</p>
                        <p>Saudara harus memastikan hanya memakai Layanan dan Website untuk keperluan internal bisnis Saudara yang benar dan secara sah, dengan Syarat dan Ketentuan dan pemberitahuan yang diumumkan oleh EnforceA atau ketentuan yang tercantum di Website. Saudara boleh memakai Layanan dan Website atas nama orang atau badan lain, atau untuk memberi layanan kepada mereka, tetapi Saudara harus memastikan bahwa Saudara mempunyai wewenang untuk melakukannya, dan semua pihak yang menerima Layanan melalui Saudara memenuhi dan menyetujui semua syarat dalam Perjanjian ini yang berlaku kepada Saudara;</p>
                        <p>c) Syarat Akses</p>
                        <p>Saudara harus memastikan bahwa semua username dan password yang diperlukan untuk mengakses Layanan EnforceA tersimpan dengan aman dan secara rahasia. Saudara harus segera memberitahu EnforceA mengenai pemakaian password Saudara dari pihak yang tidak berwenang, atau pelanggaran keamanan lainnya, dan EnforceA akan reset password Saudara, dan Saudara harus melakukan semua tindakan lainnya yang dianggap cukup penting oleh EnforceA untuk mempertahankan atau meningkatkan keamanan sistem computer dan jaringan EnforceA, dan akses Saudara kepada Layanan kami.</p>

                    <p>Sebagai syarat dari Ketentuan-ketentuan ini, saat mengakses dan menggunakan Layanan EnforceA, Saudara harus:</p>
                    <ul style="list-style-type: none">
                    <p>i. Tidak mencoba untuk melemahkan keamanan atau integritas dari sistem komputer atau jaringan EnforceA, atau jika Layanan-nya di host oleh pihak ketiga, sistem komputer atau jaringan pihak ketiga itu;</p>
                    <p>ii. Tidak menggunakan atau menyalahgunakan Layanan EnforceA dengan cara apapun yang dapat mengganggu kemampuan pengguna lain untuk menggunakan Layanan atau Website;</p>
                    <p>iii.	Tidak mencoba untuk mendapatkan akses yang tidak sah kepada materi apapun selain yang sudah dinyatakan dengan jelas bahwa Saudara telah mendapatkan izin untuk mengakses-nya, atau untuk mengakses sistem komputer kami dimana Layanan-nya di host;</p>
                    <p>iv. Tidak mengirimkan, atau memasukan kedalam Website: file apapun yang dapat merusak alat komputer atau software orang lain, bahan-bahan yang menghina, atau materi atau Data yang melanggar hukum apapun (termasuk Data atau materi lainnya yang terlindungi oleh hak cipta atau rahasia dagang dimana Saudara tidak memiliki hak untuk memakainya);</p>
                    <p>v. Tidak mencoba untuk mengubah, menyalin, meniru, membongkar, atau melakukan reverse engineering untuk program komputer apapun yang dipakai untuk memberi Layanan EnforceA, atau untuk menggunakan Website diluar penggunaan yang diperlukan dan dimaksudkan.</p>
                    </ul>
                    <p>d) Batasan Penggunaan</p>
                    <p>Penggunaan Layanan EnforceA mungkin suatu saat dapat dibatasi, dan tidak terbatas kepada, fasilitas-fasilitas yang disediakan dan yang diizinkan untuk diakses. Bila ada, batasan-batasan tersebut akan ditentukan dan dicantumkan pada Layanan yang terkait.</p>
                    <p>e) Syarat Komunikasi</p>
                    <p>Sebagai syarat pada Ketentuan ini, jika Saudara memakai alat komunikasi apapun yang tersedia melalui Website (seperti forum apapun atau ruang chat), Saudara setuju untuk memakai alat-alat komunikasi tersebut hanya untuk tujuan yang sah. Saudara tidak boleh memakai alat-alat komunikasi tersebut untuk memasang atau menyebarkan materi apapun yang tidak terkait dengan pemakaian Layanan-nya, termasuk (tapi tidak terbatas dengan): menawarkan barang dan jasa untuk dijual, e-mail komersial yang tidak diminta atau diinginkan, file yang dapat merusak alat komputer atau software orang lain, bahan-bahan yang mungkin dapat menghina pengguna Layanan atau Website yang lain, atau materi yang melanggar hukum apapun (termasuk materi yang terlindungi oleh hak cipta atau rahasia dagang dimana Saudara tidak memiliki hak untuk memakainya).</p>
                    <p>Saat Saudara melakukan komunikasi dalam bentuk apapun di Website, Saudara menjamin bahwa Saudara diperbolehkan untuk membuat komunikasi tersebut. EnforceA tidak berkewajiban untuk memastikan bahwa komunikasi pada Website adalah sah dan benar, atau bahwa mereka terkait hanya pada penggunaan Layanan. EnforceA berhak untuk menghapus komunikasi apapun setiap saat atas kebijakannya sendiri.</p>
                    <p>f) Tanggung Jawab Ganti Rugi</p>
                    <p>Saudara membebaskan EnforceA dari semua: tuntutan, gugatan, biaya kerugian, kerusakan, dan kehilangan yang timbul sebagai hasil dari pelanggaran Saudara kepada Syarat dan Ketentuan yang tertera di Perjanjian ini, atau kewajiban apapun yang mungkin Saudara punya kepada EnforceA, termasuk (tapi tidak terbatas kepada) biaya apapun yang berkaitan biaya atas penggunaan jasa apapun yang sudah jatuh tempo tetapi belum Saudara bayar.</p>
                    </ul>
                    <p><b>5. Kerahasiaan dan Privasi</b></p>
                    <ul style="list-style-type: none">
                    <p>a) Kerahasiaan</p>
                    <p>Masing-masing pihak berjanji untuk menjaga kerahasiaan semua Informasi Rahasia pihak lainnya sehubungan dengan ketentuan ini. Setiap pihak TIDAK AKAN, tanpa persetujuan tertulis dari pihak yang lain, mengungkapkan atau memberi Informasi Rahasia kepada siapapun, atau menggunakannya untuk kepentingan sendiri, selain sebagaimana dimaksud oleh Ketentuan ini.</p>
                    <p>Kewajiban masing-masing pihak dalam ketentuan ini akan bertahan walaupun setelah pemutusan Ketentuan ini.</p>
                    <p>Ketentuan-ketentuan pasal tidak berlaku untuk informasi yang:</p>
                    <ul style="list-style-type: none">
                    <p>i. Telah menjadi pengetahuan umum selain karena pelanggaran ketentuan ini;</p>
                    <p>ii. Diterima dari pihak ketiga yang dengan secara sah memperolehnya, dan tidak mempunyai kewajiban untuk membatasi pengungkapannya;</p>
                    <p>iii. Dikembangkan dengan sendiri tanpa akses kepada Informasi Rahasia.</p>
                    </ul>
                    <p>b. Privasi</p>
                    <p>EnforceA memiliki dan mempertahankan kebijakan privasi yang menjelaskan dan menetapkan kewajiban para pihak untuk menghormati informasi pribadi. Saudara disarankan membaca kebijakan privasi kami di www.enforcea.com/privacy, dan Saudara akan dianggap sudah menyetujui kebijakan itu saat Saudara menyetujui ketentuan ini.</p>
                    </ul>
                    <p><b>6. Intellectual Property</b></p>
                    <p>Kepemilikan dan semua Hak Kekayaan Intelektual yang didapat pada Layanan, Website, dan dokumentasi apapun yang terkait dengan Layanan tetap menjadi hak milik EnforceA.</p>
                    <p>Kepemilikan dan semua Hak Kekayaan Intelektual yang terdapat di Data tetap menjadi hak milik Saudara. Akan tetapi, akses kepada Data Saudara bergantung pada pelunasan Biaya penggunaan jasa EnforceA saat tagihan jatuh tempo. Saudara memberi izin kepada EnforceA untuk memakai, menyalin, mengirim, menyimpan, dan melakukan back-up untuk informasi dan Data Saudara dengan maksud dan tujuan memberi Saudara akses kepada dan agar dapat menggunakan Layanan EnforceA, atau untuk tujuan lainnya yang terkait dengan penyediaan layanan kami untuk Saudara.</p>
                    <p>Saudara sangat disarankan untuk menyimpan salinan semua Data yang Saudara masukan ke dalam Layanan EnforceA. EnforceA mematuhi kebijakan dan menjalani prosedur terbaik untuk mencegah kehilangan data, termasuk rutinitas sistem harian untuk back-up data, tetapi tidak membuat jaminan apapun bahwa tidak akan pernah adanya kehilangan Data. EnforceA dengan jelas mengesampingkan tanggung jawab untuk setiap kehilangan Data dengan sebab apapun.</p>
                    <p><b>7. Jaminan dan Pengakuan</b></p>
                    <ul style="list-style-type: none">
                    <p>a) Saudara menjamin bahwa, jika Saudara mendaftar untuk menggunakan Layanan atas nama orang lain, Saudara memiliki wewenang untuk menyetujui Ketentuan-ketentuan ini atas nama orang tersebut, dan menyetujui bahwa dengan mendaftar untuk memakai Layanan EnforceA, Saudara mengikat orang yang Saudara atas namakan untuk, atau dengan niat untuk, membuat tindakan atas nama mereka kepada setiap kewajiban manapun yang Saudara telah setujui pada Ketentuan-ketentuan ini, tanpa membatasi kewajiban Saudara sendiri kepada ketentuannya.</p>
                    <p>b) Saudara mengakui bahwa:</p>
                    <p>i. Saudara memiliki wewenang untuk menggunakan Layanan dan Website, dan untuk mengakses informasi dan Data yang Saudara masukan kedalam Website, termasuk informasi atau Data apapun yang dimasukan kedalam Website oleh siapapun yang Saudara telah beri kewenangan untuk menggunakan Layanan EnforceA.</p>
                    <p>Saudara juga berwenang untuk mengakses informasi dan data yang sudah di proses, yang disediakan untuk Saudara melalui penggunaan Saudara pada Website dan Layanan kami (maupun informasi dan Data itu Saudara miliki sendiri).</p>
                    <p>ii. EnforceA tidak bertanggung jawab kepada siapapun selain Saudara, dan tidak ada maksud apapun dalam Perjanjian ini untuk memberi manfaat kepada siapapun selain Saudara. Jika Saudara memakai Layanan atau mengakses Website atas nama atau untuk manfaat seseorang selain Saudara (maupun organisasi berbadan hukum atau tidak, atau lainnya), Saudara menyetujui bahwa:</p>
                    <ul style="list-style-type: none">
                    <p><i class="fa fa-check-square"></i> Saudara bertanggung jawab untuk memastikan bahwa Saudara memiliki hak untuk melakukannya;</p>
                    <p><i class="fa fa-check-square"></i> Saudara bertanggung jawab atas memberi wewenang kepada siapapun yang Saudara berikan akses kepada informasi atau Data, dan Saudara menyutujui bahwa EnforceA tidak memiliki tanggung jawab untuk menyediakan siapapun akses kepada informasi atau Data tersebut tanpa otorisasi Saudara, dan boleh menunjukan permohonan apapun untuk mendapatkan informasi kepada Saudara untuk di layani;</p>
                    <p><i class="fa fa-check-square"></i> Saudara membebaskan EnforceA dari klaim apapun atau kehilangan yang terkait pada: Penolakan EnforceA untuk menyediakan akses pada siapapun kepada informasi atau Data Saudara sesuai dengan ketentuan ini; Penyediaan informasi atau Data oleh EnforceA kepada siapapun berdasarkan otorisasi Saudara.</p>
                    </ul>
                    <p>iii. Penyediaan, akses kepada, dan pemakaian Layanan EnforceA tersedia sebagaimana adanya dan pada resiko Saudara sendiri.</p>
                    <p>iv. EnforceA tidak menjamin bahwa penggunaan Layanan tidak akan pernah terganggu atau bebas dari kesalahan, antara lain, operasi dan ketersediaan sistem yang digunakan untuk mengakses Layanan, termasuk layanan telpon umum, jaringan komputer dan internet, bisa susah diprediksi dan mungkin bisa dari waktu ke waktu menggangu atau mencegah akses kepada Layanan. EnforceA dengan bagaimanapun tidak bertanggung jawab atas gangguan tersebut, atau pencegahan akses kepada penggunaan Layanan.</p>
                    <p>v. Untuk menentukan bahwa Layanan kami memenuhi keperluan bisnis Saudara dan bisa digunakan sesuai dengan tujuan adalah tanggung jawab Saudara sendiri.</p>
                    <p>vi. Saudara tetap memiliki tanggung jawab untuk mematuhi semua ketentuan perundang-undangan yang berlaku. Menjadi tanggung jawab Saudara untuk memeriksa bahwa penyimpanan dan akses kepada Data Saudara melalui Layanan dan Website tetap mematuhi undang-undang yang berlaku kepada Saudara (termasuk undang-undang apapun yang mewajibkan Saudara untuk menyimpan arsip).</p>
                    <p>vii.	EnforceA tidak memberi jaminan untuk Layanan-nya. Tanpa mengabaikan ketentuan di atas, EnforceA tidak menjamin bahwa Layanan kami akan memenuhi keperluan Saudara, atau bahwa akan sesuai untuk tujuan yang Saudara niatkan. Untuk menghindari keraguan, semua ketentuan atau jaminan yang bisa diartikan dikecualikan sejauh yang diijinkan oleh hukum, termasuk (tanpa batasan) jaminan penjualan, kesesuaian untuk tujuan, dan tanpa pelanggaran.</p>
                    <p>viii. Saudara menjamin dan menunjukkan bahwa Saudara sedang memperoleh hak untuk mengakses dan menggunakan Layanan untuk tujuan bisnis dan bahwa, sampai batas maksimum yang diizinkan oleh hukum, jaminan konsumen berdasarkan hukum atau undang-undang yang dimaksudkan untuk melindungi konsumen non-bisnis di yurisdiksi manapun tidak berlaku untuk penyediaan Layanan, Website, atau ketentuan ini.</p>
                    </ul>
                    <p><b>8. Batasan Kewajiban:</b></p>
                    <ul style="list-style-type: none">
                    <p>a) Jika Saudara mengalami kerugian atau kerusakan apapun karena kelalaian atau kegagalan EnforceA untuk memenuhi ketentuan ini, klaim apapun dari Saudara kepada EnforceA yang timbul dari kelalaian atau kegagalan EnforceA akan terbatas mengenai satu kejadian, atau serangkaian kejadian yang terhubung, maksimum sebesar Biaya penggunaan jasa yang sudah Saudara lunaskan dalam 12 bulan sebelumnya.</p>
                    <p>b) Jika Saudara tidak puas dengan Layanan EnforceA, Saudara dapat berkomunikasi dan menyampaikan langsung melalui Chat dan email untuk menghentikan perjanjian penggunaan jasa atau layanan ini.</p>
                    </ul>
                    <p><b>9. Pemutusan Kontrak:</b></p>
                    <ul style="list-style-type: none">
                    <p>a) EnforceA tidak menyediakan pengembalian uang atau dalam bentuk apapun  untuk periode sisa masa perjanjian jika perjanjian diberhentikan dengan alasan apapun baik oleh Saudara dan atau oleh EnforceA kecuali pengembalian uang tersebut disetujui oleh EnforceA.</p>
                    <p>b) Ketentuan ini akan berlaku untuk periode yang dicakup oleh Biaya penggunaan Jasa EnforceA yang telah dibayar oleh Saudara. Pada masa akhir setiap periode penagihan, Ketentuan ini akan berlanjut secara otomatis untuk periode selanjutnya untuk jangka watu yang sama, asalkan Saudara terus membayar Biaya penggunaan Jasa EnforceA yang sudah ditentukan saat jatuh tempo, kecuali salah satu pihak mengakhiri Ketentuan ini dengan pemberitahuan kepada pihak lainnya setidaknya 30 hari sebelum akhir periode pembayaran yang bersangkutan.</p>
                    <p>c) Dalam hal Saudara tidak melakukan pembayaran atas tagihan (invoice) yang sudah dikirim kepada Saudara 30 hari kalender sejak tanggal tagihan maka hak akses Saudara akan dihentikan sementara (suspend).</p>
                    <p>d) Jika Saudara tidak juga melakukan pembayaran atas tagihan (invoice) yang sudah jatuh tempo 60 hari kalender terhitung tanggal tagihan (invoice) maka perjanjian penggunaan jasa EnforceA otomatis dibatalkan dan hak akses Saudara dihentikan permanen.</p>
                    <p>e) Pelanggaran</p>
                    <p>Jika Saudara melanggar apapun dari Ketentuan ini (termasuk, tapi tidak terbatas dengan, tidak membayar Biaya Akses apapun) dan tidak menyelesaikan masalah pelanggaran dalam 14 hari setelah menerima pemberitahuan pelanggaran tersebut jika permasalahan pelanggaran tersebut bisa di selesaikan;</p>
                    <ul style="list-style-type: none">
                    <p>i. Jika Saudara melanggar apapun dari Ketentuan ini dan pelanggaran itu tidak bisa di selesaikan (termasuk, tapi tidak terbatas dengan) berupa pelanggaran atau kegagalan untuk membayar Biaya penggunaan jasa yang sudah melewati tanggal jatuh tempo lebih dari 30 hari;</p>
                    <p>ii. Jika Saudara atau bisnis Saudara bangkrut, atau sedang melewati proses untuk mengakhiri keberadaan organisasi, EnforceA bisa mengambil salah satu atau semua tindakan berikut:</p>
                    <ul style="list-style-type: none">
                    <p><i class="fa fa-check-square"></i> Mengakhiri Perjanjian ini dan penggunaan Saudara untuk Layanan dan Website kami;</p>
                    <p><i class="fa fa-check-square"></i> Menunda akses Saudara kepada Layanan dan Website EnforceA untuk periode yang tidak menentu;</p>
                    <p><i class="fa fa-check-square"></i> Menunda akses atau mengakhiri akses kepada semua Data atau Data apapun;</p>
                    </ul>
                    <p>iii. Pemutusan Ketentuan ini tidak mengurangi hak dan kewajiban para pihak yang masih harus dibayar sampai dengan tanggal terminasi. Pada pengakhiran Perjanjian ini Saudara akan tetap menanggung biaya yang masih harus dibayar dan jumlah yang jatuh tempo untuk pembayaran sebelum atau setelah pengakhiran, dan segera berhenti menggunakan Layanan dan Website kami.</p>
                    </ul>
                    </ul>
                    <p><b>10. Ketentuan Umum Lainnya</b></p>
                    <ul style="list-style-type: none">
                    <p>a. Syarat dan Ketentuan ini, bersama dengan Kebijakan Privasi EnforceA dan ketentuan dari pemberitahuan atau instruksi yang diberikan kepada Saudara dibawah Syarat dan Ketentuan ini merupakan keseluruhan perjanjian antara Saudara dan EnforceA yang berhubungan dengan Layanan yang diberikan EnforceA.</p>
                    <p>b. Jika salah satu pihak melepaskan tuntutan dari pelanggaran apapun pada Ketentuan ini, ini tidak akan melepaskan mereka dari tuntutan pelanggaran lainnya. Pelepasan dari  Syarat dan Ketentuan tidak efektif kecuali dibuat secara tulisan.</p>
                    <p>c. Para pihak tidak harus bertanggung jawab atas keterlambatan atau kegagalan dalam untuk menyelesaikan kewajibannya dibawah Ketentuan ini jika keterlambatan atau kegagalannya adalah karena sebab apapun yang di luar kendali. Ayat ini tidak berlaku untuk kewajiban pembayaran uang apapun.</p>
                    <p>d. Saudara tidak dapat mengalihkan atau mentransfer hak kepada orang lain tanpa persetujuan tertulis dari EnforceA.</p>
                    <p>e. Apabila terjadi perselisihan antara kedua belah pihak, akan coba diselesaikan secara musyawarah terlebih dahulu untuk mencapai mufakat. Apabila dengan cara tersebut tidak tercapai kata sepakat, maka kedua belah pihak sepakat untuk menyelesaikan permasalahan tersebut dilakukan melalui prosedur hukum dengan memilih kedudukan hukum Republik Indonesia di Kantor Pengadilan Negeri Jakarta Selatan.</p>
                    <p>f. Setiap pemberitahuan yang diberikan berdasarkan Persyaratan ini oleh satu pihak ke yang lain harus dilakukan secara tertulis melalui email dan akan dianggap telah diberikan pada saat transmisi dilakukan. Pemberitahuan kepada EnforceA harus dikirim ke contact@enforcea.com atau ke alamat email lainnya yang diberitahukan kepada Saudara oleh EnforceA. Pemberitahuan kepada Saudara akan dikirim ke alamat email yang Saudara berikan saat membuat akses (Login) Saudara pada Layanan kami.</p>
                    </ul>
					</div>''';
}
