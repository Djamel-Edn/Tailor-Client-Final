const chatModel = require('../Models/chatModel');
const clientModel = require('../Models/clientmodel');
const messageModel = require('../Models/messageModel');
const tailorModel = require('../Models/tailorModel');

const createOrFindChat = async (req, res) => {
    const { clientId, tailorId } = req.body;

    try {
        // Check if both client and tailor IDs are provided
        if (!clientId || !tailorId) {
            return res.status(400).json({ error: 'Both client and tailor IDs are required' });
        }
        // Assuming clientModel and tailorModel are imported from their respective files
        const client = await clientModel.findById(clientId);
        const tailor = await tailorModel.findById(tailorId);
        
        if (!client) {
            return res.status(404).json({ error: 'Client not found' });
        }
        
        if (!tailor) {
            return res.status(404).json({ error: 'Tailor not found' });
        }
        
        // Try to find the chat
        let chat = await chatModel.findOne({ client: clientId, tailor: tailorId })
        .populate('client')  // Populate the client field
        .populate('tailor')
        .populate('messages')
        
        // If chat already exists, return it
        if (chat) {
            return res.status(200).json(chat);
        }
        const newChat = new chatModel({ client: clientId, tailor: tailorId });
        
        
        // Optionally, populate the messages field if needed
        console.log('test')
        
        const savedChat = await newChat.save();

        res.status(201).json(savedChat); // Return 201 for created
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server error' });
    }
};

module.exports = { createOrFindChat };
