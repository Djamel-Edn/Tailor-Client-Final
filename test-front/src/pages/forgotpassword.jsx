import React, { useState } from 'react'


const Forgotpassword = () => {    
    const [email, setEmail] = useState('');
    const [errorMsg, setErrorMsg] = useState('');
    async function handleSubmite(e){
        e.preventDefault();
        if (!email ){setErrorMsg('Please fill all the fields'); return;}
        try{
            const response =await fetch(' https://tailor-client-ps9z.onrender.com/resetPassword',{
                method:'POST',
                headers:{
                    'Content-Type':'application/json',
                },
                body:JSON.stringify({email}),
            })
            const data = await response.json();
            if (!data.name){setErrorMsg(data); return;}
            console.log(data)
        }
        catch(error){
            console.error('Error:', error);
            setErrorMsg(error.response.data.message);
        }
    }

    return (
        <div>
            <h1>forgot my password</h1>
            <form onSubmit={handleSubmite}>
                <label>
                    enter your Email
                    <input type="email" value={email} onChange={e=>setEmail(e.target.value)}/>
                </label>
              
                <button type="submit" >Submit</button>
                </form>
                {errorMsg && <p className='text-red-500 text-sm mt-2'>{errorMsg}</p>}
                
        </div>
    )
}
export default Forgotpassword;