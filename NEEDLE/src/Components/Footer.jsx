import React from 'react'
import logo from '../assets/logo.svg';
import CW from '../assets/CW.svg';
import first from '../assets/Clip path group.svg';import second from '../assets/Vector-1.svg';import third from '../assets/Vector-2.svg';import fourth from '../assets/Vector.svg';
function Footer() {
  return (
    <div>
      <div>
        <img src={logo} alt="" className='h-[300px]  mx-auto'/>
      </div>
      <div className='h-[30px] w-full bg-black'>
        <ul className='flex justify-around items-center '>
        <li><ul className='flex gap-4 justify-center items-center'>
        <li><img src={CW} alt=""  className='h-[20px] mt-[8px]'/></li>
        <li><h3 className='text-[#929195] font-inter text-[14px]  pt-[5px]'>2024 NEEDLE , All Rights Reserved.</h3></li>
        </ul></li>
        <li><ul className='flex justify-center items-center gap-4'>
            <li><img src={first} alt=""  className='hover:cursor-pointer '/></li>
            <li><img src={second} alt=""  className='hover:cursor-pointer'/></li>
            <li><img src={third} alt=""  className='hover:cursor-pointer'/></li>
            <li><img src={fourth} alt="" className='hover:cursor-pointer' /></li>
        </ul></li>
            </ul>
      </div>
    </div>
  )
}

export default Footer
