const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
const path = require('path');
const connectDB = require('./config/db');

const swaggerUi = require('swagger-ui-express');
const YAML = require('yamljs');
const cron = require('./crons');
const swaggerDocument = YAML.load('./swagger.yaml');


// Load environment variables
dotenv.config();
// Connect to the database
connectDB();
cron();

const app = express();





app.use('/images', express.static(path.join(__dirname, 'images')));
// Middleware
app.use(cors()); // Enable Cross-Origin Resource Sharing
app.use(express.json()); // Body parser for JSON format
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));





// Define API Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/patients', require('./routes/patients'));
app.use('/api/cases', require('./routes/cases'));



// Serve uploaded files statically
// app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));