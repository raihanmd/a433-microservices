# Menggunakan image Node.js versi 18.20.8 dengan Alpine Linux 3.21
FROM node:lts-alpine

# Menetapkan direktori kerja di dalam container
WORKDIR /app

# Menyalin file package.json dan package-lock.json ke dalam container
COPY package*.json ./

# Menginstal dependensi yang terdaftar di package.json
RUN npm install

# Menyalin semua file dari direktori lokal ke dalam container
COPY . .

# Menjalankan aplikasi Node.js saat container dijalankan
CMD [ "node", "index.js" ]
