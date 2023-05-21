import 'package:sales/app/components/thanalist.dart';

class BANGLADESHGEOCODE {
  static returnThana({required String districtName}) {
    dynamic listOfThana = {
      "Bagerhat": [
        "Bagerhat Sadar",
        "Chitalmari",
        "Fakirhat",
        "Kachua",
        "Mollahat",
        "Mongla",
        "Morrelganj",
        "Rampal",
        "Sarankhola"
      ],
      "Bandarban": [
        "Ali kadam",
        "Bandarban Sadar",
        "Lama",
        "Naikhongchhari",
        "Rowangchhari",
        "Ruma",
        "Thanchi"
      ],
      "Barguna": [
        "Amtali",
        "Bamna",
        "Barguna Sadar",
        "Betagi",
        "Patharghata",
        "Taltali"
      ],
      "Barisal": [
        "Agailjhara",
        "Babuganj",
        "Bakerganj",
        "Banaripara",
        "Barisal Sadar",
        "Gaurnadi",
        "Hizla",
        "Mehendiganj",
        "Muladi",
        "Wazirpur"
      ],
      "Bhola": [
        "Bhola Sadar",
        "Burhanuddin",
        "Char Fasson",
        "Daulatkhan",
        "Lalmohan",
        "Manpura",
        "Tazumuddin"
      ],
      "Bogra": [
        "Adamdighi",
        "Bogra Sadar",
        "Dhunat",
        "Dhupchanchia",
        "Gabtali",
        "Kahaloo",
        "Nandigram",
        "Sariakandi",
        "Sherpur",
        "Shibganj",
        "Sonatola"
      ],
      "Brahmanbaria": [
        "Akhaura",
        "Bancharampur",
        "Bijoynagar",
        "Brahmanbaria Sadar",
        "Kasba",
        "Nabinagar",
        "Nasirnagar",
        "Sarail"
      ],
      "Chandpur": [
        "Chandpur Sadar",
        "Faridganj",
        "Haimchar",
        "Haziganj",
        "Kachua",
        "Matlab Dakshin",
        "Matlab Uttar",
        "Shahrasti"
      ],
      "Chapainawabganj": [
        "Bholahat",
        "Chapainawabganj Sadar",
        "Gomastapur",
        "Nachole",
        "Rohanpur",
        "Shibganj"
      ],
      "Chittagong": [
        "Anwara",
        "Banshkhali",
        "Boalkhali",
        "Chandanaish",
        "Chittagong Port",
        "Double Mooring",
        "Fatikchhari",
        "Hathazari",
        "Karnaphuli",
        "Kotwali",
        "Kutubdia",
        "Lohagara",
        "Mirsharai",
        "Pahartali",
        "Panchlaish",
        "Patenga",
        "Rangunia",
        "Raozan",
        "Sandwip",
        "Satkania",
        "Sitakunda"
      ],
      "Chuadanga": ["Alamdanga", "Chuadanga Sadar", "Damurhuda", "Jibannagar"],
      "Comilla": [
        "Barura",
        "Brahmanpara",
        "Burichong",
        "Chandina",
        "Chauddagram",
        "Comilla Sadar Dakshin",
        "Comilla Sadar",
        "Daudkandi",
        "Debidwar",
        "Homna",
        "Laksam",
        "Langalkot",
        "Muradnagar",
        "Nangalkot",
        "Titas"
      ],
      "Cox's Bazar": [
        "Chakaria",
        "Cox's Bazar Sadar",
        "Kutubdia",
        "Maheshkhali",
        "Pekua",
        "Ramu",
        "Teknaf",
        "Ukhia"
      ],
      "Dhaka": [
        "Adabor",
        "Badda",
        "Bangsal",
        "Biman Bandar",
        "Cantonment",
        "Chawkbazar Model",
        "Dakshinkhan",
        "Darussalam",
        "Demra",
        "Dhamrai",
        "Dhanmondi",
        "Gandaria",
        "Gulshan",
        "Hazaribagh",
        "Jatrabari",
        "Kafrul",
        "Kalabagan",
        "Kamrangirchar",
        "Khilgaon",
        "Khilkhet",
        "Kotwali",
        "Lalbagh",
        "Mirpur Model",
        "Mohammadpur",
        "Motijheel",
        "Nawabganj",
        "New Market",
        "Pallabi",
        "Paltan",
        "Ramna",
        "Rampura",
        "Sabujbagh",
        "Shah Ali",
        "Shahbagh",
        "Sher-e-Bangla Nagar",
        "Shyampur",
        "Sutrapur",
        "Tejgaon Industrial Area",
        "Tejgaon",
        "Turag",
        "Uttara"
      ],
      "Dinajpur": [
        "Birampur",
        "Birganj",
        "Bochaganj",
        "Chirirbandar",
        "Dinajpur Sadar",
        "Fulbari",
        "Ghoraghat",
        "Hakimpur",
        "Kaharole",
        "Khansama",
        "Nawabganj",
        "Parbatipur"
      ],
      "Faridpur": [
        "Alfadanga",
        "Bhanga",
        "Boalmari",
        "Charbhadrasan",
        "Faridpur Sadar",
        "Madhukhali",
        "Nagarkanda",
        "Sadarpur",
        "Saltha"
      ],
      "Feni": ["Chagalnaiya", "Daganbhuiyan", "Feni Sadar", "Parshuram"],
      "Gaibandha": [
        "Fulchhari",
        "Gaibandha Sadar",
        "Gobindaganj",
        "Palashbari",
        "Sadullapur",
        "Saghata",
        "Sundarganj"
      ],
      "Gazipur": [
        "Gazipur Sadar",
        "Kaliganj",
        "Kaliakair",
        "Kapasia",
        "Sreepur"
      ],
      "Gopalganj": [
        "Gopalganj Sadar",
        "Kashiani",
        "Kotalipara",
        "Muksudpur",
        "Tungipara"
      ],
      "Habiganj": [
        "Azmireeganj",
        "Baniachong",
        "Chunarughat",
        "Habiganj Sadar",
        "Lakhai",
        "Madhabpur",
        "Nabiganj"
      ],
      "Jamalpur": [
        "Baksiganj",
        "Dewanganj",
        "Islampur",
        "Jamalpur Sadar",
        "Madarganj",
        "Melandaha",
        "Sarishabari"
      ],
      "Jessore": [
        "Abhaynagar",
        "Bagherpara",
        "Chaugachha",
        "Jessore Sadar",
        "Jhikargachha",
        "Keshabpur",
        "Manirampur",
        "Sharsha"
      ],
      "Jhalokati": ["Jhalokati Sadar", "Kathalia", "Nalchity"],
      "Jhenaidah": [
        "Harinakundu",
        "Jhenaidah Sadar",
        "Kaliganj",
        "Kotchandpur",
        "Maheshpur",
        "Shailkupa"
      ],
      "Joypurhat": [
        "Akkelpur",
        "Joypurhat Sadar",
        "Kalai",
        "Khetlal",
        "Panchbibi"
      ],
      "Khagrachhari": [
        "Dighinala",
        "Khagrachhari Sadar",
        "Lakshmichhari",
        "Mahalchhari",
        "Manikchhari",
        "Matiranga",
        "Panchhari",
        "Ramgarh"
      ],
      "Khulna": [
        "Batiaghata",
        "Dacope",
        "Daulatpur",
        "Digholia",
        "Dumuria",
        "Khalishpur",
        "Khan Jahan Ali",
        "Khulna Sadar",
        "Koyra",
        "Paikgachha",
        "Phultala",
        "Rupsa",
        "Terokhada"
      ],
      "Kishoreganj": [
        "Austagram",
        "Bajitpur",
        "Bhairab",
        "Hossainpur",
        "Itna",
        "Karimganj",
        "Katiadi",
        "Kishoreganj Sadar",
        "Kuliarchar",
        "Mithamain",
        "Nikli",
        "Pakundia",
        "Tarail"
      ],
      "Kurigram": [
        "Bhurungamari",
        "Char Rajibpur",
        "Chilmari",
        "Kurigram Sadar",
        "Nageshwari",
        "Phulbari",
        "Raomari",
        "Rajarhat",
        "Roumari",
        "Ulipur"
      ],
      "Kushtia": [
        "Bheramara",
        "Daulatpur",
        "Kumarkhali",
        "Kushtia Sadar",
        "Mirpur"
      ],
      "Lakshmipur": [
        "Char Alexgander",
        "Kamalnagar",
        "Lakshmipur Sadar",
        "Ramganj",
        "Raipur"
      ],
      "Lalmonirhat": [
        "Aditmari",
        "Hatibandha",
        "Kaliganj",
        "Lalmonirhat Sadar",
        "Patgram"
      ],
      "Madaripur": ["Kalkini", "Madaripur Sadar", "Rajoir"],
      "Magura": ["Magura Sadar", "Mohammadpur", "Shalikha", "Sreepur"],
      "Manikganj": [
        "Daulatpur",
        "Ghior",
        "Harirampur",
        "Manikganj Sadar",
        "Saturia",
        "Shibalaya",
        "Singair"
      ],
      "Meherpur": ["Gangni", "Meherpur Sadar", "Mujib Nagar"],
      "Moulvibazar": [
        "Barlekha",
        "Juri",
        "Kamalganj",
        "Kulaura",
        "Moulvibazar Sadar",
        "Rajnagar",
        "Sreemangal"
      ],
      "Munshiganj": [
        "Gazaria",
        "Lohajang",
        "Munshiganj Sadar",
        "Sirajdikhan",
        "Sreenagar",
        "Tongibari"
      ],
      "Mymensingh": [
        "Bhaluka",
        "Dhobaura",
        "Fulbaria",
        "Gaffargaon",
        "Gauripur",
        "Haluaghat",
        "Ishwarganj",
        "Muktagacha",
        "Mymensingh Sadar",
        "Nandail",
        "Phulpur",
        "Trishal"
      ],
      "Naogaon": [
        "Atrai",
        "Badalgachhi",
        "Dhamoirhat",
        "Manda",
        "Mohadevpur",
        "Naogaon Sadar",
        "Niamatpur",
        "Patnitala",
        "Porsha",
        "Raninagar",
        "Sapahar"
      ],
      "Narail": ["Kalia", "Lohagara", "Narail Sadar"],
      "Narayanganj": [
        "Araihazar",
        "Bandar",
        "Narayanganj Sadar",
        "Rupganj",
        "Sonargaon"
      ],
      "Narsingdi": ["Belabo", "Monohardi", "Narsingdi Sadar", "Palash"],
      "Natore": [
        "Bagatipara",
        "Baraigram",
        "Gurudaspur",
        "Lalpur",
        "Naldanga",
        "Natore Sadar",
        "Singra"
      ],
      "Nawabganj": ["Bholahat", "Gomastapur", "Nawabganj Sadar", "Shibganj"],
      "Netrakona": [
        "Atpara",
        "Barhatta",
        "Durgapur",
        "Khaliajuri",
        "Kalmakanda",
        "Kendua",
        "Madan",
        "Mohanganj",
        "Netrakona Sadar",
        "Purbadhala"
      ],
      "Nilphamari": [
        "Dimla",
        "Domar",
        "Jaldhaka",
        "Kishoreganj",
        "Nilphamari Sadar",
        "Saidpur"
      ],
      "Noakhali": [
        "Begumganj",
        "Chatkhil",
        "Companiganj",
        "Hatiya",
        "Kabirhat",
        "Noakhali Sadar",
        "Senbagh",
        "Sonaimuri",
        "Subarnachar"
      ],
      "Pabna": [
        "Atgharia",
        "Bera",
        "Bhangura",
        "Chatmohar",
        "Faridpur",
        "Ishwardi",
        "Pabna Sadar",
        "Santhia",
        "Sujanagar"
      ],
      "Panchagarh": [
        "Atwari",
        "Boda",
        "Debiganj",
        "Panchagarh Sadar",
        "Tetulia"
      ],
      "Patuakhali": [
        "Bauphal",
        "Dasmina",
        "Galachipa",
        "Kalapara",
        "Mirzaganj",
        "Patuakhali Sadar",
        "Rangabali"
      ],
      "Pirojpur": [
        "Bhandaria",
        "Kawkhali",
        "Mathbaria",
        "Nazirpur",
        "Pirojpur Sadar",
        "Zianagar",
        "Nesarabad"
      ],
      "Rajbari": ["Baliakandi", "Goalandaghat", "Pangsha", "Rajbari Sadar"],
      "Rajshahi": [
        "Bagha",
        "Bagmara",
        "Charghat",
        "Durgapur",
        "Godagari",
        "Mohanpur",
        "Paba",
        "Puthia",
        "Rajshahi Sadar",
        "Tanore"
      ],
      "Rangamati": [
        "Baghaichhari",
        "Barkal",
        "Kaptai",
        "Juraichhari",
        "Langadu",
        "Naniachar",
        "Rajasthali",
        "Rangamati Sadar"
      ],
      "Rangpur": [
        "Badarganj",
        "Gangachara",
        "Kaunia",
        "Mithapukur",
        "Pirgachha",
        "Pirganj",
        "Rangpur Sadar",
        "Taraganj"
      ],
      "Satkhira": [
        "Assasuni",
        "Debhata",
        "Kalaroa",
        "Kaliganj",
        "Satkhira Sadar",
        "Shyamnagar",
        "Tala"
      ],
      "Shariatpur": [
        "Bhedarganj",
        "Damudya",
        "Gosairhat",
        "Naria",
        "Shariatpur Sadar",
        "Zanjira"
      ],
      "Sherpur": [
        "Jhenaigati",
        "Nakla",
        "Nalitabari",
        "Sherpur Sadar",
        "Sreebardi"
      ],
      "Sirajganj": [
        "Belkuchi",
        "Chauhali",
        "Kamarkhanda",
        "Kazipur",
        "Raiganj",
        "Shahjadpur",
        "Sirajganj Sadar",
        "Tarash",
        "Ullahpara"
      ],
      "Sunamganj": [
        "Bishwamvarpur",
        "Chhatak",
        "Derai",
        "Dharampasha",
        "Dowarabazar",
        "Jagannathpur",
        "Jamalganj",
        "Sulla",
        "Sunamganj Sadar",
        "Tahirpur"
      ],
      "Sylhet": [
        "Balaganj",
        "Beanibazar",
        "Bishwanath",
        "Fenchuganj",
        "Golapganj",
        "Gowainghat",
        "Jaintiapur",
        "Kanaighat",
        "Sylhet Sadar",
        "Zakiganj"
      ],
      "Tangail": [
        "Basail",
        "Bhuapur",
        "Delduar",
        "Dhanbari",
        "Ghatail",
        "Gopalpur",
        "Kalihati",
        "Madhupur",
        "Mirzapur",
        "Nagarpur",
        "Sakhipur",
        "Tangail Sadar"
      ],
      "Thakurgaon": [
        "Baliadangi",
        "Haripur",
        "Pirganj",
        "Ranishankail",
        "Thakurgaon Sadar"
      ]
    };

    List<String> thanaList = listOfThana[districtName];
    if (thanaList.isNotEmpty) {
      return thanaList;
    } else {
      return ['No police station found'];
    }
  }

