
class EventData {
  String title;
  String value;
  int type;

  static const int PELATIHAN_EVENT = 1;
  static const int VIDEO = 2;
  static const int BUKU_PUBLIKASI = 3;
  static const int REGULASI = 4;

  EventData({this.title = "", this.value = "", this.type});

  static List<EventData> listEvent = <EventData>[
    EventData(
      title:"PELATIHAN & EVENT",
      value:"Kupas Tuntas SAK EMKM dalam Penyusunan Laporan Keuangan UMKM",
      type: PELATIHAN_EVENT,
    ),EventData(
      title:"Title 2",
      value:"Value 2",
      type: PELATIHAN_EVENT,
    ),EventData(
      title:"Title 3",
      value:"Value 3",
      type: VIDEO,
    ),EventData(
      title:"Title 4",
      value:"Value 4",
      type: REGULASI,
    ),EventData(
      title:"Title 5",
      value:"Value 5",
      type: BUKU_PUBLIKASI,
    ),EventData(
      title:"Title 6",
      value:"Value 6",
      type: VIDEO,
    ),
    EventData(
      title:"Title 7",
      value:"Value 7",
      type: BUKU_PUBLIKASI,
    ),
  ];


}
