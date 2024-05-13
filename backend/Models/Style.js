const Style = [
    {
        category: "Tops",
        questionnaire: [
            {
                qst1: "Shirt Length",
                responses: ['Short', 'Regular', 'Long']
            },
            {
                qst2: "Fit",
                responses: ['Oversized', 'Regular', 'Slim']
            },
            {
                qst3: "Fabric Type",
                responses: ['Cotton', 'Linen', 'Silk']
            },
            {
                qst4: "Pattern",
                responses: ['Solid', 'Striped', 'Checked', 'Patterned']
            },
            {
                qst5: "Main Color",
                responses: ['Black', 'White', 'Grey', 'Blue', 'Green', 'Yellow', 'Orange', 'Red', 'Pink', 'Purple', 'Brown']
            },
            {
                qst6: "Second Color",
                responses: ['Black', 'White', 'Grey', 'Blue', 'Green', 'Yellow', 'Orange', 'Red', 'Pink', 'Purple', 'Brown']
            },
            {
                qst7: "Buttons",
                responses: ['Hidden', 'Visible', 'Customized']
            },
            {
                qst8: "Cuff Style",
                responses: ['Single', 'Buttoned', 'French Cuff']
            },
            {
                qst9: "Hem Style",
                responses: ['Straight', 'Rounded', 'Asymmetrical']
            }
        ],
        subCategories: [
            {
                name: 'Blouse',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Cardigan',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Hoodie',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Shirt',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Sweatshirt',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'T-shirt',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            }
        ]
    },
    {
        category: "Bottoms",
        questionnaire: [
            {
                qst1: "Pants Length",
                responses: ['Short', 'Regular', 'Long']
            }
        ],
        subCategories: [
            {
                name: 'Bermuda shorts',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Jogging pants',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Leggings',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Pants',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Skirt',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Trousers',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            }
        ]
    },
    {
        category: "Dresses",
        questionnaire: [
            {
                qst1: "Dress Type",
                responses: ['Dress', 'Skirts', 'Jumpsuit']
            }
        ],
        subCategories: [
            {
                name: 'Dress',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Jumpsuit',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            }
        ]
    },
    {
        category: "Suits",
        questionnaire: [
            {
                qst1: "Suit Type",
                responses: ['Suits', 'Tailleur', 'Uniform']
            }
        ],
        subCategories: [
            {
                name: 'Suits',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Tailleur',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Uniform',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            }
        ]
    },
    {
        category: "Outerwear",
        questionnaire: [
            {
                qst1: "Outerwear Type",
                responses: ['Blazer', 'Coat', 'Jacket', 'Parka', 'Poncho', 'Trench coat', 'Vest']
            }
        ],
        subCategories: [
            {
                name: 'Blazer',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Coat',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Jacket',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Parka',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Poncho',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Trench coat',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Vest',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            }
        ]
    },
    {
        category: "Sportswear",
        questionnaire: [
            {
                qst1: "Sportswear Type",
                responses: ['Athletic shorts', 'Tracksuits', 'Leggings', 'Performance tops', 'Compression wear']
            }
        ],
        subCategories: [
            {
                name: 'Athletic shorts',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Tracksuits',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Leggings',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Performance tops',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Compression wear',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            }
        ]
    },
    {
        category: "Accessories",
        questionnaire: [
            {
                qst1: "Accessory Type",
                responses: ['Belt', 'Cap', 'Hat', 'Scarf']
            }
        ],
        subCategories: [
            {
                name: 'Belt',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Cap',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Hat',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            },
            {
                name: 'Scarf',
                images: ['https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg', 'https://i.ibb.co/7vJ7Y1V/blouse.jpg']
            }
        ]
    }
];
