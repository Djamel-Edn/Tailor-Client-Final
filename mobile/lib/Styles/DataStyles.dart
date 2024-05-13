class Style {
  final String category;
  final List<Map<String, dynamic>> questionnaire;
  final List<Map<String, dynamic>> subCategories;

  Style(
      {required this.category,
      required this.questionnaire,
      required this.subCategories});

  static List<String> SavedTailroFav = ["6626ec41ed54ccf5c1e7e8fd"];

  static List<Style> styles = [
    Style(
      category: "Tops",
      questionnaire: [
        {
          "qst": "Shirt Length",
          "responses": ['Short', 'Regular', 'Long']
        },
        {
          "qst": "Fit",
          "responses": ['Oversized', 'Regular', 'Slim']
        },
        {
          "qst": "Fabric Type",
          "responses": ['Cotton', 'Linen', 'Silk']
        },
        {
          "qst": "Pattern",
          "responses": ['Solid', 'Striped', 'Checked', 'Patterned']
        },
        {
          "qst": "Buttons",
          "responses": ['Hidden', 'Visible', 'Customized']
        },
        {
          "qst": "Cuff Style",
          "responses": ['Single', 'Buttoned', 'French Cuff']
        },
        {
          "qst": "Hem Style",
          "responses": ['Straight', 'Rounded', 'Asymmetrical']
        },
      ],
      subCategories: [
        {
          "name": 'Blouse',
          "images": [
            'images/styles/blouse 1.jpg',
            'images/styles/blouse 2.jpg',
            'images/styles/blouse 3.jpg',
            'images/styles/blouse 4.jpg',
            'images/styles/blouse 5.jpg'
          ]
        },
        {
          "name": 'Cardigan',
          "images": [
            'images/styles/cardigan 1.jpg',
            'images/styles/cardigan 2.jpg',
            'images/styles/cardigan 3.jpg',
            'images/styles/cardigan 4.jpg',
            'images/styles/cardigan 5.jpg'
          ]
        },
        {
          "name": 'Hoodie',
          "images": [
            'images/styles/hoodie 1.jpg',
            'images/styles/hoodie 2.jpg',
            'images/styles/hoodie 3.jpg',
            'images/styles/hoodie 4.jpg',
            'images/styles/hoodie 5.jpg'
          ]
        },
        {
          "name": 'Shirt',
          "images": [
            'images/styles/shirt 1.jpg',
            'images/styles/shirt 2.jpg',
            'images/styles/shirt 3.jpg',
            'images/styles/shirt 4.jpg',
            'images/styles/shirt 5.jpg'
          ]
        },
        {
          "name": 'Sweatshirt',
          "images": [
            'images/styles/sweatshirt 1.jpg',
            'images/styles/sweatshirt 2.jpg',
            'images/styles/sweatshirt 3.jpg',
            'images/styles/sweatshirt 4.jpg',
            'images/styles/sweatshirt 5.jpg'
          ]
        },
        {
          "name": 'T-shirt',
          "images": [
            'images/styles/tshirt 1.jpg',
            'images/styles/tshirt 2.jpg',
            'images/styles/tshirt 3.jpg',
            'images/styles/tshirt 4.jpg',
            'images/styles/tshirt 5.jpg'
          ]
        },
      ],
    ),
    Style(
      category: "Bottoms",
      questionnaire: [
        {
          "qst": "Pants Length",
          "responses": ['Short', 'Regular', 'Long']
        },
      ],
      subCategories: [
        {
          "name": 'Bermuda shorts',
          "images": [
            'images/styles/bermuda 1.jpg',
            'images/styles/bermuda 2.jpg',
            'images/styles/bermuda 3.jpg',
            'images/styles/bermuda 4.jpg',
            'images/styles/bermuda 5.jpg'
          ]
        },
        {
          "name": 'Jogging pants',
          "images": [
            'images/styles/jogging 1.jpg',
            'images/styles/jogging 2.jpg',
            'images/styles/jogging 3.jpg',
            'images/styles/jogging 4.jpg',
            'images/styles/jogging 5.jpg'
          ]
        },
        {
          "name": 'Leggings',
          "images": [
            'images/styles/leggings 1.jpg',
            'images/styles/leggings 2.jpg',
            'images/styles/leggings 3.jpg',
            'images/styles/leggings 4.jpg',
            'images/styles/leggings 5.jpg'
          ]
        },
        {
          "name": 'Pants',
          "images": [
            'images/styles/pants 1.jpg',
            'images/styles/pants 2.jpg',
            'images/styles/pants 3.jpg',
            'images/styles/pants 4.jpg',
            'images/styles/pants 5.jpg'
          ]
        },
        {
          "name": 'Skirt',
          "images": [
            'images/styles/skirt 1.jpg',
            'images/styles/skirt 2.jpg',
            'images/styles/skirt 3.jpg',
            'images/styles/skirt 4.jpg',
            'images/styles/skirt 5.jpg'
          ]
        },
        {
          "name": 'Trousers',
          "images": [
            'images/styles/trousers 1.jpg',
            'images/styles/trousers 2.jpg',
            'images/styles/trousers 3.jpg',
            'images/styles/trousers 4.jpg',
            'images/styles/trousers 5.jpg'
          ]
        },
      ],
    ),
    Style(
      category: "Dresses and Jumpsuits",
      questionnaire: [
        {
          "qst": "Dress Type",
          "responses": ['Dress', 'Skirts', 'Jumpsuit']
        },
      ],
      subCategories: [
        {
          "name": 'Dress',
          "images": [
            'images/styles/dress 1.jpg',
            'images/styles/dress 2.jpg',
            'images/styles/dress 3.jpg',
            'images/styles/dress 4.jpg',
            'images/styles/dress 5.jpg'
          ]
        },
        {
          "name": 'Skirts',
          "images": [
            'images/styles/skirts 1.jpg',
            'images/styles/skirts 2.jpg',
            'images/styles/skirts 3.jpg',
            'images/styles/skirts 4.jpg',
            'images/styles/skirts 5.jpg'
          ]
        },
        {
          "name": 'Jumpsuit',
          "images": [
            'images/styles/jumpsuit 1.jpg',
            'images/styles/jumpsuit 2.jpg',
            'images/styles/jumpsuit 3.jpg',
            'images/styles/jumpsuit 4.jpg',
            'images/styles/jumpsuit 5.jpg'
          ]
        },
      ],
    ),
    Style(
      category: "Suits and Sets",
      questionnaire: [
        {
          "qst": "Suit Type",
          "responses": ['Suits', 'Tailleur', 'Uniform']
        },
      ],
      subCategories: [
        {
          "name": 'Suit (jacket and pants)',
          "images": [
            'images/styles/suits 1.jpg',
            'images/styles/suits 2.jpg',
            'images/styles/suits 3.jpg',
            'images/styles/suits 4.jpg',
            'images/styles/suits 5.jpg'
          ]
        },
        {
          "name": 'Tailleur (skirt and jacket)',
          "images": [
            'images/styles/tailleur 1.jpg',
            'images/styles/tailleur 2.jpg',
            'images/styles/tailleur 3.jpg',
            'images/styles/tailleur 4.jpg',
            'images/styles/tailleur 5.jpg'
          ]
        },
        {
          "name": 'Uniform',
          "images": [
            'images/styles/uniform 1.jpg',
            'images/styles/uniform 2.jpg',
            'images/styles/uniform 3.jpg',
            'images/styles/uniform 4.jpg',
            'images/styles/uniform 5.jpg'
          ]
        },
      ],
    ),
    Style(
      category: "Outerwear",
      questionnaire: [
        {
          "qst": "Outerwear Type",
          "responses": [
            'images/styles/Blazer',
            'images/styles/Coat',
            'images/styles/Jacket',
            'images/styles/Parka',
            'images/styles/Poncho',
            'images/styles/Trench coat',
            'images/styles/Vest'
          ]
        },
      ],
      subCategories: [
        {
          "name": 'Blazer',
          "images": [
            'images/styles/blazer 1.jpg',
            'images/styles/blazer 2.jpg',
            'images/styles/blazer 3.jpg',
            'images/styles/blazer 4.jpg',
            'images/styles/blazer 5.jpg'
          ]
        },
        {
          "name": 'Coat',
          "images": [
            'images/styles/coat 1.jpg',
            'images/styles/coat 2.jpg',
            'images/styles/coat 3.jpg',
            'images/styles/coat 4.jpg',
            'images/styles/coat 5.jpg'
          ]
        },
        {
          "name": 'Jacket',
          "images": [
            'images/styles/jacket 1.jpg',
            'images/styles/jacket 2.jpg',
            'images/styles/jacket 3.jpg',
            'images/styles/jacket 4.jpg',
            'images/styles/jacket 5.jpg'
          ]
        },
        {
          "name": 'Parka',
          "images": [
            'images/styles/parka 1.jpg',
            'images/styles/parka 2.jpg',
            'images/styles/parka 3.jpg',
            'images/styles/parka 4.jpg',
            'images/styles/parka 5.jpg'
          ]
        },
        {
          "name": 'Poncho',
          "images": [
            'images/styles/poncho 1.jpg',
            'images/styles/poncho 2.jpg',
            'images/styles/poncho 3.jpg',
            'images/styles/poncho 4.jpg',
            'images/styles/poncho 5.jpg'
          ]
        },
        {
          "name": 'Trench coat',
          "images": [
            'images/styles/trench 1.jpg',
            'images/styles/trench 2.jpg',
            'images/styles/trench 3.jpg',
            'images/styles/trench 4.jpg',
            'images/styles/trench 5.jpg'
          ]
        },
        {
          "name": 'Vest',
          "images": [
            'images/styles/vest 1.jpg',
            'images/styles/vest 2.jpg',
            'images/styles/vest 3.jpg',
            'images/styles/vest 4.jpg',
            'images/styles/vest 5.jpg'
          ]
        },
      ],
    ),
    Style(
      category: "Sportswear",
      questionnaire: [
        {
          "qst": "Sportswear Type",
          "responses": [
            'Athletic shorts',
            'Tracksuits',
            'Leggings',
            'Performance tops',
            'Compression wear'
          ]
        },
      ],
      subCategories: [
        {
          "name": 'Athletic shorts',
          "images": [
            'images/styles/athletic 1.jpg',
            'images/styles/athletic 2.jpg',
            'images/styles/athletic 3.jpg',
            'images/styles/athletic 4.jpg',
            'images/styles/athletic 5.jpg'
          ]
        },
        {
          "name": 'Tracksuits',
          "images": [
            'images/styles/tracksuit 1.jpg',
            'images/styles/tracksuit 2.jpg',
            'images/styles/tracksuit 3.jpg',
            'images/styles/tracksuit 4.jpg',
            'images/styles/tracksuit 5.jpg'
          ]
        },
        {
          "name": 'Leggings',
          "images": [
            'images/styles/leggings 1.jpg',
            'images/styles/leggings 2.jpg',
            'images/styles/leggings 3.jpg',
            'images/styles/leggings 4.jpg',
            'images/styles/leggings 5.jpg'
          ]
        },
        {"name": 'Performance tops', "images": []},
        {
          "name": 'Compression Wear',
          "images": [
            'images/styles/compression 1.jpg',
            'images/styles/compression 2.jpg',
            'images/styles/compression 3.jpg',
            'images/styles/compression 4.jpg',
            'images/styles/compression 5.jpg'
          ]
        },
      ],
    ),
    Style(
      category: "Accessories",
      questionnaire: [
        {
          "qst": "Accessory Type",
          "responses": ['Belt', 'Cap', 'Hat', 'Scarf']
        },
      ],
      subCategories: [
        {
          "name": 'Belt',
          "images": [
            'images/styles/belt 1.jpg',
            'images/styles/belt 2.jpg',
            'images/styles/belt 3.jpg',
            'images/styles/belt 4.jpg',
            'images/styles/belt 5.jpg'
          ]
        },
        {
          "name": 'Cap',
          "images": [
            'images/styles/cap 1.jpg',
            'images/styles/cap 2.jpg',
            'images/styles/cap 3.jpg',
            'images/styles/cap 4.jpg',
            'images/styles/cap 5.jpg'
          ]
        },
        {
          "name": 'Hat',
          "images": [
            'images/styles/hat 1.jpg',
            'images/styles/hat 2.jpg',
            'images/styles/hat 3.jpg',
            'images/styles/hat 4.jpg',
            'images/styles/hat 5.jpg'
          ]
        },
        {
          "name": 'Scarf',
          "images": [
            'images/styles/scarf 1.jpg',
            'images/styles/scarf 2.jpg',
            'images/styles/scarf 3.jpg',
            'images/styles/scarf 4.jpg',
            'images/styles/scarf 5.jpg'
          ]
        },
      ],
    ),
  ];
}
