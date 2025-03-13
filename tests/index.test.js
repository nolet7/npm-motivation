import request from "supertest";
import express from "express";

// Create a basic Express app for testing
const app = express();
app.get("/", (req, res) => res.send("✨ Stay positive and work hard! ✨"));

describe("GET /", () => {
  it("should return a motivational message", async () => {
    const res = await request(app).get("/");
    expect(res.statusCode).toBe(200);
    expect(res.text).toBe("✨ Stay positive and work hard! ✨");
  });
});

