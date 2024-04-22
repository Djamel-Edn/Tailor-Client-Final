import { useState } from "react";

export default function RegisterTailor() {
    const [name, setName] = useState('');
    const [password, setPassword] = useState('');
    const [email,setEmail]=useState('');
    const [gender,setGender]=useState('');
    const [city,setCity]=useState('');
    const [phone,setPhone]=useState('');
    const [errorMsg, setErrorMsg] = useState('');
    const processResponse = (data) => {
      if (typeof data === 'object') {
          // If data is an object, return it
          localStorage.setItem('user', JSON.stringify(data));
      } else if (typeof data === 'string') {
          // If data is a string (message), set error message
          setErrorMsg(data);
      }
    };

    async function handlesubmit(e) {
        e.preventDefault();
    if (!name || !email || !password || !gender ||!city ||!phone){setErrorMsg('Please fill all the fields'); return;}
    try {
      const response = await fetch('http://localhost:5001/register/tailor', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, name, password, gender,city,phone }),
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
        <form onSubmit={handlesubmit}>
            <label>
            Username
            <input type="text" onChange={e=>setName(e.target.value)} value={name}/>
            </label>
            <label>
            Password
            <input type="password" onChange={e=>setPassword(e.target.value)} value={password} />
            </label>
            <label>
            Email
            </label>
            <input type="email" onChange={e=>setEmail(e.target.value)} value={email}/>
            <label>
                gender
            </label>
            <select name="" id="gender" value={gender} onChange={e=>setGender(e.target.value)}>
                <option value="">Select</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>

            </select>
            <label htmlFor="">
                City
            </label>
            <input type="text" value={city} onChange={e=>setCity(e.target.value)}/>
            <label htmlFor="">phone number</label>
            <input type="tel" value={phone} onChange={e=>setPhone(e.target.value)}/>
            <button type="submit">Register</button>
            {errorMsg && <p className='text-red-500 text-sm mt-2'>{errorMsg}</p>}
        </form>
    </div>
  )
}
