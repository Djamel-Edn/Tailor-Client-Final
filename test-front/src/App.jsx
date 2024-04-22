import {Routes, Route, Navigate} from 'react-router-dom'
import Login from './../pages/login';
import RegisterClient from './../pages/registerClient';
import RegisterTailor from './../pages/registerTailor';
import Forgotpassword from './../pages/forgotpassword';
import ResetPassword from './../pages/resetPassword';
import Profile from '../pages/profile';
import Home from '../pages/home';
function App() {


  return (
    
      <Routes>

        <Route path="/login" element={<Login />} />
        <Route path="/registerClient" element={<RegisterClient />} />
        <Route path="/registerTailor" element={<RegisterTailor />} />
        <Route path="/login/forgotpassword" element={<Forgotpassword />} />
        <Route path="/:email/:resettoken" element={<ResetPassword />} />
        <Route path="/" element={<Forgotpassword />} />
        <Route path="/profile" element={<Profile/>} />
        <Route path="/home" element={<Home/>} />
        
        <Route path='*' element={<Navigate  to='/'/>}></Route>
      </Routes>
    
  )
} 

export default App
