from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Would you like to play a game?"}
