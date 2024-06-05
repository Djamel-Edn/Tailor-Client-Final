import React from 'react'
import Phone from '../assets/Phone.svg';
const handlePlayStoreClick = () => {
  window.location.href = 'https://play.google.com/store'; // Replace with your app's Play Store URL
};
function Hero() {
  return (
    <div>
      <ul className='flex justify-between'>
        <ul className='ml-[77px] mt-[70px]'>
            <li><h1 className='font-nanu text-[72px]  text-[#191712]'>Thread Your Dreams <br />
                    With <span className='text-[#D29760]'>NEEDLE</span></h1></li>
            <li><p className='font-montserrat text-[24px] text-[#1E1E1E] mt-[30px]'>Simplifies the tailor-client connection, making <br />
            bespoke clothing creationeffortless and <br />
            personalized.</p></li>
            <li><button className='text-[20px] font-semibold font-montserrat text-white bg-[#191712] rounded-[16px] py-[10px]
            px-[20px] mt-[50px]  ' onClick={handlePlayStoreClick}>Download</button></li>
        </ul>
        <li className='mr-[50px]'> <img src={Phone} alt=""  className='h-[600px]'/></li>
      </ul>
    </div>
  )
}

export default Hero