  static returnDistrict({required String divisionName}) {
    dynamic districts = {
      "Dhaka": [
        "Dhaka",
        "Gazipur",
        "Narayanganj",
        "Tangail",
        "Mymensingh",
        "Manikganj",
        "Munshiganj",
        "Narsingdi",
        "Faridpur",
        "Gopalganj",
        "Rajbari",
        "Shariatpur",
        "Kishoreganj",
        "Jamalpur",
        "Sherpur"
      ],
      "Chittagong": [
        "Chittagong",
        "Cox's Bazar",
        "Khagrachhari",
        "Rangamati",
        "Bandarban",
        "Feni",
        "Lakshmipur",
        "Comilla",
        "Noakhali",
        "Brahmanbaria",
        "Chandpur"
      ],
      "Rajshahi": [
        "Rajshahi",
        "Naogaon",
        "Natore",
        "Chapainawabganj",
        "Pabna",
        "Sirajganj",
        "Bogra",
        "Joypurhat"
      ],
      "Khulna": [
        "Khulna",
        "Jessore",
        "Satkhira",
        "Bagerhat",
        "Chuadanga",
        "Kushtia",
        "Magura",
        "Meherpur",
        "Narail",
        "Jhenaidah"
      ],
      "Barisal": ["Barisal", "Bhola", "Jhalokati", "Patuakhali", "Pirojpur"],
      "Sylhet": ["Sylhet", "Moulvibazar", "Habiganj", "Sunamganj"],
      "Rangpur": [
        "Rangpur",
        "Dinajpur",
        "Gaibandha",
        "Kurigram",
        "Lalmonirhat",
        "Nilphamari",
        "Panchagarh",
        "Thakurgaon"
      ],
      "Mymensingh": ["Mymensingh", "Netrokona", "Jamalpur", "Sherpur"]
    };

    List<String> districtList = districts[divisionName];
    if (districtList.isNotEmpty) {
      return districtList;
    } else {
      return ['No district found'];
    }
  }

  static returnDivision({required String countryName}) {
    dynamic divisions = {
      'Bangladesh': [
        "Dhaka",
        "Chittagong",
        "Rajshahi",
        "Khulna",
        "Barisal",
        "Sylhet",
        "Rangpur",
        "Mymensingh"
      ]
    };
    List<String> divisionList = divisions[countryName];
    if (divisionList.isNotEmpty) {
      return divisionList;
    } else {
      return ['No division found'];
    }
  }
}
