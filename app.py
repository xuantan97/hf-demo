from fastapi import FastAPI
from pydantic import BaseModel
from transformers import pipeline

app = FastAPI()

generator = pipeline("text-generation", model="distilgpt2")

class Request(BaseModel):
    text: str

@app.post("/generate")
def generate(req: Request):
    result = generator(req.text, max_length=80, num_return_sequences=1)
    return {"output": result[0]["generated_text"]}

@app.get("/health")
def health():
    return {"status": "ok"}
