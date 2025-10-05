import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedFirebaseData() async {
  final firestore = FirebaseFirestore.instance;

  // First, create categories
  final categories = [
    {
      'id': 'food',
      'name': 'Food',
      'nameAr': 'طعام',
      'imageUrl': 'https://picsum.photos/seed/food/100',
    },
    {
      'id': 'pharmacy',
      'name': 'Pharmacy',
      'nameAr': 'صيدلية',
      'imageUrl': 'https://picsum.photos/seed/pharmacy/100',
    },
    {
      'id': 'grocery',
      'name': 'Grocery',
      'nameAr': 'بقالة',
      'imageUrl': 'https://picsum.photos/seed/grocery/100',
    },
  ];

  print('Starting to add categories to Firebase...');
  for (var category in categories) {
    await firestore
        .collection('categories')
        .doc(category['id'] as String)
        .set(category);
    print('Added category: ${category['nameAr']}');
  }

  // Sample products data with categories
  final products = [
    // Food category products
    {
      'name': 'تفاح أحمر',
      'code': 'APPLE001',
      'description': 'تفاح أحمر طازج وحلو المذاق، غني بالفيتامينات والألياف',
      'price': 15.50,
      'isFeatured': true,
      'sellingCount': 150,
      'categoryId': 'food',
      'imageUrl': 'https://source.unsplash.com/400x400/?apple',
      'expirationsMonths': 3,
      'isOrganic': true,
      'numberOfCalories': 95,
      'unitAmount': 1,
      'reviews': [
        {
          'name': 'أحمد محمد',
          'image': 'https://ui-avatars.com/api/?name=Ahmed+Mohamed&background=4CAF50',
          'ratting': 5,
          'date': '2024-01-15',
          'reviewDescription': 'تفاح ممتاز وطازج جداً'
        },
        {
          'name': 'فاطمة علي',
          'image': 'https://ui-avatars.com/api/?name=Fatima+Ali&background=2196F3',
          'ratting': 4,
          'date': '2024-01-10',
          'reviewDescription': 'جودة جيدة وسعر مناسب'
        }
      ]
    },
    {
      'name': 'موز',
      'code': 'BANANA001',
      'description': 'موز طازج مستورد، غني بالبوتاسيوم والطاقة',
      'price': 12.00,
      'isFeatured': true,
      'sellingCount': 200,
      'categoryId': 'food',
      'imageUrl': 'https://source.unsplash.com/400x400/?banana',
      'expirationsMonths': 1,
      'isOrganic': false,
      'numberOfCalories': 105,
      'unitAmount': 6,
      'reviews': [
        {
          'name': 'خالد سالم',
          'image': 'https://ui-avatars.com/api/?name=Khaled+Salem&background=FF9800',
          'ratting': 5,
          'date': '2024-01-20',
          'reviewDescription': 'موز طازج ولذيذ'
        }
      ]
    },
    {
      'name': 'فراولة',
      'code': 'STRAW001',
      'description': 'فراولة طازجة حمراء وحلوة المذاق',
      'price': 25.00,
      'isFeatured': true,
      'sellingCount': 90,
      'categoryId': 'food',
      'imageUrl': 'https://source.unsplash.com/400x400/?strawberry',
      'expirationsMonths': 1,
      'isOrganic': true,
      'numberOfCalories': 49,
      'unitAmount': 250,
      'reviews': [
        {
          'name': 'ليلى عمر',
          'image': 'https://ui-avatars.com/api/?name=Laila+Omar&background=F44336',
          'ratting': 5,
          'date': '2024-01-22',
          'reviewDescription': 'فراولة طازجة جداً ولذيذة'
        }
      ]
    },
    {
      'name': 'مانجو',
      'code': 'MANGO001',
      'description': 'مانجو مستوردة حلوة المذاق وعطرية',
      'price': 35.00,
      'isFeatured': true,
      'sellingCount': 110,
      'categoryId': 'food',
      'imageUrl': 'https://source.unsplash.com/400x400/?mango',
      'expirationsMonths': 2,
      'isOrganic': true,
      'numberOfCalories': 150,
      'unitAmount': 1,
      'reviews': [
        {
          'name': 'نورا سعيد',
          'image': 'https://ui-avatars.com/api/?name=Nora+Said&background=FFC107',
          'ratting': 5,
          'date': '2024-01-25',
          'reviewDescription': 'مانجو رائعة وطعمها لذيذ جداً'
        }
      ]
    },
    // Pharmacy category products
    {
      'name': 'باراسيتامول',
      'code': 'PARA001',
      'description': 'دواء خافض للحرارة ومسكن للألم',
      'price': 5.00,
      'isFeatured': true,
      'sellingCount': 300,
      'categoryId': 'pharmacy',
      'imageUrl': 'https://source.unsplash.com/400x400/?mango',
      'expirationsMonths': 24,
      'isOrganic': false,
      'numberOfCalories': 0,
      'unitAmount': 20,
      'reviews': [
        {
          'name': 'د. أحمد',
          'image': 'https://ui-avatars.com/api/?name=Dr+Ahmed&background=03A9F4',
          'ratting': 5,
          'date': '2024-01-18',
          'reviewDescription': 'فعال جداً'
        }
      ]
    },
    {
      'name': 'فيتامين C',
      'code': 'VITC001',
      'description': 'مكمل غذائي فيتامين سي لتقوية المناعة',
      'price': 25.00,
      'isFeatured': false,
      'sellingCount': 150,
      'categoryId': 'pharmacy',
      'imageUrl': 'https://source.unsplash.com/400x400/?mango',
      'expirationsMonths': 18,
      'isOrganic': false,
      'numberOfCalories': 5,
      'unitAmount': 30,
      'reviews': [
        {
          'name': 'سارة محمد',
          'image': 'https://ui-avatars.com/api/?name=Sara+Mohamed&background=FF9800',
          'ratting': 4,
          'date': '2024-01-16',
          'reviewDescription': 'جيد للمناعة'
        }
      ]
    },
    {
      'name': 'شراب الكحة',
      'code': 'COUGH001',
      'description': 'شراب طبيعي لعلاج الكحة',
      'price': 18.00,
      'isFeatured': false,
      'sellingCount': 80,
      'categoryId': 'pharmacy',
      'imageUrl': 'https://source.unsplash.com/400x400/?mango',
      'expirationsMonths': 12,
      'isOrganic': true,
      'numberOfCalories': 20,
      'unitAmount': 120,
      'reviews': [
        {
          'name': 'فاطمة علي',
          'image': 'https://ui-avatars.com/api/?name=Fatima+Ali&background=4CAF50',
          'ratting': 5,
          'date': '2024-01-20',
          'reviewDescription': 'مفعول سريع'
        }
      ]
    },
    // Grocery category products
    {
      'name': 'أرز بسمتي',
      'code': 'RICE001',
      'description': 'أرز بسمتي هندي فاخر',
      'price': 45.00,
      'isFeatured': true,
      'sellingCount': 250,
      'categoryId': 'grocery',
      'imageUrl': 'https://source.unsplash.com/400x400/?mango',
      'expirationsMonths': 12,
      'isOrganic': false,
      'numberOfCalories': 350,
      'unitAmount': 5000,
      'reviews': [
        {
          'name': 'محمد حسن',
          'image': 'https://ui-avatars.com/api/?name=Mohamed+Hassan&background=795548',
          'ratting': 5,
          'date': '2024-01-14',
          'reviewDescription': 'جودة ممتازة'
        }
      ]
    },
    {
      'name': 'زيت زيتون',
      'code': 'OIL001',
      'description': 'زيت زيتون بكر ممتاز',
      'price': 60.00,
      'isFeatured': true,
      'sellingCount': 180,
      'categoryId': 'grocery',
      'imageUrl': 'https://source.unsplash.com/400x400/?mango',
      'expirationsMonths': 18,
      'isOrganic': true,
      'numberOfCalories': 120,
      'unitAmount': 1000,
      'reviews': [
        {
          'name': 'عمر يوسف',
          'image': 'https://ui-avatars.com/api/?name=Omar+Youssef&background=8BC34A',
          'ratting': 5,
          'date': '2024-01-22',
          'reviewDescription': 'طعم رائع وأصلي'
        }
      ]
    },
    {
      'name': 'معكرونة',
      'code': 'PASTA001',
      'description': 'معكرونة إيطالية عالية الجودة',
      'price': 12.00,
      'isFeatured': false,
      'sellingCount': 200,
      'categoryId': 'grocery',
      'imageUrl': 'https://source.unsplash.com/400x400/?mango',
      'expirationsMonths': 24,
      'isOrganic': false,
      'numberOfCalories': 350,
      'unitAmount': 500,
      'reviews': [
        {
          'name': 'ليلى أحمد',
          'image': 'https://ui-avatars.com/api/?name=Laila+Ahmed&background=FFC107',
          'ratting': 4,
          'date': '2024-01-17',
          'reviewDescription': 'جيدة للطبخ'
        }
      ]
    },
    {
      'name': 'سكر أبيض',
      'code': 'SUGAR001',
      'description': 'سكر أبيض نقي',
      'price': 20.00,
      'isFeatured': false,
      'sellingCount': 300,
      'categoryId': 'grocery',
      'imageUrl': 'https://source.unsplash.com/400x400/?mango',
      'expirationsMonths': 36,
      'isOrganic': false,
      'numberOfCalories': 400,
      'unitAmount': 1000,
      'reviews': [
        {
          'name': 'خالد سعيد',
          'image': 'https://ui-avatars.com/api/?name=Khaled+Said&background=E91E63',
          'ratting': 5,
          'date': '2024-01-19',
          'reviewDescription': 'نقي وجودة عالية'
        }
      ]
    },
  ];

  // Add products to Firestore
  print('\nStarting to add products to Firebase...');

  for (var product in products) {
    await firestore.collection('products').add(product);
    print('Added: ${product['name']} (${product['categoryId']})');
  }

  print('\n✅ Successfully added ${categories.length} categories and ${products.length} products to Firebase!');
  print('Categories: Food (طعام), Pharmacy (صيدلية), Grocery (بقالة)');
  print('You can now view them in your app.');
}
