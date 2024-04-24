const chatModel = require('../Models/chatModel');

const createOrFindChat = async (req, res) => {
    const { clientId, tailorId } = req.body;

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

        // Find the chat between the client and tailor
        let chat = await chatModel.findOne({ client: clientId, tailor: tailorId }).populate('messages');

        // If chat doesn't exist, create a new one
        if (!chat) {
            const newChat = new chatModel({ client: clientId, tailor: tailorId });
            chat = await newChat.save();
        }

        res.status(200).json(chat);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server error' });
    }
};


module.exports={createOrFindChat}