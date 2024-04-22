import React, { useEffect, useState } from 'react';

const Recherche = () => {
    const [tailors, setTailors] = useState([]);

    useEffect(() => {
        const fetchTailors = async () => {
            try {
                const response = await fetch('http://localhost:5001/getallTailors', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                });
                if (!response.ok) {
                    throw new Error('Failed to fetch data');
                }
                const data = await response.json();
                setTailors(data);
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };

        fetchTailors();
    }, []);

    // Function to convert base64 string to image URL
    const convertBase64ToImage = (base64String) => {
        try {
            // Check if the base64 string is not empty
            if (!base64String) {
                return null;
            }
    
            // Remove data URL prefix (if present)
            const base64 = base64String.replace(/^data:image\/[a-z]+;base64,/, '');
    
            // Decode base64 string
            const byteCharacters = atob(base64);
            const byteNumbers = new Array(byteCharacters.length);
            for (let i = 0; i < byteCharacters.length; i++) {
                byteNumbers[i] = byteCharacters.charCodeAt(i);
            }
            const byteArray = new Uint8Array(byteNumbers);
    
            // Create Blob from decoded byte array
            const blob = new Blob([byteArray], { type: 'image/jpeg' });
    
            // Create Object URL from Blob
            const urlCreator = window.URL || window.webkitURL;
            const imageUrl = urlCreator.createObjectURL(blob);
    
            return imageUrl;
        } catch (error) {
            console.error('Error converting base64 to image:', error);
            return null;
        }
    };
    

    return (
        <div>
            <h1>Home</h1>
            <div>
                {tailors.map((tailor) => (
                    <div key={tailor._id}>
                        <h1>{tailor.name}</h1>
                       
                        
                        {tailor.profilePicture && (
                            <img src={convertBase64ToImage(tailor.profilePicture)} alt='pp' style={{ maxWidth: '100%' }} />
                        )}
                    </div>
                ))}
            </div>
        </div>
    );
};

export default Recherche;
