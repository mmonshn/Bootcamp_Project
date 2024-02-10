const kafka = require("kafka-node");
const readline = require("readline");

const client = new kafka.KafkaClient({ kafkaHost: "localhost:9092" });
const producer = new kafka.Producer(client);

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

producer.on("ready", function() {
  console.log("Producer is ready");
  readInput();
});

function readInput() {
  rl.question("Enter the message (or type 'exit' to quit): ", function(message) {
    if (message.toLowerCase() === "exit") {
      rl.close();
      producer.close(() => {
        console.log("Producer has been closed.");
        process.exit(); // Exit the script
      });
    } else {
      send(message);
      readInput();
    }
  });
}

function send(message) {
  const payloads = [
    { topic: "node", messages: message, partition: 0 }
  ];
  producer.send(payloads, function(err, data) {
    if (err) {
      console.error("Error:", err);
    }
  });
}

producer.on("error", function(err) {
  console.error("Error:", err);
});