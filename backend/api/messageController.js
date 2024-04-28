const { default: mongoose } = require('mongoose');
const messageModel = require('../Models/messageModel');
const chatModel = require('../Models/chatModel');

const createMessage = async (req, res) => {
    const { chatId, senderId, text, image } = req.body;

    try {
        if (!chatId || !mongoose.Types.ObjectId.isValid(chatId)) {
            return res.status(400).json({ error: 'Invalid chat ID' });
        }

        const chat = await chatModel.findById(chatId);
        if (!chat) {
            return res.status(404).json({ error: 'Chat not found' });
        }

        const newMessage = new messageModel({ chatId, senderId, text, image });
        const savedMessage = await newMessage.save();

        // Add the message to the chat's messages array
        chat.messages.push(savedMessage);
        await chat.save();

        res.status(201).json(savedMessage);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server error' });
    }
};
const getMessages = async (req, res) => {
  const { chatId } = req.params;
  try {
    const messages = await messageModel.find({chatId});
    res.status(200).json(messages);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  } 
};

module.exports = {
  createMessage,
  getMessages
};
