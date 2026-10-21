class Profile {
  const Profile({
    required this.name,
    required this.initials,
    required this.department,
    required this.email,
    required this.phone,
    required this.location,
    required this.about,
    required this.skills,
    required this.year,
    required this.studentNumber,
    required this.color,
  });

  final String name;
  final String initials;
  final String department;
  final String email;
  final String phone;
  final String location;
  final String about;
  final List<String> skills;
  final String year;
  final String studentNumber;
  final int color;
}

// Tamamı kurgu olan yerel veriler. Yenileme için API çağrısı yapılmaz.
const sampleProfiles = [
  Profile(
    name: 'Deniz Yılmaz',
    initials: 'DY',
    department: 'Bilgisayar Mühendisliği',
    email: 'deniz.yilmaz@example.com',
    phone: '+90 (555) 010 20 30',
    location: 'İstanbul, Türkiye',
    about:
        'Merhaba, ben Deniz. Fikirleri sade ve kullanışlı dijital deneyimlere dönüştürmeyi seviyorum. Mobil uygulama geliştirme, arayüz tasarımı ve birlikte öğrenme üzerine çalışıyorum.',
    skills: ['Flutter', 'Dart', 'UI / UX', 'Mobil geliştirme'],
    year: '3. sınıf',
    studentNumber: '2024 010 128',
    color: 0xFFD8E8DF,
  ),
  Profile(
    name: 'Ece Demir',
    initials: 'ED',
    department: 'Yazılım Mühendisliği',
    email: 'ece.demir@example.com',
    phone: '+90 (555) 010 40 50',
    location: 'İzmir, Türkiye',
    about:
        'Merhaba, ben Ece. Erişilebilir ve insan odaklı uygulamalar geliştirmekle ilgileniyorum. Yeni teknolojiler öğrenirken öğrendiklerimi toplulukla paylaşmayı önemsiyorum.',
    skills: ['Flutter', 'Erişilebilirlik', 'Figma', 'Dart'],
    year: '2. sınıf',
    studentNumber: '2025 020 064',
    color: 0xFFE9DFD0,
  ),
  Profile(
    name: 'Mert Kaya',
    initials: 'MK',
    department: 'Bilgisayar Programcılığı',
    email: 'mert.kaya@example.com',
    phone: '+90 (555) 010 60 70',
    location: 'Ankara, Türkiye',
    about:
        'Merhaba, ben Mert. Günlük hayattaki küçük ihtiyaçlara pratik yazılım çözümleri üretmeyi seviyorum. Mobil geliştirme ve temiz kod yazma konusunda kendimi geliştiriyorum.',
    skills: ['Dart', 'Flutter', 'Git', 'Problem çözme'],
    year: '2. sınıf',
    studentNumber: '2025 030 092',
    color: 0xFFDDE3F0,
  ),
];
