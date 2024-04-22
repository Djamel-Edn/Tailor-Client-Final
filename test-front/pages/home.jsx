import React, { useEffect, useState } from 'react';

const Home = () => {
    const [posts, setPosts] = useState([]);

    useEffect(() => {
        const fetchPosts = async () => {
            try {
                const response = await fetch('http://localhost:5001/post/getall', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                });
                if (!response.ok) {
                    throw new Error('Failed to fetch data');
                }
                const data = await response.json();
                setPosts(data);
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };

        fetchPosts();
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
                {posts.map((post) => (
                    <div key={post._id}>
                        <h1>{post.title}</h1>
                        <p>{post.description}</p>
                        <p>{post.author}</p>
                        <p>{post.price}</p>
                        *
                        {post.image && (
                            <img src={convertBase64ToImage(post.image)} alt={post.title} style={{ maxWidth: '100%' }} />
                        )}
                    </div>
                ))}
            </div>
        </div>
    );
};

export default Home;
