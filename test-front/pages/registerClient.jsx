import React, { useState } from 'react';

function RegisterClient() {
  const [name, setName] = useState('');
  const [password, setPassword] = useState('');
  const [email, setEmail] = useState('');
  const [gender, setGender] = useState('');
  const [errorMsg, setErrorMsg] = useState('');

  localStorage.setItem('user', {name,email,gender});
  const processResponse = (data) => {
    if (typeof data === 'object') {
        // If data is an object, return it
        localStorage.setItem('user', JSON.stringify( data ));
    } else if (typeof data === 'string') {
        // If data is a string (message), set error message
        setErrorMsg(data);
    } else {
        // Handle other types of data if necessary
        console.error('Unexpected data type:', typeof data);
    }
  };
  
  async function handleSubmit(e) {
    e.preventDefault();
    if (!name || !email || !password || !gender){setErrorMsg('Please fill all the fields'); return;}
    try {
      const response = await fetch('https://tailor-client-ps9z.onrender.com/register/client', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, name, password, gender }),
      });
      const data = await response.json();
      
      processResponse(data);
      
    } catch (error) {
      console.error('Error:', error);
     
      setErrorMsg(error.response.data.message);
    }
  }

  return (
    <div>
      <h1>Register</h1>
      <form onSubmit={handleSubmit}>
        <label>
          Username
          <input type="text" onChange={(e) => setName(e.target.value)} value={name} />
        </label>
        <label>
          Password
          <input type="password" onChange={(e) => setPassword(e.target.value)} value={password} />
        </label>
        <label>
          Email
          <input type="email" onChange={(e) => setEmail(e.target.value)} value={email} />
        </label>
        <label>
          Gender
          <select id="gender" value={gender} onChange={(e) => setGender(e.target.value)}>
            <option value="">Select</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
          </select>
        </label>
        <button type="submit">Register</button>
      </form>
      {errorMsg && <p className='text-red-500 text-sm mt-2'>{errorMsg}</p>}
    </div>
  );
}

export default RegisterClient;
