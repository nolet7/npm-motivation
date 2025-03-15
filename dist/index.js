#!/usr/bin/env node

import express from "express";
import chalk from "chalk";

const app = express();

const quotes = [
    "Believe in yourself!",
    "Keep pushing forward!",
    "The best time to start is now!",
    "You are capable of amazing things!",
    "Stay positive and work hard!"
];

app.get("/", (req, res) => {
    const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];
    console.log(chalk.green(`\n✨ ${randomQuote} ✨\n`));
    res.send(`<h1>✨ ${randomQuote} ✨</h1>`);
});

// Server must listen on 0.0.0.0 inside Docker
const PORT = process.env.PORT || 3000;
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);
});
