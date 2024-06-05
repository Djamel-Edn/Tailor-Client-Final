import React from 'react'
import first from '../assets/first.svg';
import second from '../assets/Second.svg';
import third from '../assets/Third.svg';
function Benifits() {
  return (
    <div>
        <div className='ml-[77px] mt-[30px] pb-[60px]'>
        <ul>
            <li><h3 className='text-[#D29760]  font-inter text-[33px] font-bold'>Benifits</h3></li>
            <li><h1 className='text-[#191712] font-montserrat text-[40px] font-semibold mt-[20px]'>Why should you use NEEDLE ?</h1></li>
        </ul>
      
      
      <ul className='flex space-x-5 justify-center mt-[90px]'>
        <li>
            <ul className='h-[435px] w-[375px] bg-gradient-to-b from-[#FFB978] to-[#D29760] rounded-[24px] pt-[45px] pb-[25px] px-[25px] transform transition duration-500 hover:scale-105 hover:shadow-2xl'>
                <li> <img src={first} alt=""  className='mx-auto h-[60px]'/></li>
                <li><h4 className='text-[22px] font-montserrat font-semibold text-center text-white mt-[25px]'>Effortless Customization & <br />
                        Communication</h4></li>
                <li><p className='text-white font-inter text-[20px] text-left mt-[40px] ml-[15%]'>Browse styles, design <br />
                     your own, and chat <br />
                     with tailors for a seamless custom <br />
                    clothing experience.</p></li>
                         </ul>
                            </li>
        <li><ul className='h-[435px] w-[375px] bg-gradient-to-b from-[#FFB978] to-[#D29760] rounded-[24px] pt-[45px] pb-[25px] px-[25px] transform transition duration-500 hover:scale-105 hover:shadow-2xl'>
            <li><img src={second} alt="" className='mx-auto h-[60px]'/></li>
            <li><h4 className='text-[22px] font-montserrat font-semibold text-center text-white mt-[25px]'>Real-Time Tracking & Client <br />
                Management</h4></li>
            <li><p className='text-white font-inter text-[20px]  mt-[40px] text-left ml-[15%]'>Track orders, manage <br />
               clients, and build your <br />
                reputation – all within the <br />
                 Needle app.</p> </li>
                    </ul>
                        </li>
        <li>
            <ul className='h-[435px] w-[375px] bg-gradient-to-b from-[#FFB978] to-[#D29760] rounded-[24px] pt-[45px] pb-[25px] px-[25px] transform transition duration-500 hover:scale-105 hover:shadow-2xl'>
                <li><img src={third} alt="" className='mx-auto h-[60px]' /></li>
                <li><h4 className='text-[22px] font-montserrat font-semibold text-center text-white mt-[25px]'>Find Your Perfect Fit</h4></li>
                <li><p className='text-white font-inter text-[20px] text-left mt-[40px] ml-[15%]'>Never settle for off-the- <br />
                    rack again. Needle <br />
                 connects you with skilled <br />
                 tailors to ensure a <br />
                 garment that flatters <br />
                 your form and reflects <br />
                  your unique style.</p></li>
                        </ul>
                            </li>
      </ul>
    </div>
</div>
  )
}

export default Benifits
