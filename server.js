// Required imports
const express = require('express');
const cors = require('cors');
const { GoogleGenerativeAI } = require('@google/generative-ai');
const { GEMINI_API_KEY, MODEL_NAME } = require('./constants');

// Initialize Express application
const app = express();

// Configure CORS
app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'baggage'],
    exposedHeaders: ['Content-Range', 'X-Content-Range'],
    credentials: true
}));

// Parse JSON bodies
app.use(express.json());

// Configure Gemini AI
const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: MODEL_NAME });

// Main POST endpoint
app.post('/', async (req, res) => {
    try {
        // Parse incoming data
        const { prompt, data } = req.body;

        // Validate request
        if (!req.body) {
            return res.status(400).json({ error: "No JSON data provided" });
        }

        if (!prompt || typeof prompt !== 'string') {
            return res.status(400).json({ error: "Invalid or missing 'prompt' field" });
        }

        // Construct final prompt
        const llm_response_formatting = "Please return only the final response and no additional context.";
        const final_prompt = data 
            ? `${prompt} to the following text: ${data}. ${llm_response_formatting}`
            : `Generated new text based on prompt: Prompt: ${prompt}. ${llm_response_formatting}`;

        // Generate content
        const result = await model.generateContent(final_prompt);
        const response = result.response.text().replace(/\*/g, '');

        res.status(200).json({ result: response });

    } catch (error) {
        if (error.name === 'BlockedPromptException') {
            res.status(422).json({ error: "Content blocked by safety filters" });
        } else if (error.name === 'ConnectionError') {
            res.status(503).json({ error: "Failed to connect to AI service" });
        } else if (error instanceof SyntaxError) {
            res.status(400).json({ error: "Invalid JSON format" });
        } else {
            res.status(400).json({ error: `Invalid value: ${error.message}` });
        }
    }
});

// Health check endpoint
app.get('/health', async (req, res) => {
    res.status(200).json({ response: "OK" });
});

// Start server
const PORT = process.env.PORT || 8080;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
});