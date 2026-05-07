FROM python:3.10

WORKDIR /app

COPY . .

RUN pip install fastapi uvicorn pandas scikit-learn joblib

RUN python train.py

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
