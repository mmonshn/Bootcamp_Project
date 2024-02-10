const kafka = require("kafka-node");

const client = new kafka.KafkaClient({ kafkaHost: "localhost:9092" });

const topics = [
  {
    topic: "node"
  }
];
const options = {
  autoCommit: false
};

const consumer = new kafka.Consumer(client, topics, options);

consumer.on("message", function(message) {
  console.log("Received message:", message.value);
});

consumer.on("error", function(err) {
  console.error("Error:", err);
});

consumer.on("offsetOutOfRange", function(topic) {
  console.error("Offset out of range for topic:", topic);
});