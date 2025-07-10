import cv2
import mediapipe as mp
import csv
import random
import os

# Init Mediapipe pose
mp_pose = mp.solutions.pose
pose = mp_pose.Pose(static_image_mode=True)

# Input folder of full-body images
INPUT_DIR = "gym360_backend/ai_model/sample_images"
os.makedirs(INPUT_DIR, exist_ok=True)

# Output CSV
CSV_FILE = "gym360_backend/ai_model/body_dataset.csv"

with open(CSV_FILE, mode="w", newline="") as f:
    writer = csv.writer(f)
    header = [f"x{i}" for i in range(33)] + [f"y{i}" for i in range(33)] + ["body_fat_percent"]
    writer.writerow(header)

    for filename in os.listdir(INPUT_DIR):
        if filename.lower().endswith((".jpg", ".png")):
            path = os.path.join(INPUT_DIR, filename)
            img = cv2.imread(path)
            img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

            results = pose.process(img_rgb)
            if results.pose_landmarks:
                landmarks = results.pose_landmarks.landmark
                x = [lm.x for lm in landmarks]
                y = [lm.y for lm in landmarks]

                # Simulated body fat % between 10–30%
                fake_fat = round(random.uniform(10, 30), 2)

                writer.writerow(x + y + [fake_fat])
                print(f"Processed {filename} → {fake_fat}%")
            else:
                print(f"No pose detected in {filename}")
