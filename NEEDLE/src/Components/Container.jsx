import React from 'react'
import Testimonials from './Testimonials'
import bg from '../assets/Testimonials1.svg';

function Container() {
  return (
    <div className='bg-cover bg-center h-[800px]  '
    style={{ backgroundImage: `url(${bg})` }}>
        <div>
            <ul className='ml-[77px]'>
                <li> <h3 className='text-[#D29760] font-inter text-[36px] font-bold mt-[20px]'>Testimonials</h3></li>
                <li><h1 className='text-[#191712] font-montserrat font-semibold text-[40px] mt-[30px]'>Our happy clients</h1></li>
                <li> <p className='text-[#1E1E1E] text-montserrat text-[20px] mt-[30px]'>Hear What Our Users Have to Say! <br />
Explore the testimonials from our vibrant community on Needle. Hear success <br /> stories, find inspiration, and witness transformations. Join us in celebrating our <br /> users' voices.</p></li>
            </ul>
           
      <Testimonials/>
      </div>
    </div>
  )
}

export default Container
