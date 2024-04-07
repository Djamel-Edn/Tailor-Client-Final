import React, { useEffect } from 'react';

export default function Verified() {
  const currentUrl = window.location.href;

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(currentUrl, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
        });
        if (response.ok) {
          const data = await response.json();
          // Do something with the data if needed
        } else {
          throw new Error('Failed to fetch data');
        }
      } catch (error) {
        console.error('Error fetching data:', error);
        // Handle errors if necessary
      }
    };

    fetchData();
  }, []); 

  return (
    <div>
      <p>Your account is verified.</p>
      <p>Current URL: {currentUrl}</p>
    </div>
  );
}
