# main.py
from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from . import models, database

models.Base.metadata.create_all(bind=database.engine)

app = FastAPI()

@app.get("/")
def read_root(db: Session = Depends(database.get_db)):
    # Example endpoint using the database session
    return {"message": "Hello World with Database"}
