from sqlalchemy import Column, Integer, String, Enum, Text, ForeignKey, Date, DateTime
from sqlalchemy.sql import func
from database import Base
import enum

class RoleEnum(enum.Enum):
    user = "user"
    admin = "admin"

class ExpLevelEnum(enum.Enum):
    Beginner = "Beginner"
    Intermediate = "Intermediate"
    Advanced = "Advanced"

class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(100), unique=True, nullable=False)
    username = Column(String(50), nullable=False)
    password = Column(String(255), nullable=False)
    role = Column(Enum(RoleEnum), nullable=False)
    experience_level = Column(Enum(ExpLevelEnum), default=ExpLevelEnum.Beginner)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

class WorkoutResult(Base):
    __tablename__ = 'workout_results'
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'))
    date = Column(Date, nullable=False)
    result = Column(Text)

class CameraAccessLog(Base):
    __tablename__ = 'camera_access_logs'
    id = Column(Integer, primary_key=True)
    admin_id = Column(Integer, ForeignKey('users.id'))
    access_time = Column(DateTime(timezone=True), server_default=func.now())
    action_description = Column(Text)
