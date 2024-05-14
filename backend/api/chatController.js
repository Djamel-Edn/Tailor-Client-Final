const chatModel = require('../Models/chatModel');
const clientModel = require('../Models/clientModel');
const tailorModel = require('../Models/tailorModel');

const createOrFindChat = async (req, res) => {
    const { clientId, tailorId } = req.body;

    try {
        if (!clientId || !tailorId) {
            return res.status(400).json({ error: 'Both client and tailor IDs are required' });
        }
        const client = await clientModel.findById(clientId);
        const tailor = await tailorModel.findById(tailorId);
        
        if (!client) {
            return res.status(404).json({ error: 'Client not found' });
        }
        
        if (!tailor) {
            return res.status(404).json({ error: 'Tailor not found' });
        }
        
        let chat = await chatModel.findOne({ client: clientId, tailor: tailorId })
        .populate('client')  
        .populate('tailor')
        .populate('messages')
        
        if (chat) {
            return res.status(200).json(chat);
        }
        const newChat = new chatModel({ client: clientId, tailor: tailorId });
        
        
        
        const savedChat = await newChat.save();

        res.status(201).json(savedChat); 
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server error' });
    }
};

module.exports = { createOrFindChat };
