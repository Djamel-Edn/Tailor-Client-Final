import React from 'react'
import bg from '../assets/TU.svg';
function TU() {
  return (
    <div className='bg-cover bg-center h-[800px]  pb-[100px]'
    style={{ backgroundImage: `url(${bg})` }}>
      <ul className='ml-[77px] pt-[30px]'>
        <li><h3 className='text-[#D29760] font-inter text-[36px] font-bold '>Feautures</h3></li>
        <li> <h1 className='text-[#191712]  mt-[24px] font-montserrat text-[40px] font-semibold'>Tailor Features </h1></li>
        <li><p className='text-[20px]  mt-[24px] font-montserrat text-[#1E1E1E]'>Enhance your tailoring business with our app's advanced features, <br /> specifically designed to meet the unique demands of tailors.</p></li>
      </ul>
      <ul className='ml-[870px] mt-[-20px]'>
      <li><ul >
      <li><h4 className='text-[#D29760] text-[30px] font-inter font-bold'>Design It Yourself</h4></li>
      <li><p className='text-[#1E1E1E] font-montserrat text-[20px]'>Browse curated styles or design <br /> your own.</p></li>
              </ul></li>
      <li><ul className='mt-[80px]'>
        <li><h4 className='text-[#D29760] text-[30px] font-inter font-bold'>Stay Informed</h4></li>
        <li><p  className='text-[#1E1E1E] font-montserrat text-[20px]'>Track order progress in real- <br />time.Chat directly with your <br /> tailor for updates.</p></li>
                </ul></li>
      <li><ul className='mt-[60px]'>
      <li><h4 className='text-[#D29760] text-[30px] font-inter font-bold'>Perfect Fit Every Time</h4></li>
      <li><p  className='text-[#1E1E1E] font-montserrat text-[20px]'>Find skilled tailors for a custom  <br />experience.</p></li>
                </ul></li></ul>
    </div>
  )
}

export default TU
