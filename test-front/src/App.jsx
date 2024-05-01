import {Routes, Route, Navigate} from 'react-router-dom'
import Login from './../pages/login';
import RegisterClient from './../pages/registerClient';
import RegisterTailor from './../pages/registerTailor';
import Forgotpassword from './../pages/forgotpassword';
import ResetPassword from './../pages/resetPassword';
import Profile from '../pages/profile';
import Home from '../pages/home';
import Recherche from '../pages/recherche';
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
        <Route path="/recherche" element={<Recherche/>} />
       
        <Route path='*' element={<Navigate  to='/'/>}/>
      </Routes>
    
  )
} 

export default App
