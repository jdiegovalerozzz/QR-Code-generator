const express = require('express');
const QRCode = require('qrcode');
const cors = require('cors');

require('dotenv').config(); 

const app = express();


app.use(cors()); 
app.use(express.json({ limit: '10kb' })); 


app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.post('/generate', async (req, res) => {
  const { text } = req.body;
  
  if (!text) {
    return res.status(400).json({ error: "Text is required" });
  }

  // Log simple para monitoreo en la Raspberry
  console.log(`[${new Date().toISOString()}] Generating QR for text: ${text.substring(0, 20)}...`);

  try {
    const qrImage = await QRCode.toDataURL(text);
    res.json({ qr: qrImage });
  } catch (err) {
    console.error('QR Error:', err);
    res.status(500).json({ error: 'Error while generating QR' });
  }
});


const PORT = process.env.PORT || 3001;

app.listen(PORT, '0.0.0.0', () => { // '0.0.0.0' asegura que escuche en todas las interfaces de red del contenedor
  console.log(`🚀 Backend ready on port ${PORT}`);
});