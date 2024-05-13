import React from 'react';

const CustomButton = ({ type, title, customStyles, handleClick }) => {
    const generateStyle = (type, customStyles) => {
        let style = {};
        switch (type) {
            case 'filled':
                style = {
                    backgroundColor: '#2563EB',
                    color: '#fff',
                    ...customStyles
                }
                break;
            case 'secondary':
                style = {
                    backgroundColor: '#fff',
                    color: '#2563EB',
                    border: '1px solid #2563EB',
                    ...customStyles
                }
                break;
            default:
                break;
        }
        return style;
    }

    const buttonStyle = generateStyle(type, customStyles);

    return (
        <button 
            className='px-2 py-1.5 flex-1 rounded-md'
            style={buttonStyle} // Apply the generated style
            onClick={handleClick} // Add onClick event handler
        >
            {title} {/* Render the title */}
        </button>
    );
}

export default CustomButton; // Only one default export
