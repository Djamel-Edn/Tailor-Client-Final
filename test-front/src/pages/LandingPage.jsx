import React from 'react'
import { Navbar } from '../components'

export default function LandingPage() {
  return (
    <div className='h-screen w-full bg-[#FFF4DF] flex flex-col  '>
        <Navbar/>
        <div className='flex w-full  h-full mt-10'> 

        <div className="flex flex-col items-center  h-full w-[45%] p-5 px-6 gap-6">
        <h1 className="text-5xl text-black w-3/4 px-6 leading-tight">Thread Your Dreams With <span className='text-[#FFDB93]'>KHAYATLI</span></h1>
            <p className="text-2xl text-black ml-14  w-3/4">simplifies the tailor-client connection making bespoke clothing creation effortless and personalized</p>
            <div className='flex w-1/2 gap-10 mt-14'>

            <button className="border border-black py-5 px-7 rounded-full mt-4 bg-black text-white hover:bg-[#FFF4DE] duration-300">Get started</button>
            <button className="border bg-[#FFDB93] border-black py-5 px-7 rounded-full mt-4 hover:bg-black hover:text-white duration-300">Download</button>
            </div>
          </div>
          <div className='w-[55%] bg-black rounded-l-full flex justify-end items-end  h-full'>
            <img src="/phone.png" alt="not found" className='h-4/5 mr-20' />
          </div>
        </div>
    </div>
  )
}
