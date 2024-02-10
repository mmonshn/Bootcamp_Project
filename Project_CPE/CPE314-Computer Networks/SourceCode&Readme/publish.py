import pandas as pd
import paho.mqtt.client as mqtt
import time as times
from datetime import datetime
import random

# Define MQTT broker settings
broker_address = "broker.hivemq.com"
broker_port = 1883
topic = "7am/mqtt"

# Read sensor data from Excel file
excel_file = ".\Sampleinput.xlsx"
data = pd.read_excel(excel_file, index_col=None)

# Publish sensor data to MQTT broker
def publish_data(client):
    for _, row in data.iterrows():
        # Generate random 4-digit node ID
        node_id = str(random.randint(1000, 9999))
        tor_IP = "tor01"
        # Get current time in the format yyyy-mm-dd hh:mm
        current_time = datetime.now().strftime("%Y-%m-%d %H:%M")

        # Create payload as a dictionary with sensor types as keys and values as lists
        payload = {
            "client_ip" : tor_IP,
            "node_id": node_id,
            "time": current_time,
            "relative_humidity": row["Humidity"],
            "temperature": row["Temperature"],
            "thermal_array": row["ThermalArray"]
        }

        # Convert payload to JSON and split into chunks of max 250 bytes
        payload_json = pd.Series(payload).to_json()
        payload_chunks = [payload_json[i:i+250] for i in range(0, len(payload_json), 250)]
       
        # Publish payload chunks to MQTT broker
        for chunk in payload_chunks:
            client.publish(topic, chunk)
        times.sleep(60)
    print("Sensor data published to MQTT broker.")
    

# Connect to MQTT broker and publish data every 3 minutes
client = mqtt.Client()
client.connect(broker_address, broker_port)
client.loop_start()
while True:
    publish_data(client)

    
   
client.loop_stop()
client.disconnect()