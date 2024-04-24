const chatModel = require('../Models/chatModel');
const clientmodel = require('../Models/clientmodel');
const tailorModel = require('../Models/tailorModel');

const createOrFindChat = async (req, res) => {
    const { clientId, tailorId } = req.body;

    try {
        // Check if both client and tailor IDs are provided
        console.log("test")
        if (!clientId || !tailorId) {
            return res.status(400).json({ error: 'Both client and tailor IDs are required' });
        }

        // Assuming clientModel and tailorModel are imported from their respective files
        const client = await clientmodel.findById(clientId);
        const tailor = await tailorModel.findById(tailorId);

        if (!client) {
            return res.status(404).json({ error: 'Client not found' });
        }

        if (!tailor) {
            return res.status(404).json({ error: 'Tailor not found' });
        }

        // Find the chat between the client and tailor and populate client, tailor, and messages
        let chat = await chatModel.findOne({ client: clientId, tailor: tailorId })
                                   .populate({
                                       path: 'client',
                                       model: 'Client'
                                   })
                                   .populate({
                                       path: 'tailor',
                                       model: 'Tailor'
                                   })
                                   .populate({
                                       path: 'messages',
                                       model: 'Message'
                                   });

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