import React, { useState, useEffect } from 'react';
import fm1 from "../assets/emy.svg";
import fm2 from "../assets/female1.svg";
import ml1 from "../assets/male.svg";
import fm3 from "../assets/fm3.jpg";
const testimonials = [
  {
    name: 'John Kenedy',
    rating: 5,
    description: 'This app is amazing! It has greatly improved my productivity.',
    image: ml1,
  },
  {
    name: 'Jane Smith',
    rating: 4,
    description: 'A fantastic tool for tailors. Highly recommended!',
    image: fm2,
  },
  {
    name: 'Emily Johnson',
    rating: 5,
    description: 'Great experience! The training materials are top-notch.',
    image: fm1,
  },
  {
    name: 'Sarah Williams',
    rating: 5,
    description: 'Excellent support and very intuitive design. Highly recommend!',
    image: fm3, 
  },
];

const Testimonials = () => {
  const [index, setIndex] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setIndex((prevIndex) => (prevIndex + 1) % testimonials.length);
    }, 2500); // Change slide every 3 seconds

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="overflow-hidden relative w-full  max-w-[60%] mx-auto mt-[120px] h-[350px]">
      <div
        className="flex transition-transform duration-500"
        style={{ transform: `translateX(-${index * 100}%)` }}
      >
        {testimonials.map((testimonial, i) => (
          <div
            key={i}
            className="flex-shrink-0 w-full flex flex-col items-center justify-center p-16 bg-[#D29760] shadow-lg rounded-[50px] mx-2"
          >
            <img
              className="w-[100px] h-[100px] rounded-full mb-4"
              src={testimonial.image}
              alt={testimonial.name}
            />
            <h3 className="text-[32px] font-bold mb-2 text-white">{testimonial.name}</h3>
            <div className="flex mb-2">
              {Array.from({ length: testimonial.rating }).map((_, idx) => (
                <svg
                  key={idx}
                  className="w-5 h-5 text-yellow-500"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.966a1 1 0 00.95.691h4.163c.97 0 1.371 1.24.588 1.81l-3.368 2.451a1 1 0 00-.364 1.118l1.287 3.965c.3.922-.755 1.688-1.54 1.117l-3.368-2.451a1 1 0 00-1.175 0l-3.368 2.451c-.785.571-1.84-.195-1.54-1.117l1.287-3.965a1 1 0 00-.364-1.118L2.672 9.394c-.784-.57-.382-1.81.588-1.81h4.163a1 1 0 00.95-.691l1.286-3.966z" />
                </svg>
              ))}
            </div>
            <p className="text-center text-white text-[18px]">{testimonial.description}</p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Testimonials;

