import React, { useState } from 'react'
import { Link, Navigate } from 'react-router-dom';

const Login = () => {    
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [errorMsg, setErrorMsg] = useState('');
    const [loggedIn, setLoggedIn] = useState(false);
    async function handleSubmite(e){
        e.preventDefault();
        if (!email || !password){setErrorMsg('Please fill all the fields'); return;}
        try{
            const response =await fetch('http://localhost:5001/login',{
                method:'POST',
                headers:{
                    'Content-Type':'application/json',
                },
                body:JSON.stringify({email,password}),
            })
            const data = await response.json();
             
            if (data.email){localStorage.setItem('user', JSON.stringify(data));
            console.log(data);
            setLoggedIn(true);
            return;}
            else {setErrorMsg(data); return;}
        }
        catch(error){
            console.error('Error:', error);
            setErrorMsg(error.response.data.message);
        }
    }

    return (
        <div>
            <h1>Login</h1>
            <form onSubmit={handleSubmite}>
                <label>
                    Email
                    <input type="email" value={email} onChange={e=>setEmail(e.target.value)}/>
                </label>
                <label>
                    Password
                    <input type="password" value={password} onChange={e=>setPassword(e.target.value)}/>
                </label>
                <button type="submit">Login</button>
                </form>
                {errorMsg && <p className='text-red-500 text-sm mt-2'>{errorMsg}</p>}
                <Link to={'/login/forgotpassword'}>forget your password?</Link>
        </div>
    )
}
export default Login;