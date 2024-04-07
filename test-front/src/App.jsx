import {Routes, Route, Navigate} from 'react-router-dom'
import Login from './../pages/login';
import RegisterClient from './../pages/registerClient';
import RegisterTailor from './../pages/registerTailor';
import Verified from './../pages/verified';
function App() {


  return (
    
      <Routes>

        <Route path="/login" element={<Login />} />
        <Route path="/registerClient" element={<RegisterClient />} />
        <Route path="/registerTailor" element={<RegisterTailor />} />
        <Route path={`/verify/:_id/:uniqueString`} element={<Verified />} />
        <Route path='*' element={<Navigate  to='/'/>}></Route>
      </Routes>
    
  )
}

export default App
