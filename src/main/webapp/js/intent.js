function classifyIntent(message) {
    // Get the words in the message.
    var words = message.split(' ');
  
    // Find the most common intent in the message.
    var intent = words.reduce((acc, word) => {
      if (acc[word] === undefined) {
        acc[word] = 0;
      }
      acc[word]++;
      return acc;
    }, {});
  
    // Find the most common intent in the dataset.
    var mostCommonIntent = Object.keys(intent).reduce((acc, intent) => {
      if (acc[intent] === undefined) {
        return intent;
      }
      return acc;
    }, undefined);
  
    // Return the most common intent.
    return mostCommonIntent;
  }

  // Create a dataset of messages and intents.
var dataset = [
    {
      message: 'I want to order a pizza',
      intent: 'order_pizza'
    },
    {
      message: 'I want to get directions',
      intent: 'get_directions'
    },
    {
      message: 'I want to book a flight',
      intent: 'book_flight'
    }
  ];
  
