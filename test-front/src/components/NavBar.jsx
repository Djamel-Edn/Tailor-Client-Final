import { Link } from 'react-router-dom';

const Navbar = () => {
    return (
        <nav className=" w-full flex justify-between py-4 px-8 text-xl">
            <div className="text-black text-2xl p-4">KHAYATLI</div>
            <div className="flex">
                <Link to="/" className="p-4">Home</Link>
                <Link to="/how-it-works" className="p-4">How it works</Link>
                <Link to="/about-us" className="p-4">About us</Link>
                <Link to="/contact-us" className="p-4">Contact us</Link>
            </div>
            <div className="flex items-center gap-3  text-lg">
                <Link to="/login" className="h-12 w-24 flex justify-center items-center  border bg-black text-white border-black rounded-full hover:bg-[#EFDBDA] hover:text-black duration-300">Login</Link>
                <Link to="/signup" className="bg-[#FFDB93] h-12 w-24 flex justify-center items-center border border-black rounded-full hover:bg-black duration-300 hover:text-white">Sign up</Link>
            </div>
        </nav>
    );
}

export default Navbar;