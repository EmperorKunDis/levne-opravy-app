import 'package:flutter/material.dart';
import '../models/service.dart';
import '../models/order.dart';
import '../models/milestone.dart';

class MockData {
  // Services catalog
  static final List<Service> services = [
    const Service(
      id: 's1',
      name: 'Montáž kuchyňské linky',
      description: 'Kompletní montáž kuchyňské linky včetně úprav',
      category: ServiceCategory.montaze,
      priceFrom: 5000,
      priceTo: 15000,
      unit: 'kuchyň',
      icon: Icons.kitchen,
      features: ['Demontáž staré linky', 'Montáž nové linky', 'Úpravy rozvodů'],
    ),
    const Service(
      id: 's2',
      name: 'Montáž dveří',
      description: 'Montáž interiérových i vchodových dveří',
      category: ServiceCategory.montaze,
      priceFrom: 800,
      priceTo: 2500,
      unit: 'ks',
      icon: Icons.door_front_door,
      features: ['Zaměření', 'Montáž zárubně', 'Seřízení'],
    ),
    const Service(
      id: 's3',
      name: 'Výměna vodovodních baterií',
      description: 'Výměna a montáž vodovodních baterií',
      category: ServiceCategory.instalaterstvi,
      priceFrom: 500,
      priceTo: 1500,
      unit: 'ks',
      icon: Icons.water_drop,
      features: ['Demontáž staré baterie', 'Montáž nové', 'Test těsnosti'],
    ),
    const Service(
      id: 's4',
      name: 'Instalace WC a umyvadla',
      description: 'Kompletní instalace sanitární keramiky',
      category: ServiceCategory.instalaterstvi,
      priceFrom: 1500,
      priceTo: 4000,
      unit: 'ks',
      icon: Icons.bathroom,
      features: ['Napojení na odpady', 'Montáž keramiky', 'Silikon'],
    ),
    const Service(
      id: 's5',
      name: 'Elektroinstalace',
      description: 'Instalace zásuvek, vypínačů a světel',
      category: ServiceCategory.elektro,
      priceFrom: 300,
      priceTo: 800,
      unit: 'bod',
      icon: Icons.electrical_services,
      features: ['Zásuvky', 'Vypínače', 'Osvětlení'],
    ),
    const Service(
      id: 's6',
      name: 'Montáž rozvaděče',
      description: 'Instalace a zapojení elektrického rozvaděče',
      category: ServiceCategory.elektro,
      priceFrom: 3000,
      priceTo: 8000,
      unit: 'ks',
      icon: Icons.electric_meter,
      features: ['Jističe', 'Proudový chránič', 'Revize'],
    ),
    const Service(
      id: 's7',
      name: 'Rekonstrukce koupelny',
      description: 'Kompletní rekonstrukce koupelny na klíč',
      category: ServiceCategory.rekonstrukce,
      priceFrom: 80000,
      priceTo: 250000,
      unit: 'koupelna',
      icon: Icons.bathtub,
      features: ['Bourání', 'Rozvody', 'Obklady', 'Sanita'],
    ),
    const Service(
      id: 's8',
      name: 'Malování',
      description: 'Malování interiérů včetně přípravy povrchu',
      category: ServiceCategory.rekonstrukce,
      priceFrom: 50,
      priceTo: 120,
      unit: 'm²',
      icon: Icons.format_paint,
      features: ['Příprava podkladu', '2 nátěry', 'Úklid'],
    ),
    const Service(
      id: 's9',
      name: 'Pokládka plovoucí podlahy',
      description: 'Pokládka laminátové nebo vinylové podlahy',
      category: ServiceCategory.rekonstrukce,
      priceFrom: 150,
      priceTo: 350,
      unit: 'm²',
      icon: Icons.grid_on,
      features: ['Izolace', 'Pokládka', 'Lišty'],
    ),
    const Service(
      id: 's10',
      name: 'Obklady a dlažby',
      description: 'Pokládka obkladů a dlažeb',
      category: ServiceCategory.rekonstrukce,
      priceFrom: 400,
      priceTo: 800,
      unit: 'm²',
      icon: Icons.grid_view,
      features: ['Příprava podkladu', 'Lepení', 'Spárování'],
    ),
    const Service(
      id: 's11',
      name: 'Údržba zahrady',
      description: 'Sekání trávy, stříhání keřů, údržba',
      category: ServiceCategory.zahrada,
      priceFrom: 500,
      priceTo: 2000,
      unit: 'návštěva',
      icon: Icons.grass,
      features: ['Sekání', 'Stříhání', 'Úklid'],
    ),
    const Service(
      id: 's12',
      name: 'Drobné opravy',
      description: 'Různé drobné opravy a údržba domácnosti',
      category: ServiceCategory.ostatni,
      priceFrom: 400,
      unit: 'hod',
      icon: Icons.handyman,
      features: ['Hodinová sazba', 'Materiál zvlášť'],
    ),
  ];

