const chatModel = require('../Models/chatModel');
const clientModel = require('../Models/clientmodel');
const tailorModel = require('../Models/tailorModel');

const createOrFindChat = async (req, res) => {
    const { clientId, tailorId } = req.body;

    try {
        // Check if both client and tailor IDs are provided
        if (!clientId || !tailorId) {
            return res.status(400).json({ error: 'Both client and tailor IDs are required' });
        }

        // Assuming clientModel and tailorModel are imported from their respective files
        const client = await clientModel.findById(clientId)
        const tailor = await tailorModel.findById(tailorId)

        if (!client) {
            return res.status(404).json({ error: 'Client not found' });
        }

        if (!tailor) {
            return res.status(404).json({ error: 'Tailor not found' });
        }

        // Create a new chat
        const newChat = new chatModel({ client: clientId, tailor: tailorId });
        delete client.password;
        delete tailor.password
        // Populate client and tailor fields
        newChat.client = client;
        newChat.tailor = tailor;

        // Optionally, you can populate the messages field if needed
        // For example:
        // const messages = await Message.find({ chat: newChat._id });
        // newChat.messages = messages;

        const savedChat = await newChat.save();

        res.status(200).json(savedChat);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server error' });
    }
};





module.exports={createOrFindChat}