    import React from 'react'
    import { AnimatePresence,motion } from 'framer-motion'
    import {download} from '../assets'
    import config from './../config/config';
    import {downloadCanvasToImage,reader} from '../config/helpers'
   import { fadeAnimation,slideAnimation } from '../config/motion'
 import { EditorTabs,FilterTabs,DecalTypes } from './../config/constants';
import { AiPicker,ColorPicker,Tab,FilePicker } from '../components'
import { useNavigate } from 'react-router-dom';
const Customizer = () => {
    const handleClick=()=>{
        Navigate('/createYourStyle')
    }
    const Navigate=useNavigate
      return (
        <AnimatePresence>
           
                <>
                <motion.div
                key={'custom'}
                className='absolute top-0 left-0  z-10 w-10 h-full'
                {...slideAnimation('left')}
                >
                <div className='flex items-center min-h-screen'>
                <div className='editorlabs-container tabs'>
                    {EditorTabs.map((tab)=>{
                        <Tab 
                        key={tab.name}
                        tab={tab}
                        handleClick={()=>{}}
                        >


                        </Tab>
                    })}

                </div>
                </div>

                </motion.div>
                <motion.div className='absolute top-5 right-5'>
                    <button className='' onClick={handleClick}>
                        Go back
                    </button>

                </motion.div>
                </>
   
        </AnimatePresence>
      )
    }
    
    export default Customizer