  // Current active order with milestones
  static final Order activeOrder = Order(
    id: 'o1',
    title: 'Rekonstrukce koupelny',
    description: 'Kompletní rekonstrukce koupelny v bytě 3+1',
    status: OrderStatus.inProgress,
    createdAt: DateTime.now().subtract(const Duration(days: 14)),
    startDate: DateTime.now().subtract(const Duration(days: 7)),
    estimatedEndDate: DateTime.now().add(const Duration(days: 21)),
    totalPrice: 185000,
    paidAmount: 55500,
    address: 'Vinohradská 123, Praha 2',
    clientName: 'Jan Novák',
    pendingExtraWorks: 1,
    milestones: [
      Milestone(
        id: 'm1',
        title: 'Zaměření proběhlo',
        description: 'Technik provedl zaměření a připravil podklady',
        status: MilestoneStatus.completed,
        completedDate: DateTime.now().subtract(const Duration(days: 10)),
        order: 1,
      ),
      Milestone(
        id: 'm2',
        title: 'Nákup materiálu',
        description: 'Probíhá nákup a dovoz materiálu na stavbu',
        status: MilestoneStatus.inProgress,
        startDate: DateTime.now().subtract(const Duration(days: 3)),
        order: 2,
      ),
      Milestone(
        id: 'm3',
        title: 'Zahájení hrubé práce',
        description: 'Bourání staré koupelny a příprava',
        status: MilestoneStatus.pending,
        order: 3,
      ),
      Milestone(
        id: 'm4',
        title: 'Rozvody vody a elektřiny',
        description: 'Nové rozvody dle projektu',
        status: MilestoneStatus.pending,
        order: 4,
      ),
      Milestone(
        id: 'm5',
        title: 'Obklady a dlažby',
        description: 'Pokládka obkladů a dlažeb',
        status: MilestoneStatus.pending,
        order: 5,
      ),
      Milestone(
        id: 'm6',
        title: 'Instalace sanity',
        description: 'Montáž vany, WC, umyvadla',
        status: MilestoneStatus.pending,
        order: 6,
      ),
      Milestone(
        id: 'm7',
        title: 'Finální kontrola',
        description: 'Předání díla a úklid',
        status: MilestoneStatus.pending,
        order: 7,
      ),
    ],
  );

  // Extra work pending approval
  static final ExtraWork pendingExtraWork = ExtraWork(
    id: 'ew1',
    orderId: 'o1',
    title: 'Změna materiálu koupelna',
    description:
        'Během bourání jsme zjistili, že původní rozvody jsou v horším stavu, než se předpokládalo. Je nutné vyměnit větší část potrubí a přidat nový uzávěr vody.',
    originalPrice: 185000,
    newPrice: 197500,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  );

  // Photo records
  static final List<PhotoRecord> photos = [
    PhotoRecord(
      id: 'p1',
      url: 'https://via.placeholder.com/400x300/E30613/FFFFFF?text=Pred+rekonstrukci',
      description: 'Stav koupelny před rekonstrukcí',
      takenAt: DateTime.now().subtract(const Duration(days: 10)),
      milestoneId: 'm1',
      orderId: 'o1',
    ),
    PhotoRecord(
      id: 'p2',
      url: 'https://via.placeholder.com/400x300/4CAF50/FFFFFF?text=Zamereni',
      description: 'Zaměření - detail',
      takenAt: DateTime.now().subtract(const Duration(days: 10)),
      milestoneId: 'm1',
      orderId: 'o1',
    ),
    PhotoRecord(
      id: 'p3',
      url: 'https://via.placeholder.com/400x300/2196F3/FFFFFF?text=Material',
      description: 'Dovezený materiál',
      takenAt: DateTime.now().subtract(const Duration(days: 2)),
      milestoneId: 'm2',
      orderId: 'o1',
    ),
    PhotoRecord(
      id: 'p4',
      url: 'https://via.placeholder.com/400x300/FF9800/FFFFFF?text=Rozvody',
      description: 'Stav rozvodů - nutná výměna',
      takenAt: DateTime.now().subtract(const Duration(days: 1)),
      milestoneId: 'm2',
      orderId: 'o1',
    ),
  ];

  // Documents
  static final List<Document> documents = [
    Document(
      id: 'd1',
      title: 'Smlouva o dílo',
      type: 'smlouva',
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
      orderId: 'o1',
    ),
    Document(
      id: 'd2',
      title: 'Zálohová faktura',
      type: 'faktura',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      orderId: 'o1',
    ),
    Document(
      id: 'd3',
      title: 'Protokol o zaměření',
      type: 'protokol',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      orderId: 'o1',
    ),
    Document(
      id: 'd4',
      title: 'Technická specifikace',
      type: 'pdf',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      orderId: 'o1',
    ),
  ];

  // Calculator options
  static const List<String> workTypes = [
    'Rekonstrukce koupelny',
    'Rekonstrukce kuchyně',
    'Malování',
    'Pokládka podlahy',
    'Elektroinstalace',
    'Instalatérské práce',
  ];

  static const List<String> qualityLevels = [
    'Standard',
    'Premium',
  ];

  static const Map<String, Map<String, double>> priceMatrix = {
    'Rekonstrukce koupelny': {'Standard': 15000, 'Premium': 25000},
    'Rekonstrukce kuchyně': {'Standard': 12000, 'Premium': 20000},
    'Malování': {'Standard': 80, 'Premium': 150},
    'Pokládka podlahy': {'Standard': 250, 'Premium': 450},
    'Elektroinstalace': {'Standard': 500, 'Premium': 800},
    'Instalatérské práce': {'Standard': 600, 'Premium': 1000},
  };
}
