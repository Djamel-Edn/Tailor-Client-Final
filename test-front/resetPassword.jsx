import React, { useState } from 'react';

export default function ResetPassword() {
    const [newPassword, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [errorMsg, setErrorMsg] = useState('');

    async function handleSubmit(e) {
        e.preventDefault();
        
        if (!newPassword || !confirmPassword) {
            setErrorMsg('Please fill all the fields');
            return;
        }

        if (newPassword !== confirmPassword) {
            setErrorMsg('Passwords do not match');
            return;
        }

        try {
            const response = await fetch('https://tailor-client-ps9z.onrender.com/updatePassword', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ newPassword }),
            });

            const data = await response.json();
            if (!data.name){setErrorMsg(data); return;}
        } catch (error) {
            console.error('Error:', error);
            setErrorMsg('Failed to reset password');
        }
    }

    return (
        <div>
            <h1>Reset Password</h1>
            <form onSubmit={handleSubmit}>
                <label>
                    New Password:
                    <input type="password" value={newPassword} onChange={e => setPassword(e.target.value)} />
                </label>
                <label>
                    Confirm New Password:
                    <input type="password" value={confirmPassword} onChange={e => setConfirmPassword(e.target.value)} />
                </label>
                <button type="submit">Submit</button>
            </form>
            {errorMsg && <p className='text-red-500 text-sm mt-2'>{errorMsg}</p>}
        </div>
    );
}
