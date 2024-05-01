import React, { useState, useEffect, useRef } from 'react';

const Profile = () => {
    const [user, setUser] = useState();
    const [newName, setNewName] = useState('');
    const [newEmail, setNewEmail] = useState('');
    const [newCity, setNewCity] = useState('');
    const [newPhone, setNewPhone] = useState('');
    const [newPP, setNewPP] = useState('');
    const [userType, setUserType] = useState('');
    const [errorMsg, setErrorMsg] = useState('');
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');
    const [image, setImage] = useState('');
    const [price, setPrice] = useState('');
    const [category, setCategory] = useState('');
    const [postSpeciality, setPostSpeciality] = useState('');
    const [speciality, setSpeciality] = useState('');
    
    const fileInputRef = useRef(null); 

    const handlePost = async (e) => {
        e.preventDefault();
        try {
            const response = await fetch(' https://tailor-client-ps9z.onrender.com/post/create', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ title, description, image, price, category, postSpeciality,tailor:user._id })
            });

            if (!response.ok) {
                console.error('Post failed:', response.statusText);
                return;
            }

            const data = await response.json();
            console.log(data);
            setTitle('');
            setDescription('');
            setImage('');
            setPrice('');
            setCategory('');
            setPostSpeciality('');
        } catch (error) {
            console.error('Error:', error);
            setErrorMsg('Server error');
        }
    }
  
    useEffect(() => {
        const userData = JSON.parse(localStorage.getItem('user'));
        if (userData) {
            setUser(userData);
            setUserType(userData.userType); 
        }
    }, []);


    const handleSubmit = async (e) => {
        e.preventDefault();

        // Create an object with updated user data
        const updatedUser = {
            _id: user._id,
            name: newName || user.name,
            email: newEmail || user.email,
            city: newCity || user.city,
            phone: newPhone || user.phone,
            profilePicture: newPP || user.profilePicture,
            speciality: speciality || user.speciality
        };

        try {
            const response = await fetch(`https://tailor-client-ps9z.onrender.com/update/${user._id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(updatedUser)
            });

            if (response.ok) {
                // Get the updated user data from the response
                const updatedUserData = await response.json();

                // Update the local storage with the updated user data
                localStorage.setItem('user', JSON.stringify(updatedUserData));
                setUser(updatedUserData);
            } else {
                console.error('Update failed:', response.statusText);
            }
        } catch (error) {
            console.error('Error:', error);
            setErrorMsg('Server error');
        }
        fileInputRef.current.value = null; 
    };

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function () {
                const result = reader.result;
                setNewPP(result);
            };
            reader.onerror = function (error) {
                console.error('Error:', error);
            };
        }
    };
    const handleupload = (e) => {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function () {
                const result = reader.result;
                setImage(result);
            };
            reader.onerror = function (error) {
                console.error('Error:', error);
            };
        }
    }
    return (
        <div className=''>
            <h1>Profile</h1>
            <form onSubmit={handleSubmit}>
                <h2>{user?.name}</h2>
                <input type="text" value={newName} onChange={(e) => setNewName(e.target.value)} />
                
                <h2>{user?.email}</h2>
                <input type="text" value={newEmail} onChange={(e) => setNewEmail(e.target.value)} />

                <h2>{user?.gender}</h2>
           
                <h2>{user?.city}</h2>
                <input type="text" value={newCity} onChange={(e) => setNewCity(e.target.value)} />

                <h2>{user?.phone}</h2>
                <input type="text" value={newPhone} onChange={(e) => setNewPhone(e.target.value)} />
                <br />
                <h2>{user?.speciality}</h2>
                <input type="text" value={speciality} onChange={(e)=>{setSpeciality(e.target.value)}}/>
                <br/><br />
                <label>PP</label>
                <img src={user?.profilePicture} alt="" />
                <input type="file" name='image' onChange={handleFileChange} ref={fileInputRef} />
                
                <input type="submit" />
            </form>
           
                    <br />
                    <form onSubmit={handlePost}>
                        <label >Title</label>
                        <input type="text" value={title} onChange={e => setTitle(e.target.value)} />
                        <label >Description</label>
                        <input type="text" value={description} onChange={e => setDescription(e.target.value)} />
                        <label >Image</label>
                        <input type="file" name='postImage' onChange={handleupload} ref={fileInputRef} />
                        <label >Price</label>
                        <input type="text" value={price} onChange={e => setPrice(e.target.value)} />
                        <label >Category</label>
                        <input type="text" value={category} onChange={e => setCategory(e.target.value)} />
                        <label >Speciality</label>
                        <input type="text" value={postSpeciality} onChange={e => setPostSpeciality(e.target.value)} />
                        <button type='submit'>createPost</button>
                    </form>
                
         
        </div>
    );
};

export default Profile;
