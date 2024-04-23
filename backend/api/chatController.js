const chatModel = require('../Models/chatModel');

const createChat = async (req, res) => {
    const [clientId, tailorId] = req.body;

    try {
        // Check if both client and tailor IDs are provided
        if (!clientId || !tailorId) {
            return res.status(400).json({ error: 'Both client and tailor IDs are required' });
        }

       
        // Assuming clientModel and tailorModel are imported from their respective files
        const clientExists = await clientModel.exists({ _id: clientId });
        const tailorExists = await tailorModel.exists({ _id: tailorId });

        if (!clientExists) {
            return res.status(404).json({ error: 'Client not found' });
        }

        if (!tailorExists) {
            return res.status(404).json({ error: 'Tailor not found' });
        }

        // Create a new chat
        const newChat = new chatModel({ client: clientId, tailor: tailorId });
        const savedChat = await newChat.save();

        res.status(201).json(savedChat);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server error' });
    }
};


const findChat = async (req, res) => {
    const { clientId, tailorId } = req.params;
    try {
        const chat = await chatModel.findOne({ client: clientId, tailor: tailorId }).populate('messages');
        res.status(200).json(chat);
    } catch (error) {
        console.log(error);
        res.status(500).json(error);
    }
};

module.exports={createChat,findUserChats,findChat}