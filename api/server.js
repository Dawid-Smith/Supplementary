const express = require('express');
const app = express();

app.get('/health', (req, res) => res.json({ status: 'ok' }));
app.get('/products', (req, res) => res.json([{ id: 1, name: 'Sample Product' }]));

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`API running on port ${port}`));
