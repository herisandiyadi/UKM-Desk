import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:enforcea/bottomMenu.dart';

class OnlineConsulting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Online Consulting"),
          backgroundColor: Colors.red[800],
        ),
        body: initView(),
      ),
    );
  }

  Widget initView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset("assets/banner_consulting.jpg"),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bingung mengenai masalah pajak? Anda ingin mendapatkan advis perpajakan atas suatu transaksi?",
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Memahami aspek perpajakan atas suatu transaksi sebelum melakukan eksekusi menentukan masa depan bisnis Anda. Seringkali transaksi dijalankan tanpa memahami hak dan kewajiban yang benar. Hal ini berpotensi menimbulkan risiko pajak yang besar di kemudian hari atau sengketa, tidak hanya dengan otroritas pajak tetapi juga dengan vendor/customer. Oleh karena itu memahami aspek perpajakan atas suatu transaksi penting dilakukan sebelum eksekusi. Mencantumkan hak dan kewajiban pajak secara jelas pada perjanjian/kontrak adalah langkah awal yang benar untuk mendukung profitabilitas perusahaan.",
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Untuk advis perpajakan, Anda dapat menghubungi kami di:",
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tax Services:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      final Uri _emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'contact@enforcea.com',
                          queryParameters: {'subject': 'enforcea:'});
                      _launchURL(_emailLaunchUri.toString());
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Image.asset(
                            "assets/email.png",
                            height: 15,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "contact@enforcea.com",
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {
                      _launchURL("https://wa.me/+6288808197062");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/wa.png",
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "+62 888 0819 7062",
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Khusus untuk Perusahaan kelompok UMKM:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      final Uri _emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'ukmdesk@enforcea.com',
                          queryParameters: {'subject': 'enforcea:'});
                      _launchURL(_emailLaunchUri.toString());
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            "assets/email.png",
                            height: 15,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "ukmdesk@enforcea.com",
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {
                      _launchURL("https://wa.me/+6282297051490");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/wa.png",
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("+62 822 9705 1490")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
