import {motion,AnimatePresence} from 'framer-motion'   
import {useSnapshot} from 'valtio'
import {headContainerAnimation,headTextAnimation,slideAnimation,headContentAnimation} from '../config/motion'

import state from '../store'
import CustomButton from '../components/CustomButton'

const CreateStyle = () => {
    const snap=useSnapshot(state)

    return ( 
    <AnimatePresence>
        {snap.intro && (
            <motion.section className='home'{...slideAnimation('left')}>
                <motion.header>
                    <img src="./threejs.png" alt="logo" className='w-8 h-8 object-contain' />
                </motion.header>
                <motion.div className='home-content flex flex-col gap-10' {...headContainerAnimation}>
                <motion.div {...headTextAnimation} className='flex justify-center'>
            <h1 className='head-text  text-5xl'>
                LET'S DO IT
            </h1>
                </motion.div>
                <motion.div {...headContentAnimation} className='flex flex-col gap-5 items-center'>
                    <p className='max-w-md font-normal text-gray-600 text-base'>
                        create unique and exclusive shirt with our brand new 3D cusomization tool. <strong>Unleash your imagination</strong>and define your style
                    </p>
                    <CustomButton
                    type='filled'
                    title="Customize it"
                    handleClicl={()=>state.intro=false}
                    customStyles='w-fit px-4 py-2.5 font-bold text-sm'
                    />
            </motion.div>
                </motion.div>
            </motion.section>
        )}


    </AnimatePresence>   

     );
}
 
export default CreateStyle;