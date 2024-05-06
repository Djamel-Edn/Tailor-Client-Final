class Style {
  final String category;
  final List<Map<String, dynamic>> questionnaire;
  final List<Map<String, dynamic>> subCategories;

  Style(
      {required this.category,
      required this.questionnaire,
      required this.subCategories});

  // factory Style.fromJson(Map<String, dynamic> json) {
  //   return Style(
  //     category: json['category'],
  //     questionnaire: List<Map<String, dynamic>>.from(json['questionnaire']),
  //     subCategories: List<Map<String, dynamic>>.from(json['subCategories']),
  //   );
  // }

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
        // {
        //   "qst": "Main Color",
        //   "responses": [
        //     'Black',
        //     'White',
        //     'Grey',
        //     'Blue',
        //     'Green',
        //     'Yellow',
        //     'Orange',
        //     'Red',
        //     'Pink',
        //     'Purple',
        //     'Brown'
        //   ]
        // },
        // {
        //   "qst": "Second Color",
        //   "responses": [
        //     'Black',
        //     'White',
        //     'Grey',
        //     'Blue',
        //     'Green',
        //     'Yellow',
        //     'Orange',
        //     'Red',
        //     'Pink',
        //     'Purple',
        //     'Brown'
        //   ]
        // },
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
    // Add other categories similarly
  ];
}
