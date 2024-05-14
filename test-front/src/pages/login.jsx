import React, { useState } from 'react';
import { Link, Navigate } from 'react-router-dom';

const Login = () => {    
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [errorMsg, setErrorMsg] = useState('');
    const [loggedIn, setLoggedIn] = useState(false);
    const [userData, setUserData] = useState(null); 
    console.log(errorMsg)
    async function handleSubmit(e) {
        e.preventDefault();
        if (!email || !password) {
            setErrorMsg('Please fill all the fields');
            return;
        }
        try {
            const response = await fetch('https://tailor-client-ps9z.onrender.com/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ email, password }),
            });
            console.log(response.body)
            const data = await response.json();
            if (!response.ok){
                throw data.error ;
            }
            if (data.email) {
                localStorage.setItem('user', JSON.stringify(data));
                setLoggedIn(true);
                setUserData(data); 
            } else {
                setErrorMsg(data);
            }
        } catch (error) {
            console.error('Error:', error);
            setErrorMsg(error);
        }
    }
    

    if (loggedIn) {
        return <Navigate to="/profile" />;
    }

    return (
        <div>
            <h1>Login</h1>
            <form onSubmit={handleSubmit}>
                <label>
                    Email
                    <input type="email" value={email} onChange={e => setEmail(e.target.value)} />
                </label>
                <label>
                    Password
                    <input type="password" value={password} onChange={e => setPassword(e.target.value)} />
                </label>
                <button type="submit">Login</button>
            </form>
            {errorMsg && <p className='text-red-500 text-sm mt-2'>{errorMsg}</p>}
            <Link to={'/login/forgotpassword'}>Forget your password?</Link>

            {/* Render user data if available */}
            {userData && (
                <div>
                    <p>Welcome, {userData.email}!</p>
                    <p>Name: {userData.name}</p>
                </div>
            )}
        </div>
    );
}

export default Login;
