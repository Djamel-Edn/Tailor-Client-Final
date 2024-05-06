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
                images: ['../styles/blouse 1.jpg', '../styles/blouse 2.jpg', '../styles/blouse 3.jpg', '../styles/blouse 4.jpg', '../styles/blouse 5.jpg']
            },
            {
                name: 'Cardigan',
                images: ['../styles/cardigan 1.jpg', '../styles/cardigan 2.jpg', '../styles/cardigan 3.jpg', '../styles/cardigan 4.jpg', '../styles/cardigan 5.jpg']
            },
            {
                name: 'Hoodie',
                images: ['../styles/hoodie 1.jpg', '../styles/hoodie 2.jpg', '../styles/hoodie 3.jpg', '../styles/hoodie 4.jpg', '../styles/hoodie 5.jpg']
            },
            {
                name: 'Shirt',
                images: ['../styles/shirt 1.jpg', '../styles/shirt 2.jpg', '../styles/shirt 3.jpg', '../styles/shirt 4.jpg', '../styles/shirt 5.jpg']
            },
            {
                name: 'Sweatshirt',
                images: ['../styles/sweatshirt 1.jpg', '../styles/sweatshirt 2.jpg', '../styles/sweatshirt 3.jpg', '../styles/sweatshirt 4.jpg', '../styles/sweatshirt 5.jpg']
            },
            {
                name: 'T-shirt',
                images: ['../styles/tshirt 1.jpg', '../styles/tshirt 2.jpg', '../styles/tshirt 3.jpg', '../styles/tshirt 4.jpg', '../styles/tshirt 5.jpg']
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
                images: ['bermuda shorts 1.jpg', 'bermuda shorts 2.jpg', 'bermuda shorts 3.jpg', 'bermuda shorts 4.jpg', 'bermuda shorts 5.jpg']
            },
            {
                name: 'Jogging pants',
                images: ['jogging pants 1.jpg', 'jogging pants 2.jpg', 'jogging pants 3.jpg', 'jogging pants 4.jpg', 'jogging pants 5.jpg']
            },
            {
                name: 'Leggings',
                images: ['leggings 1.jpg', 'leggings 2.jpg', 'leggings 3.jpg', 'leggings 4.jpg', 'leggings 5.jpg']
            },
            {
                name: 'Pants',
                images: ['pants 1.jpg', 'pants 2.jpg', 'pants 3.jpg', 'pants 4.jpg', 'pants 5.jpg']
            },
            {
                name: 'Skirt',
                images: ['skirt 1.jpg', 'skirt 2.jpg', 'skirt 3.jpg', 'skirt 4.jpg', 'skirt 5.jpg']
            },
            {
                name: 'Trousers',
                images: ['trousers 1.jpg', 'trousers 2.jpg', 'trousers 3.jpg', 'trousers 4.jpg', 'trousers 5.jpg']
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
                images: ['dress 1.jpg', 'dress 2.jpg', 'dress 3.jpg', 'dress 4.jpg', 'dress 5.jpg']
            },
            {
                name: 'Skirts',
                images: ['skirts 1.jpg', 'skirts 2.jpg', 'skirts 3.jpg', 'skirts 4.jpg', 'skirts 5.jpg']
            },
            {
                name: 'Jumpsuit',
                images: ['jumpsuit 1.jpg', 'jumpsuit 2.jpg', 'jumpsuit 3.jpg', 'jumpsuit 4.jpg', 'jumpsuit 5.jpg']
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
                images: ['suits 1.jpg', 'suits 2.jpg', 'suits 3.jpg', 'suits 4.jpg', 'suits 5.jpg']
            },
            {
                name: 'Tailleur',
                images: ['tailleur 1.jpg', 'tailleur 2.jpg', 'tailleur 3.jpg', 'tailleur 4.jpg', 'tailleur 5.jpg']
            },
            {
                name: 'Uniform',
                images: ['uniform 1.jpg', 'uniform 2.jpg', 'uniform 3.jpg', 'uniform 4.jpg', 'uniform 5.jpg']
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
                images: ['blazer 1.jpg', 'blazer 2.jpg', 'blazer 3.jpg', 'blazer 4.jpg', 'blazer 5.jpg']
            },
            {
                name: 'Coat',
                images: ['coat 1.jpg', 'coat 2.jpg', 'coat 3.jpg', 'coat 4.jpg', 'coat 5.jpg']
            },
            {
                name: 'Jacket',
                images: ['jacket 1.jpg', 'jacket 2.jpg', 'jacket 3.jpg', 'jacket 4.jpg', 'jacket 5.jpg']
            },
            {
                name: 'Parka',
                images: ['parka 1.jpg', 'parka 2.jpg', 'parka 3.jpg', 'parka 4.jpg', 'parka 5.jpg']
            },
            {
                name: 'Poncho',
                images: ['poncho 1.jpg', 'poncho 2.jpg', 'poncho 3.jpg', 'poncho 4.jpg', 'poncho 5.jpg']
            },
            {
                name: 'Trench coat',
                images: ['trench coat 1.jpg', 'trench coat 2.jpg', 'trench coat 3.jpg', 'trench coat 4.jpg', 'trench coat 5.jpg']
            },
            {
                name: 'Vest',
                images: ['vest 1.jpg', 'vest 2.jpg', 'vest 3.jpg', 'vest 4.jpg', 'vest 5.jpg']
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
                images: ['athletic shorts 1.jpg', 'athletic shorts 2.jpg', 'athletic shorts 3.jpg', 'athletic shorts 4.jpg', 'athletic shorts 5.jpg']
            },
            {
                name: 'Tracksuits',
                images: ['tracksuits 1.jpg', 'tracksuits 2.jpg', 'tracksuits 3.jpg', 'tracksuits 4.jpg', 'tracksuits 5.jpg']
            },
            {
                name: 'Leggings',
                images: ['leggings 1.jpg', 'leggings 2.jpg', 'leggings 3.jpg', 'leggings 4.jpg', 'leggings 5.jpg']
            },
            {
                name: 'Performance tops',
                images: ['performance tops 1.jpg', 'performance tops 2.jpg', 'performance tops 3.jpg', 'performance tops 4.jpg', 'performance tops 5.jpg']
            },
            {
                name: 'Compression wear',
                images: ['compression wear 1.jpg', 'compression wear 2.jpg', 'compression wear 3.jpg', 'compression wear 4.jpg', 'compression wear 5.jpg']
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
                images: ['belt 1.jpg', 'belt 2.jpg', 'belt 3.jpg', 'belt 4.jpg', 'belt 5.jpg']
            },
            {
                name: 'Cap',
                images: ['cap 1.jpg', 'cap 2.jpg', 'cap 3.jpg', 'cap 4.jpg', 'cap 5.jpg']
            },
            {
                name: 'Hat',
                images: ['hat 1.jpg', 'hat 2.jpg', 'hat 3.jpg', 'hat 4.jpg', 'hat 5.jpg']
            },
            {
                name: 'Scarf',
                images: ['scarf 1.jpg', 'scarf 2.jpg', 'scarf 3.jpg', 'scarf 4.jpg', 'scarf 5.jpg']
            }
        ]
    }
];
