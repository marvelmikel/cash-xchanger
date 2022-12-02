class ScheduleModule {
  String timeA;
  String timeB;
  String price;
  String type;
  String address;
  String name;
  String image;

  ScheduleModule({
    required this.timeA,
    required this.timeB,
    required this.price,
    required this.type,
    required this.address,
    required this.name,
    required this.image,
  });

  static List<ScheduleModule> listOfSchedules = [
    ScheduleModule(
        timeA: '11:35',
        timeB: '11:35',
        price: 'N500,000',
        type: 'Mint',
        name: 'B. Williamson',
        address: '41, Shiriki Street, Agric Area',
        image: 'image'),
    ScheduleModule(
        timeA: '11:35',
        timeB: '11:35',
        price: 'N500,000',
        type: 'Mint',
        name: 'B. Williamson',
        address: '41, Shiriki Street, Agric Area',
        image: 'image'),
    ScheduleModule(
        timeA: '11:35',
        timeB: '11:35',
        price: 'N500,000',
        type: 'Mint',
        name: 'B. Williamson',
        address: '41, Shiriki Street, Agric Area',
        image: 'image'),
    ScheduleModule(
        timeA: '11:35',
        timeB: '11:35',
        price: 'N500,000',
        type: 'Mint',
        name: 'B. Williamson',
        address: '41, Shiriki Street, Agric Area',
        image: 'image'),
  ];
}
