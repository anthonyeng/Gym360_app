import hashlib

password = "MyStrongAdminPass"
hashed = hashlib.sha256(password.encode()).hexdigest()

print("Hashed password:", hashed)
