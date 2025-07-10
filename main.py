from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware  
from database import Base, engine
from routers import users, auth, register

Base.metadata.create_all(bind=engine)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routers
app.include_router(users.router)
app.include_router(auth.router)
app.include_router(register.router)
