import React from 'react'

import NavBar from './NavBar'
import Hero from './Hero'
import Benifits from './Benifits'
import FU from './FU'
import TU from './TU'
import Footer from './Footer'
import Container from './Container'

const LandingPage = () => {
  return (
    <div className='bg-[#FFF4DE]'> 
      <NavBar/>
      <Hero/>
      <Benifits/>
      <FU/>
      <TU/>
      <Container/>
      <Footer/>
    </div>
  )
}

export default LandingPage
